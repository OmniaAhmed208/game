<?php

namespace App\Http\Controllers\api;

use Carbon\Carbon;
use App\Models\Api;
use App\Models\PublishPost;
use App\Models\settingsApi;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Intervention\Image\Facades\Image;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use ProtoneMedia\LaravelFFMpeg\Support\FFMpeg;
use App\Models\time_think;

class PostController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $Allpost = PublishPost::all()->where('creator_id', Auth::user()->id);
        $published_post = PublishPost::all()->where('status', 'published')->where('creator_id', Auth::user()->id);
        $scheduled_post = PublishPost::all()->where('status', 'pending')->where('creator_id', Auth::user()->id);
        $services = settingsApi::all();
        $groupedPosts = $Allpost->groupBy('scheduledTime'); // for same raw intable have same similar rows and colect all apps together

        return response()->json([
            'data' => [
                'allPosts' => $Allpost,
                'published_post' => $published_post,
                'scheduled_post' => $scheduled_post,
                'allApps' => $services,
                'groupedPosts' => $groupedPosts,
            ],
            'status' => true
        ],200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $accountsID = $request->accounts_id;
        $accountsType = [];
        $accountsData = [];

        foreach ($accountsID as $id) {
            $accounts = Api::where('account_id', $id)->where('creator_id', Auth::user()->id)->get();

            foreach ($accounts as $account) {
                $validator = $this->getValidatorForAccountType($account['account_type'], $request);

                if ($validator->fails()) {
                    return response()->json([
                        'message' => 'Validation error',
                        'errors' => $validator->errors(),
                        'status' => false
                    ], 200);
                }

                $accountData = [
                    'creator_id' => Auth::user()->id,
                    'account_type' => $account->account_type,
                    'account_id' => $account->account_id,
                    'account_name' => $account->account_name,
                    'tokenApp' => $account->token,
                    'token_secret' => $account->token_secret
                ];

                $accountsType[] = $account->account_type;
                $accountsData[] = $accountData;
            }
        }

        $allApps = Api::all()->where('creator_id', Auth::user()->id);
        $appID = $allApps->pluck('account_id')->toArray();

        $selectedApps = $request->input('accounts_id');
        $selectedApps = array_intersect($selectedApps, $appID);

        $img = null;
        $publishPosts = [];

        if ($request->hasFile('image')) 
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
        if ($request->hasFile('video')) 
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

        $postTime = $this->getPostTime($request);
        $status = $postTime ? 'pending' : 'published';

        $publishPosts = $this->publishPosts($request, $img, $commpressedVideoPath, $status);

        $messages = $this->formatPublishMessages($publishPosts);

        $data = $this->preparePostData($request, $img, $videoPath, $status, $accountsData, $selectedApps);

        $this->storePublishPosts($data);

        return response()->json(['message' => 'Posts created successfully', 'status' => true]);
    }

    private function getValidatorForAccountType($accountType, $request)
    {
        if ($accountType == 'youtube') {
            return Validator::make($request->all(), [
                'videoTitle' => 'required',
                'video' => 'required',
                'postData' => 'max:5000'
            ]);
        } elseif ($accountType == 'instagram') {
            return Validator::make($request->all(), [
                'image' => 'required',
                'postData' => 'max:5000'
            ]);
        }

        return Validator::make($request->all(), ['postData' => 'required|max:5000']);
    }

    private function getPostTime($request)
    {
        if ($request->scheduledTime) {
            return Carbon::parse($request->scheduledTime)->format('Y-m-d H:i');
        } else {
            $now = Carbon::now();
            $diff_time = time_think::where('creator_id', Auth::user()->id)->first()->time;
            return $now->copy()->addHours($diff_time)->format('Y-m-d H:i');
        }
    }

    private function publishPosts($request, $img, $commpressedVideoPath, $status)
    {
        // Implement the logic for publishing posts here and return the results.
    }

    private function formatPublishMessages($publishPosts)
    {
        // Format messages based on the results of publishing posts.
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
    }

    private function preparePostData($request, $img, $videoPath, $status, $accountsData, $selectedApps)
    {
        // Prepare post data based on the selected apps and status.
    }

    private function storePublishPosts($data)
    {
        if (!empty($data)) {
            publishPost::insert($data);
        }
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
}
