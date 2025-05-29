<?php

use App\Http\Controllers\PostController;

Route::get('/', [PostController::class, 'index']);
Route::resource('posts', PostController::class);

