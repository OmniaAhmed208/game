<?php

namespace App\Http\Controllers\api;

use Carbon\Carbon;
use App\Models\PublishPost;
use App\Models\settingsApi;
use Illuminate\Http\Request;
use App\Services\PostService;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Intervention\Image\Facades\Image;
use Illuminate\Support\Facades\Storage;
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
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $post = PublishPost::where('id', $id)->where('creator_id', Auth::user()->id)->first();

        if($post == null){
            return response()->json([
                'message' => 'Post not found',
                'status' => false
            ],404);
        }

        return response()->json([
            'message' => 'Post found',
            'data' => $post,
            'status' => true
        ],200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id,PostService $postService)
    {
        $post = PublishPost::where('id', $id)->where('creator_id', Auth::user()->id)->first();

        if($post == null){
            return response()->json([
                'message' => 'Post not found',
                'status' => false
            ],404);
        }

        if($post['status'] == 'pending'){

            $img = '';
            if ($request->hasFile('image')) 
            {
                $file = $request->file('image');
                $ext = $file->getClientOriginalExtension();
                $filename = time().'.'.$ext;
                // $img = $file->move('postImages/',$filename); 
                $img = Image::make($file->getRealPath());
                $img->fit(100); // fit(100,100) -> 100x100
                // $img = $img->save('postImages/'.$filename); 
                $storagePath = 'uploadImaged';
                if (!Storage::exists($storagePath)) {
                    Storage::makeDirectory($storagePath);
                }
                $img = $img->storeAs($storagePath, $filename);
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

            $post->content = $request->postData;
            $post->link = $request->link;
            
            $diff_time = time_think::where('creator_id', Auth::user()->id)->first()->time;
            $now = Carbon::now()->addHours($diff_time)->format('Y-m-d H:i');
            $scheduledTime = Carbon::parse($request->scheduledTime)->format('Y-m-d H:i');
            if ($scheduledTime > $now){
                $post->status = 'pending';
                $post->scheduledTime =  Carbon::parse($request->scheduledTime)->format('Y-m-d H:i');
            }
            else{
                return response()->json([
                    'message' => 'The time must be after to now '. $now
                ], 400);
            }

            switch ($post['account_type']) {
                case 'facebook':
                    $post->thumbnail = $img;
                    break;
                case 'instagram':
                    $post->thumbnail = $img;
                    break;
                case 'twitter':
                    $post->thumbnail = $img;
                    break;
                case 'youtube':
                    $post->thumbnail = $videoPath;
                    $post->post_title = $request->videoTitle;
                    $post->youtube_privacy = $request->youtubePrivacy;
                    $post->youtube_tags = $request->youtubeTags;
                    $post->youtube_category = $request->youtubeCategory;
                    break;
            }

            $post->save();

            return response()->json([
                'message' => 'Post updated successfully',
                'data' => $post, 
                'status' => true
            ], 200);
        }

        return response()->json([
            'message' => "Can't edit or remove because it already publihed",
            'status' => true
        ],200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $post = PublishPost::where('id', $id)->where('creator_id', Auth::user()->id)->first();

        if($post == null){
            return response()->json([
                'message' => 'Post not found',
                'status' => false
            ],404);
        }

        return response()->json([
            'message' => 'Post deleted successfully',
            'status' => true
        ],200);
    }

}
