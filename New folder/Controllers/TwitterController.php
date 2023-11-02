<?php

namespace App\Http\Controllers;

use App\Models\Api;
use App\Models\settingsApi;
use Illuminate\Http\Request;
use Thujohn\Twitter\Twitter;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Plugrbase\TwitterApi\TwitterApi;
use Abraham\TwitterOAuth\TwitterOAuth;
use Laravel\Socialite\Facades\Socialite;
use Abraham\TwitterOAuth\TwitterOAuthException;
use Spatie\LaravelTwitterStreamingApi\TwitterStreamingApi;
use Firebase\JWT\JWT; // You may need to install a JWT library, e.g., firebase/php-jwt

class TwitterController extends Controller
{
    public function twitterRedirect()
    {
        $callback = route('twitter.callback');

        // consumer key and secret
        $twitterSettings = settingsApi::where('appType', 'twitter')->first(); 
        $apiKey = $twitterSettings['appID'];
        $apiSecret = $twitterSettings['appSecret'];
        
        $twitter_connect = new TwitterOAuth($apiKey, $apiSecret);
    
        $access_token = $twitter_connect->oauth('oauth/request_token',['oauth_callback'=>$callback]);

        $route = $twitter_connect->url('oauth/authorize',['oauth_token'=>$access_token['oauth_token']]);

        return redirect($route);
    }

    public function twitterCallback(Request $request)
    {
        $response = $request->all();
        
        $twitterSettings = settingsApi::where('appType', 'twitter')->first(); 
        $apiKey = $twitterSettings['appID'];
        $apiSecret = $twitterSettings['appSecret'];

        $oauth_token = $response['oauth_token'];
        $oauth_verifier = $response['oauth_verifier'];

        $twitter_connect = new TwitterOAuth($apiKey, $apiSecret, $oauth_token, $oauth_verifier);

        try {
           // Verify user token and get access token and secret
            $token = $twitter_connect->oauth('oauth/access_token',['oauth_verifier'=>$oauth_verifier]);

            $oauth_token = $token['oauth_token']; // access token
            $oauth_token_secret = $token['oauth_token_secret']; // token secret

            $userName = $token['screen_name'];
            $userId = $token['user_id'];
            $profileLink = "https://twitter.com/intent/user?user_id={$userId}";          

            $twitter = new TwitterOAuth($apiKey, $apiSecret, $oauth_token, $oauth_token_secret);

            // $userProfile = $twitter->get('users/show', ['user_id' => $userId]);
            // dd($userProfile);  
            // $profileImage = $userProfile->profile_image_url_https;
 
            $userData = [
                'creator_id'=> Auth::user()->id,
                'account_type' => 'twitter',
                'account_id' => $userId,
                'account_name' => $userName,
                'email' => $userName,
                // 'account_pic' => $profileImage,
                'account_link' => $profileLink,
                'token' => $oauth_token,
                'token_secret' => $oauth_token_secret ? $oauth_token_secret : '' 
            ];


            $existingApp = Api::where('account_id', $userId)->where('creator_id', Auth::user()->id)->first();

            if ($existingApp) {
                $existingApp->update($userData);
            } else {
                Api::create($userData);
            }

            return redirect()->route('socialAccounts.index');
            // return $this->postMessageToTwitter($oauth_token, $oauth_token_secret);
        } catch (TwitterOAuthException $e) {
            return redirect()->route('socialAccounts.index');
        }
        
    }
    


    public function show($twitterId) 
    {
        $twitterSettings = settingsApi::where('appType', 'twitter')->first(); 
        $consumer_key = $twitterSettings['appID'];
        $consumer_secret = $twitterSettings['appSecret'];

        $userData = Api::where('creator_id', Auth::user()->id)->where('account_id', $twitterId)->first();
        
        $screenName = $userData['account_name'];
        $oauth_token = $userData['token'];
        $oauth_token_secret = $userData['token_secret'];

        $connection = new TwitterOAuth($consumer_key, $consumer_secret, $oauth_token, $oauth_token_secret);
        
        $tweets = $connection->get('statuses/user_timeline', [
            'screen_name' => $screenName,
        ]);

        // dd($connection);

        $url = 'https://api.twitter.com/2/tweets?ids='. $twitterId;

        $bearerToken = 'AAAAAAAAAAAAAAAAAAAAANA4qwEAAAAAHp3%2FvqPcOxKmukvZEV5MoK4BKLI%3DdH1pHjiIYqMqUWSp5OHeRfOGOd28VA6pLxGYUkpDkqeqBRknpf';
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Authorization: Bearer '. $bearerToken
        ));
        $response = curl_exec($ch);
        if (curl_errno($ch)) {
            $error = curl_error($ch);
            curl_close($ch);
            return response()->json(['error' => $error], 500);
        }
        curl_close($ch);
        $data = json_decode($response, true);

        $twitter = new Twitter();
        $tweets = $twitter->getTweet();
        try {
            $tweets = $twitter->getTweet(['count' => 10]);
            Log::info('Tweets fetched successfully');
        } catch (\Exception $e) {
            Log::error('Error fetching tweets: ' . $e->getMessage());
        }

        dd($tweets);

        return view('social.twitter',compact('twitterId'));
    }



    public function twitterCallback2(Request $request)
    {
        $response = $request->all();
        
        // Load Twitter API settings from your database
        $twitterSettings = settingsApi::where('appType', 'twitter')->first(); 
        $apiKey = $twitterSettings['appID'];
        $apiSecret = $twitterSettings['appSecret'];
        
        $oauth_token = $response['oauth_token'];
        $oauth_verifier = $response['oauth_verifier'];
        
        $twitter_connect = new TwitterOAuth($apiKey, $apiSecret, $oauth_token, $oauth_verifier);
        
        // Verify user token and get access token and secret
        $token = $twitter_connect->oauth('oauth/access_token', ['oauth_verifier' => $oauth_verifier]);
        
        $oauth_token = $token['oauth_token']; // access token
        $oauth_token_secret = $token['oauth_token_secret']; // token secret
        
        // Use the obtained access token and token secret to fetch user data
        $twitter = new TwitterOAuth($apiKey, $apiSecret, $oauth_token, $oauth_token_secret);
        $userData = $twitter->get('account/verify_credentials', ['include_entities' => 'false', 'skip_status' => 'true']);
        
        // Now $userData contains user information, including name, profile picture, and ID
        $userName = $userData->name;
        $userProfilePicture = $userData->profile_image_url_https; // Use a secure URL
        $userId = $userData->id;
        
        // You can store or use this user data as needed
        
        // Redirect to the desired route or view
        return redirect()->route('socialAccounts');
        // Alternatively, you can return the user data if needed
        // return view('profile', compact('userName', 'userProfilePicture', 'userId'));
    }


    public function postMessageToTwitter($oauth_token, $oauth_token_secret)
    {
        $twitterSettings = settingsApi::where('appType', 'twitter')->first(); 
        $consumer_key = $twitterSettings['appID'];;
        $consumer_secret = $twitterSettings['appSecret'];
    
        $connection = new TwitterOAuth($consumer_key, $consumer_secret, $oauth_token, $oauth_token_secret);
        $connection->setApiVersion('2');
    
        $tweet = 'kkkk';
    
        $response = $connection->post('tweets', ['text' => $tweet]);

        return redirect()->route('socialAccounts');
    }
}

//to get bearer token
// $credentials = base64_encode($consumer_key . ':' . $consumer_secret);
// $auth_url = 'https://api.twitter.com/oauth2/token';
// $headers = array(
//     'Authorization: Basic ' . $credentials,
//     'Content-Type: application/x-www-form-urlencoded;charset=UTF-8',
// );
// $postfields = 'grant_type=client_credentials';
// $ch = curl_init();
// curl_setopt($ch, CURLOPT_URL, $auth_url);
// curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
// curl_setopt($ch, CURLOPT_POSTFIELDS, $postfields);
// curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
// curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// $result = curl_exec($ch);
// curl_close($ch);
// $response = json_decode($result, true);
// $bearerToken = $response['access_token'];

// $url = 'https://api.twitter.com/2/tweets?ids=1212092628029698048';

// $ch = curl_init();
// curl_setopt($ch, CURLOPT_URL, $url);
// curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// curl_setopt($ch, CURLOPT_HTTPHEADER, array(
//     'Authorization: Bearer '. $bearerToken
// ));
// $response = curl_exec($ch);
// if (curl_errno($ch)) {
//     $error = curl_error($ch);
//     curl_close($ch);
//     return response()->json(['error' => $error], 500);
// }
// curl_close($ch);
// $data = json_decode($response, true);
// _____________________________________________________________

// $twitterAppId = $userData['client_id'];
        // dd($userId, $userName);
        // 1708817086653386752, EvolveTeck

        // 'provider_id' => $userData->id,
        // 'name' => $userData->name,
        // 'username' => $userData->nickname,
        // 'email' => $userData->email,
        // 'avatar' => str_replace('http://','https://',$userData->avatar)


// public function postMessageToTwitter($oauth_token, $oauth_token_secret)
// {
    // $connection = new TwitterOAuth($apiKey, $apiSecret,$oauth_token, $oauth_token_secret);
    // $connection->setApiVersion('2');
    // $query = "tweets";
    // $queryParams['ids'] = "<comma separated ids in a string>";
    // $response = $connection->get($query, $queryParams);
    // dd($response);
    
    // ___________________________

    // $url = 'https://api.twitter.com/1.1/statuses/update.json?status=hello%20world';
    // $ch = curl_init();
    // curl_setopt($ch, CURLOPT_URL, $url);
    // curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    // $response = curl_exec($ch);
    // if (curl_errno($ch)) {
    //     $error = curl_error($ch);
    //     curl_close($ch);
    //     return response()->json(['error' => $error], 500);
    // }
    // curl_close($ch);
    // $data = json_decode($response, true);
    // dd($data);

    // ___________________________

    // $push = new TwitterOAuth($apiKey, $apiSecret,$oauth_token, $oauth_token_secret);
    // $push->setTimeouts(10, 15);
    // $push->post('statuses/update', ['status'=>'Hello']);

    // if ($push->getLastHttpCode() == 200) {
    //     dd(true);
    // } else {
    //     dd(false);
    // }
    // return redirect()->route('socialAccounts');
// }
