<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Api;
use App\Models\settingsApi;
use Illuminate\Support\Facades\Auth;
use Abraham\TwitterOAuth\TwitterOAuth;
use Abraham\TwitterOAuth\TwitterOAuthException;

class TwitterController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }


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

            return response()->json([
                'message' => 'Account saved',
                'data' => $userData,
                'status' => true
            ],200);
            
        } catch (TwitterOAuthException $e) {
            return response()->json([
                'message' => $e->getMessage(),
                'status' => true
            ],500);
        }
        
    }
}
