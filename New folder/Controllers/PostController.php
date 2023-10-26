<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Google_Client;
use App\Models\Api;
use App\Models\User;
use Facebook\Facebook;
use App\Models\Instagram;
use App\Models\time_think;
use App\Models\publishPost;
use App\Models\settingsApi;
use Google_Service_YouTube;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Madcoda\Youtube\Youtube;
use Google_Service_Exception;
use App\Models\youtube_category;
use Google_Service_YouTube_Video;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Intervention\Image\Facades\Image;
use Abraham\TwitterOAuth\TwitterOAuth;
use Illuminate\Support\Facades\Schema;
use Google_Service_YouTube_VideoStatus;
use Illuminate\Support\Facades\Storage;
use Google_Service_YouTube_VideoSnippet;
use Facebook\Exceptions\FacebookSDKException;
use ProtoneMedia\LaravelFFMpeg\Support\FFMpeg;
use Facebook\Exceptions\FacebookResponseException;

class PostController extends Controller
{
    public function posts()
    {
        return view('AdminSocialMedia.posts');
    }

    public function chartJS(Request $request,$userId)
    {
        $startDate = now()->subDays(9);
        
        if($request)
        {
            $startDate = $request->input('selectedDate');
        }
        
        $Publish_Post = publishPost::where('status', 'published')->where('creator_id', $userId)
            ->where('scheduledTime', '>=', $startDate)->get();
        
        return $Publish_Post;
    }

    public function updateInterval(Request $request)
    {
        $data = Api::where('creator_id', Auth::user()->id)->get();

        if ($data->isNotEmpty()) {
            foreach ($data as $record) {
                $record->update([
                    'update_interval' => $request->update_interval,
                ]);
            }
            
            return redirect()->back()->with('timeUpdated', 'Time saved successfully');
        } else {
            return redirect()->back()->with('timeUpdated', 'No records found for the authenticated user.');
        }
    }

    public function updatePostsTime()
    {
        return view('AdminSocialMedia.updatePostsTime');
    }

    public function schedulePosts()
    {
        return view('AdminSocialMedia.schedulePosts');
    }

    public function updatePostsNow()
    {
        return view('AdminSocialMedia.updatePostsNow');
    }

    public function historyPosts()
    {
        $columns =  Schema::getColumnListing('publish_posts');
        return view('AdminSocialMedia.historyPosts',compact('columns'));
    }

    // public function publishPostServices()
    // {
    //     return view('AdminSocialMedia.publishPostServices');
    // }

    public function removeSocialPost($id)
    {
        $post = publishPost::findOrFail($id);
        $post->delete();
        return Redirect()->back()->with('postDeleted','post deleted successfully');
    }

    public function repostEdit($id) {
        $post = publishPost::findOrFail($id);
        return view('AdminSocialMedia.repost',compact('post'));
    }

    public function update(Request $request,$id)
    {
        publishPost::where('id',$id)->update([
            // update all except image
        ]);

        if($request->hasfile('image')){
            $file = $request->file('image');
            $ext = $file->getClientOriginalExtension();
            $filename = time().'.'.$ext;
            $img = $file->move('postImages/',$filename);
           
            publishPost::where('id',$id)->update([
                'image'=> $img
            ]);
        }
    }

    public function removeAccount($userId) 
    {
        Api::where('account_id',$userId)->delete(); // account_id => unique

        return redirect()->route('socialAccounts')->with('accountDeleted','Account deleted successfully');
    }

    public function accountPages() 
    {
        $faceToken = '';
        $pages = '';
       
        if(Api::count() != 0){
            if($appSetting = Api::where('account_type', 'facebook')->where('creator_id', Auth::user()->id)->first()){
                $faceToken = $appSetting['token'];
    
                $response = Http::get("https://graph.facebook.com/v12.0/me/accounts?access_token={$faceToken}");
                $pages = $response->json()['data'];
            }
        }

        return view('AdminSocialMedia.publishPost',compact('pages'));
    }
    

    public function storePosts(Request $request) 
    { 
        $validated = $request->validate([
            'postData' => 'max:5000',
        ]);

        $accountsID = $request->accounts_id;
        $accountsType = [];
        $accounts = '';
        
        $accountsData = [];

        foreach($accountsID as $id){
            $accounts = Api::where('account_id',$id)->where('creator_id', Auth::user()->id)->get();
            foreach($accounts as $account){
                if($account['account_type'] == 'youtube'){
                    $request->validate([
                        'videoTitle' => 'required',
                        'video' => 'required',
                    ]);
                }
                if($account['account_type'] != 'youtube'){
                    $request->validate(['postData' => 'required']);
                }

                $account_type = $account->account_type;
                $accountData = [
                    'creator_id'=> Auth::user()->id,
                    'account_type' => $account->account_type,
                    'account_id' => $account->account_id,
                    'account_name' => $account->account_name,
                    'tokenApp' => $account->token,
                    'token_secret' => $account->token_secret
                ];
            }   
            $accountsType[] = $account_type;
            $accountsData[] = $accountData;        
        }

        $allApps = Api::all()->where('creator_id', Auth::user()->id);
        $appID = [];
        foreach($allApps as $app){
            $appID[] = $app['account_id'];
        }

        $selectedApps = $request->input('accounts_id'); // from form
        $selectedApps = array_intersect($selectedApps, $appID);

        $img = null;
        $publishPosts = [];

        $filename = '';
        if ($request->hasfile('image')) 
        {
            $file = $request->file('image');
            $ext = $file->getClientOriginalExtension();
            $filename = time().'.'.$ext;
            // $img = $file->move('postImages/',$filename); 
            $img = Image::make($file->getRealPath());
            $img->fit(100); // fit(100,100) -> 100x100
            $img = $img->save('postImages/'.$filename); 
        }


        $commpressedVideoPath= '';
        if ($request->hasfile('video')) 
        {
            $video = $request->file('video');
            $filename = $video->getClientOriginalName();
            $storagePath = 'uploadVideos';
            if (!Storage::exists($storagePath)) {
                Storage::makeDirectory($storagePath);
            }

            $video->storeAs($storagePath, $filename);
            $videoPath = $storagePath . '/' . $filename;

            $newVideo = FFMpeg::fromDisk('local')->open($videoPath)->addFilter(function ($filters) {
                $filters->resize(new \FFMpeg\Coordinate\Dimension(2000, 2000));
            });

            $commpressedVideoPath = $storagePath . '/' . 'compressed_' . $filename;

            $newVideo->export()
            ->toDisk('local')
            ->inFormat(new \FFMpeg\Format\Video\X264())
            ->save($storagePath . '/' . 'compressed_' . $filename);
        }


        if($request->scheduledTime){
            $postTime =  Carbon::parse($request->scheduledTime)->format('Y-m-d H:i');
            $status = 'pending';
        }
        else{
            $now = Carbon::now(); 
            $diff_time = time_think::where('creator_id', Auth::user()->id)->first()->time;
            $postTime = $now->copy()->addHours($diff_time)->format('Y-m-d H:i');
            $status = 'published';
            $publishPosts[] = $this->publishPost($request, $img,$commpressedVideoPath);
        }

        $successfulApps = []; // apps that return 'postCreated' and not error
        $messages = [];
        
        foreach ($publishPosts[0] as $appName => $appResults) {
            switch ($appResults) {
                case 'postCreated':
                    $successfulApps[] = $appName;
                    $msg = '- '.$appName.' : The post created successfully.';
                    break;
                default:
                    $msg = '- '.$appName.' : There exist an error.';
                    break;
            }
            $messages[] = $msg;
        }

        $data = [];
        $allAccountsData = [];
        foreach($accountsData as $account){
            $account['status'] = $status;
            $account['content'] = $request->postData;
            $account['link'] = $request->link;
            $account['scheduledTime'] = $postTime;

            $allAccountsData[] = $account;
        }

        $selectedApps = array_intersect($accountsType, ['facebook', 'instagram', 'twitter','youtube']);

        foreach ($selectedApps as $appType) {
            if (in_array($appType, $successfulApps) || $status == 'pending') // if appType in successefullApp means that post created and not failed
            {
                foreach($allAccountsData as $account){
                    switch ($appType) {
                        case 'facebook':
                            $account['thumbnail'] = $img;
                            break;
                        case 'instagram':
                            $account['thumbnail'] = $img;
                            break;
                        case 'twitter':
                            $account['thumbnail'] = $img;
                            break;
                        case 'youtube':
                            $account['thumbnail'] = $videoPath;
                            $account['post_title'] = $request->videoTitle;
                            $account['youtube_privacy'] = $request->youtubePrivacy;
                            $account['youtube_tags'] = $request->youtubeTags;
                            $account['youtube_category'] = $request->youtubeCategory;
                            break;
                    }
                    $data[] = $account;
                }
            }
        }

        if (!empty($data)) {
            foreach($data as $post){
                publishPost::create($post);
            } 
        }
        
        return redirect()->back()->with('postStatusForPublishing', $messages);
    }

    public function publishPost($requestData, $img,$videoPath) 
    {
        $allApps = settingsApi::all();
        $appsType = [];
        foreach($allApps as $app){
            $app_type = $app->appType;
            $appsType[] = $app_type;
        }

        $accountsID = $requestData->accounts_id;
        $selectedApps=[];
        foreach($accountsID as $id){
            $accounts = Api::where('account_id',$id)->where('creator_id', Auth::user()->id)->get();
            foreach($accounts as $account){
                $account_type = $account->account_type;
            }
            $selectedApps[] = $account_type;
        }

        // Create an array of app types based on the selected apps
        $selectedApps = array_intersect($selectedApps, $appsType);
        $data = []; 
        // Loop through the selected app types and build the $data array
        foreach ($selectedApps as $appType) {
            $appRes = '';
            switch ($appType) {
                case 'facebook':
                    $facePublish = $this->facePublish($requestData,$img);
                    $appRes = $facePublish;
                    break;
                case 'instagram':
                    $insta = $this->instaPublish($requestData);
                    $appRes = $insta;
                    break;
                case 'twitter':
                    $twitter = $this->twitterPublish($requestData, $img);
                    $appRes = $twitter;
                    break;
                case 'youtube':
                    $yotutbe = $this->youtubePublish($requestData,$videoPath);
                    $appRes = $yotutbe;
                    break;
            }
            // $data[] = $appRes;
            $data[] = [$appType, $appRes];
        }
 
        $appResults = [];
        foreach ($data as [$appType, $appRes]) {
            $appResults[$appType] = $appRes; // associative array
        }

        return $appResults;
    }
 
    public function facePublish($requestData,$img)
    {
        // dd($requestData);
        $faceToken = '';
        $pageName = $requestData->page;
        $pageToken = null; 
        $pageId = null;
        $urlImage = '';

        $response = Http::get("https://graph.facebook.com/v12.0/me/accounts?access_token={$faceToken}");
        $pages = $response->json()['data'];

        $desiredPage = null;

        foreach ($pages as $page) {
            if ($page['name'] === $pageName) {
                $desiredPage = $page;
                $pageToken = $desiredPage['access_token'];
                $pageId = $desiredPage['id'];
                break;
            }
        }

        $fb = new Facebook([
            'app_id' => config('services.facebook.client_id'),
            'app_secret' => config('services.facebook.client_secret'),
            'default_graph_version' => 'v12.0', // Use the appropriate version
        ]);
        
        $fb->setDefaultAccessToken($pageToken);
        
        $permissions = 
        [
            'pages_show_list',
            'pages_read_engagement',
            'pages_manage_posts',
            'pages_manage_ads',
            'pages_manage_cta',
            'pages_manage_metadata'
        ];
        
        try {

            $url = "https://graph.facebook.com/v12.0/{$pageId}/feed";

            // if (!empty($images)) {
            //     foreach ($images as $img) {
            //         $filename = Str::replace('postImages\\', '', $img);
            //         $response = Http::attach(
            //             'source',
            //             file_get_contents($img),
            //             $filename
            //         )->post("https://graph.facebook.com/v12.0/{$pageId}/photos", [
            //             'message' => $requestData->postData,
            //             'privacy' => '{"value": "EVERYONE"}',
            //             'access_token' => $pageToken,
            //         ]);
            //     }
            // }

            // if (!empty($images)) {
            //     $attachedMedia = [];
            //     foreach ($images as $img) {
            //         $filename = Str::replace('postImages\\', '', $img);
            //         $attachedMedia[] = [
            //             'media_type' => 'IMAGE',
            //             'media' => [
            //                 'file' => file_get_contents($img),
            //                 'filename' => $filename,
            //             ],
            //         ];
            //     }
            // }

            if ($img != null) {
                $filename = Str::replace('postImages\\', '', $img);
                $response = Http::attach(
                    'source',
                    file_get_contents($img),
                    $filename
                )->post("https://graph.facebook.com/v12.0/{$pageId}/photos", [
                    'message' => $requestData->postData,
                    'privacy' => '{"value": "EVERYONE"}',
                    'access_token' => $pageToken,
                ]);
            }
            else {
                $response = Http::post($url, [
                    'message' => $requestData->postData,
                    'link' => $requestData->link,
                    // 'privacy' => '{"value": "EVERYONE"}',
                    'access_token' => $pageToken,
                ]);
            }
            
            $response = $response->json();

            return 'postCreated';

        } catch(FacebookResponseException $e) {
            return 'Graph returned an error: ' . $e->getMessage();
        } catch(FacebookSDKException $e) {
            return 'Facebook SDK returned an error: ' . $e->getMessage();
        }
    }


    public function instaPublish($requestData)
    {
        $instaToken = '';
        // 17841458134934475 -> id evolve
        // 17841453423356345/media?image_url=https://i.ibb.co/j5jStSm/photo2.png
        // 17841453423356345/media_publish?creation_id=17989019528213233
        $accessToken = 'EAAS9OZAZBDis4BO9EwYkPxfZAr7ZCq0qiI0XMibHk4eMYN6jHDTZC0B43lned3EL9ZCEPROCWgdLKe81lELqjIiZBgZAHBjCb5Ys6bZClGzcsZAxGsApn1DA2rcjFrCCC8xltvo3ioZCkqb2tai3jXuyJbuFbru4s3Nojjf8a4QXxfusOekfwjatgUeYgrgB0EYtSUXBpzl8vBeuZCnUbMmTkAZDZD'; // Replace with your actual access token
        $pageId = '17841453423356345';
        $imageUrl = 'https://i.ibb.co/j5jStSm/photo2.png';
        $caption = $requestData->postData;

        try {

            if ($requestData->hasfile('image')) {
                $file = $requestData->file('image');
                $ext = $file->getClientOriginalExtension();
                $filename = time().'.'.$ext;
                // $img = $file->move('postImages/',$filename); 

                $mediaResponse = Http::post("https://graph.facebook.com/v17.0/{$pageId}/media", [
                    'image_url' => $imageUrl,
                    'caption' => $caption,
                    'access_token' => $accessToken,
                ]);

                
                if ($mediaResponse->successful()) {

                    $mediaData = $mediaResponse->json();
                    $mediaId = $mediaData['id'];
                    
                    if ($requestData->scheduledTime) {
                        // If you want to schedule the post
                        $scheduledTime = Carbon::parse($requestData->scheduledTime)->timestamp;
                        // Step 2: Publish media
                        $publishResponse = Http::post("https://graph.facebook.com/v17.0/{$pageId}/media_publish", [
                            'published' => false,
                            'scheduled_publish_time' => $scheduledTime,
                            'creation_id' => $mediaId,
                            'access_token' => $accessToken,
                        ]);
                    }
                    else{
                        $publishResponse = Http::post("https://graph.facebook.com/v17.0/{$pageId}/media_publish", [
                            'creation_id' => $mediaId,
                            'access_token' => $accessToken,
                        ]);
                    }    
    
                    if ($publishResponse->successful()) {
                        return 'postCreated';
                    } else {
                        return $publishResponse->status();
                    }
                } else {
                    return $mediaResponse->status();
                }
            }
            else {
                return'should choose image for instagram';
            }

        } catch (\Exception $e) {
            return $e->getMessage();
        }
    }


    public function twitterPublish($requestData, $img)
    {   
        $accountsID = $requestData->accounts_id;
        $twitterToken='';$twitterTokenSecret='';

        foreach($accountsID as $id){
            $accounts = Api::where('account_type', 'twitter')->where('account_id',$id)->where('creator_id', Auth::user()->id)->get();
            foreach($accounts as $account)
            {
                $twitterToken = $account->token;
                $twitterTokenSecret = $account->token_secret;
            }       
        }

        $twitterSettings = settingsApi::where('appType', 'twitter')->first(); 
        $consumer_key = $twitterSettings['appID'];
        $consumer_secret = $twitterSettings['appSecret'];
    
        $connection = new TwitterOAuth($consumer_key, $consumer_secret, $twitterToken, $twitterTokenSecret);
        $connection->setApiVersion('2');
        $connected = $connection->get("account/verify_credentials");

        $tweet = $requestData['postData'];

        $response = $connection->post('tweets', ['text' => $tweet]);
        
        if ($connection->getLastHttpCode() === 201) { // HTTP status code 201 indicates a successful tweet creation
            return 'postCreated';
        } else {
            return 'postFailed';
        }

        // $realPath = Str::replace('\\', '/', $realPath);
        // dd($realPath);
    }


    public function youtubePublish($requestData, $videoPath)
    {
        $accountsID = $requestData->accounts_id;
        $refreshToken='';

        foreach($accountsID as $id){
            $accounts = Api::where('account_type', 'youtube')->where('account_id',$id)->where('creator_id', Auth::user()->id)->get();
            foreach($accounts as $account)
            {
                $refreshToken = $account->token_secret;
            }       
        }

        $youtubeSettings = settingsApi::where('appType', 'youtube')->first();

        $client = new Google_Client();
        $client->setClientId($youtubeSettings['appID']);
        $client->setClientSecret($youtubeSettings['appSecret']);
        $client->setRedirectUri(route('youtube.callback'));
        $client->setScopes(['https://www.googleapis.com/auth/youtube.upload']);

        $client->fetchAccessTokenWithRefreshToken($refreshToken);
        $newAccessToken = $client->getAccessToken();
        $videoPath = storage_path('app/' . $videoPath);
        $fullPathToVideo = Str::replace('\\', '/', $videoPath);

        $youTubeService = new Google_Service_YouTube($client);

        $tags = !empty($requestData->youtubeTags) ? explode(',', $requestData->youtubeTags) : ['tag1', 'tag2'];
        $category_id = !empty($requestData->youtubeCategory) ? $requestData->youtubeCategory : '22';

        if($client->getAccessToken()) {
            $snippet = new Google_Service_YouTube_VideoSnippet();
            $snippet->setTitle($requestData->videoTitle);
            $snippet->setDescription($requestData->postData);
            // $snippet->setTags(array("tag1","tag2"));
            $snippet->setTags($tags);
            $snippet->setCategoryId($category_id);
            $snippet->setChannelId($requestData->channel);
        
            $status = new Google_Service_YouTube_VideoStatus();
            $status->privacyStatus = $requestData->youtubePrivacy ? $requestData->youtubePrivacy : 'public';
        
            $video = new Google_Service_YouTube_Video();
            $video->setSnippet($snippet);
            $video->setStatus($status);

            try {
                $obj = $youTubeService->videos->insert("status,snippet", $video,
                                                array("data"=>file_get_contents($fullPathToVideo), 
                                                "mimeType" => "video/*"));
                return 'postCreated';
            } catch(Google_Service_Exception $e) {
                // dd ("Caught Google service Exception ".$e->getCode(). " message is ".$e->getMessage(). " <br>");
                // dd ("Stack trace is ".$e->getTraceAsString());
                return 'postFailed';
            }
        }
    }    

    public function checkVideoStatus($videoId)
    {
        $youtubeSettings = settingsApi::where('appType', 'youtube')->first();          
        $client = new Google_Client();
        $client->setClientId($youtubeSettings['appID']);
        $client->setClientSecret($youtubeSettings['appSecret']);
        $client->setScopes('https://www.googleapis.com/auth/youtube.upload');
        $client->setRedirectUri(route('youtube.callback'));
        $state = bin2hex(random_bytes(16));
        $client->setState($state);
        $youtube = new Google_Service_YouTube($client);

        // Define the part(s) you want to retrieve (in this case, we want status)
        $part = 'status';

        // Call the videos->list method with the video ID and part(s) specified
        $videoResponse = $youtube->videos->listVideos($part, array('id' => $videoId));

        // Check if there is a valid response
        if ($videoResponse->items && count($videoResponse->items) > 0) {
            $video = $videoResponse->items[0];
            $status = $video->status;

            // You can now check the video status
            $uploadStatus = $status->uploadStatus;
            $privacyStatus = $status->privacyStatus;

            if ($uploadStatus === 'processed' && $privacyStatus === 'public') {
                // The video has been successfully published and is public.
                return "Video is published and public.";
            } else {
                // The video is not yet processed, or it's not public.
                return "Video is not yet processed or not public.";
            }
        } else {
            // No video found with the provided ID.
            return "Video not found.";
        }
    }


    // $response = Http::attach('image', $realPath)->post("<endpoint>", [
    //     "fileName" => $fileName
    // ]);
    // dd($response);

    // $response = $connection->getLastHttpCode();
    // dd($connected);
    
    // $bearerToken = $connection->oauth2('oauth2/token', ['grant_type' => 'client_credentials']);

    // if ($bearerToken) {
    //     if ($requestData->hasFile('image')) {
    //         $file = $requestData->file('image');
    //         $ext = $file->getClientOriginalExtension();
    //         $filename = time() . '.' . $ext;

    //         $client = new Client();

    //         $response = $client->post('https://upload.twitter.com/1.1/media/upload.json', [
    //             'headers' => [
    //                 'Authorization' => 'Bearer ' . $bearerToken->access_token, // Convert to string
    //             ],
    //             'multipart' => [
    //                 [
    //                     'name' => 'media',
    //                     'contents' => fopen($file->getRealPath(), 'r'),
    //                     'filename' => $filename,
    //                 ],
    //             ],
    //         ]);
    //         $media = json_decode($response->getBody());
    //         dd($media);
    //     }    
    // }

    // Check if media upload was successful
    // $media = json_decode($response->getBody());

    // $media = $connection->upload('media/upload', ['media' => $realPath]);
    // dd($media);

        

    // Step 1: Upload the media (image)
    // $media = $connection->upload('media/upload', ['media' => '/path/to/your/image.jpg']);

    // if ($connection->getLastHttpCode() !== 200) {
    //     // Handle media upload failure here
    //     return 'mediaUploadFailed';
    // }

    // // Step 2: Create a tweet with the uploaded media
    // $params = [
    //     'status' => $tweet,
    //     'media_ids' => $media->media_id_string, // Attach the uploaded media to the tweet
    // ];

    // $response = $connection->post('statuses/update', $params);

    // if ($connection->getLastHttpCode() === 200) {
    //     // HTTP status code 200 indicates a successful tweet creation
    //     return 'postCreated';
    // } else {
    //     // Handle tweet creation failure here
    //     return 'postFailed';
    // }



    // $image = [];

// $media = $connection->upload('media/upload', ['media' => 'image/test.jpg']);
// array_push($image, $media->media_id_string);

// $data =  [
//     'text' => 'Hello world',
//     'media'=> ['media_ids' => $image]
// ];


// $connection->setApiVersion('2');
// $content = $connection->post("tweets", $data, true);

// var_dump($content);


    // foreach ($request->images as $key => $value) {
    //     $uploaded_media = Twitter::uploadMedia(['media' => File::get($value->getRealPath())]);
    //     if(!empty($uploaded_media)){
    //         $newTwitte['media_ids'][$uploaded_media->media_id_string] = $uploaded_media->media_id_string;
    //     }




//     $connection = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, OAUTH_TOKEN, OAUTH_SECRET);
// $media1 = $connection->upload('media/upload', ['media' => '/path/to/file/kitten1.jpg']);
// $media2 = $connection->upload('media/upload', ['media' => '/path/to/file/kitten2.jpg']);
// $parameters = [
//     'status' => 'Hello Word with Images!',
//     'media_ids' => implode(',', [$media1->media_id_string, $media2->media_id_string])
// ];
// $result = $connection->post('statuses/update', $parameters);


    // public function instaPublish($requestData)
    // {
    //     $accessToken = 'EAAS9OZAZBDis4BO11LOZBmZAsfJRb1ZB7X0XgLOjJbP2aoZAdjjVWnonOREEVsi9CTV5WRIGVPi5WQJxUZBwNZBisLrWbVtxuojjQBgNAZC2sApJunxhPCPDzQwMhQ5bDLNkmQImq1kFH1iZBb3l8ANHFnidSMBNUIXjBj1k5ZAHLw1HRGZBns2qyLe9PifFkVagZAs8ESqveB3LXq0E20J3oNghktWG2URWgQOdQkHx3uhDhsr85hvB4X1WZCIb5d8huIZBAZDZD';
    //     $pageId = '17841453423356345';
    //     $caption = $requestData->postData;

    //     try {
    //         if ($requestData->hasFile('image')) {
    //             $file = $requestData->file('image');
    //             $mediaResponse = Http::attach(
    //                 'image',
    //                 file_get_contents($file->path()),
    //                 $file->getClientOriginalName()
    //             )->post("https://graph.facebook.com/v12.0/{$pageId}/photos", [
    //                 'caption' => $caption,
    //                 'access_token' => $accessToken,
    //             ]);

    //             // dd($mediaResponse);
    //             if ($mediaResponse->successful()) {
    //                 return 'postCreated';
    //             } else {
    //                 return redirect()->route('adminSocail')->with('publishError', $mediaResponse->status());
    //             }
    //         } else {
    //             return redirect()->route('adminSocail')->with('publishError', 'You should choose an image for Instagram');
    //         }
    //     } catch (\Exception $e) {
    //         return redirect()->route('adminSocail')->with('publishError', $e->getMessage());
    //     }
    // }
}
