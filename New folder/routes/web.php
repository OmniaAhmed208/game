<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UserController;
use Laravel\Socialite\Facades\Socialite;
use App\Http\Controllers\AccountController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\TwitterController;
use App\Http\Controllers\YoutubeController;
use App\Http\Controllers\FacebookController;
use App\Http\Controllers\InstagramController;
use App\Http\Controllers\PostStatusController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\YoutubeCategoryController;
use App\Http\Controllers\RolesPermissionsController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/


Route::middleware(['guest'])->get('/', function () {
    return view('welcome');
});

Route::middleware(['auth'])->group(function () {
    Route::get('/home', [DashboardController::class, 'index'])->name('admin.index');
});

Auth::routes();

Route::group(['middleware' => ['admin','auth']], function () { // for admin only to login on them
    Route::resource('/services', ServiceController::class);
    Route::resource('/users', UserController::class);

    Route::get('/rolePermission', [RolesPermissionsController::class, 'index'])->name('rolePermission');
    Route::post('/RoleStore', [RolesPermissionsController::class, 'RoleStore'])->name('role.store');
    Route::put('/RoleUpdate', [RolesPermissionsController::class, 'RoleUpdate'])->name('role.update');
    Route::post('/PermissionStore', [RolesPermissionsController::class, 'PermissionStore'])->name('permission.store');
    Route::post('/RolePermissionStore', [RolesPermissionsController::class, 'RolePermissionStore'])->name('role.permission.store');
    Route::post('/rolePermissionUser/{userId}', [RolesPermissionsController::class, 'rolePermissionUser'])->name('rolePermissionUser');
}); 

Route::group(['middleware' => ['auth']], function () 
{
    Route::resource('/socialAccounts', AccountController::class);
    Route::resource('posts', PostController::class);
    Route::resource('twitter', TwitterController::class);
    Route::resource('youtube', YoutubeController::class);
    Route::resource('youtubeCategories', YoutubeCategoryController::class);

    Route::get('/adminSocail', [DashboardController::class, 'index'])->name('adminSocail');
    Route::get('/privacy', [DashboardController::class, 'privacy_policy'])->name('privacy');
    Route::get('/terms', [DashboardController::class, 'terms_policy'])->name('terms');
    
    Route::get('/facebook', [FacebookController::class, 'facebookPosts'])->name('facebookPosts');
    Route::get('/facebookApi', [FacebookController::class, 'facebookApi'])->name('facebookApi');
    Route::get('/fetch-facebook-data', [FacebookController::class, 'fetchDataFromFacebook'])->name('fetch-facebook-data');
    Route::get('/facebook_create', [FacebookController::class, 'create'])->name('facebook_create');
    Route::put('/facebook_store', [FacebookController::class, 'store_facebookApi'])->name('store_facebookApi');
    Route::get('/socialStatusFacebook', [FacebookController::class, 'socialStatusFacebook'])->name('socialStatusFacebook');
    Route::post('/getPages', [FacebookController::class, 'getPages'])->name('getPages');
    
    Route::get('/instagram', [InstagramController::class, 'instagram'])->name('instagram');
    Route::get('/insta_create', [InstagramController::class, 'insta_create'])->name('insta_create');
    Route::post('/store_instaApi', [InstagramController::class, 'store_instaApi'])->name('store_instaApi');
    Route::get('/socialStatusInsta', [InstagramController::class, 'socialStatusInsta'])->name('socialStatusInsta');

    Route::get('/youtubeData/{channel_id}', [YoutubeController::class, 'youtubeData'])->name('youtubeData');

    Route::post('/chartJS/{userId}', [PostController::class, 'chartJS'])->name('chartJS');
    Route::put('/updateInterval', [PostController::class, 'updateInterval'])->name('updateInterval');
    Route::get('/accountPages', [PostController::class, 'accountPages'])->name('accountPages');
    Route::post('/publishPost', [PostController::class, 'publishPost'])->name('publishPost');
    Route::get('/updatePostsTime', [PostController::class, 'updatePostsTime'])->name('updatePostsTime');
    Route::get('/schedulePosts', [PostController::class, 'schedulePosts'])->name('schedulePosts');
    Route::get('/updatePostsNow', [PostController::class, 'updatePostsNow'])->name('updatePostsNow');
    Route::get('/historyPosts', [PostController::class, 'historyPosts'])->name('historyPosts');
    Route::get('/repostEdit/{id}', [PostController::class, 'repostEdit'])->name('repostEdit');
    Route::put('/repostUpdate/{id}', [PostController::class, 'repostUpdate'])->name('repostUpdate');
    Route::delete('/removeSocialPost/{id}', [PostController::class, 'removeSocialPost'])->name('removeSocialPost');
    Route::delete('/removeAccount/{id}', [PostController::class, 'removeAccount'])->name('removeAccount');
    Route::get('/publishPostServices', [PostController::class, 'publishPostServices'])->name('publishPostServices');

    Route::get('/checkPostStatus', [PostStatusController::class, 'checkPostStatus'])->name('checkPostStatus');
    Route::get('/timeThink', [PostStatusController::class, 'timeThink'])->name('timeThink');
    Route::put('/timeThink_store', [PostStatusController::class, 'timeThinkStore'])->name('timeThinkStore');

    Route::get('/test', [DashboardController::class, 'test'])->name('test');
});

Route::middleware('web')->group(function () {

    Route::get('/auth/redirect', function () {
        return Socialite::driver('facebook')->redirect();
    })->name('faceLogin');
    Route::get('/auth/callback', [FacebookController::class, 'callback']);

    Route::get('auth/instagram',[InstagramController::class, 'redirectToInstagramProvider'])->name('instagram.login');
    Route::get('auth/instagram/callback', [InstagramController::class, 'instagramProviderCallback'])->name('instagram.login.callback');

    Route::get('auth/twitter',[TwitterController::class, 'twitterRedirect']);
    Route::get('auth/twitter/callback', [TwitterController::class, 'twitterCallback'])->name('twitter.callback');

    Route::get('auth/youtube',[YoutubeController::class, 'redirectToYoutube']);
    Route::get('auth/youtube/callback', [YoutubeController::class, 'YoutubeCallback'])->name('youtube.callback');
});