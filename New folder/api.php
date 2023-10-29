<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\api\PostController;
use App\Http\Controllers\api\UserController;
use App\Http\Controllers\api\AccountController;
use App\Http\Controllers\api\ServiceController;
use App\Http\Controllers\api\AnalyticsController;
use App\Http\Controllers\api\DashboardController;
use App\Http\Controllers\api\YoutubeCategoryController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/


//public routes
Route::post('/auth/register',[UserController::class,'register']);
Route::post('/auth/login', [UserController::class,'login']); 
// 6|JQIi9CXmPeOPJ1bbi8w2DYEs2JaRR0iqnKFHbfpbc88a6c92

//protected routes
Route::middleware('auth:sanctum')->group(function () 
{
    Route::resource('users', UserController::class); 
    Route::get('/users/search/{name}', [UserController::class, 'search']);
    Route::post('/logout', [UserController::class, 'logout']);

    Route::resource('dashboard', DashboardController::class); 
    Route::resource('services', ServiceController::class); 
    Route::resource('analytics', AnalyticsController::class); 
    Route::resource('categories', YoutubeCategoryController::class);
    Route::resource('accounts', AccountController::class);
    Route::resource('posts', PostController::class);
});
