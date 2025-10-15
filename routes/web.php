<?php

use App\Http\Controllers\Dashboard\CategoryController;
use App\Http\Controllers\Dashboard\ProductController;
use App\Http\Controllers\Dashboard\UserController;
use App\Http\Controllers\Front\LoginController;
use App\Http\Controllers\Front\RegisterController;
use Illuminate\Support\Facades\Route;

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

Route::get('/', function () {
    return view('welcome');
});


Route::get('/assets', function () {
    return view('assets.index');
});


Route::get('/login',[LoginController::class,'create'])->name('login');

Route::post('/login',[LoginController::class,'store'])
    ->name('login');
Route::get('/register',[RegisterController::class,'create'])->name('register');
Route::post('/register',[RegisterController::class,'store']);

Route::post('/logout',[LoginController::class,'logout'])->name('logout');

Route::middleware('role:admin,supervisor,editor')->prefix('dashboard')->name('dashboard.')->group(function (){

    Route::get('/', function () {
        return view('dashboard.index');
    });
    Route::resource('user',UserController::class);
    Route::resource('category',CategoryController::class);
    Route::resource('product',ProductController::class);
});
