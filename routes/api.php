<?php

use App\Http\Controllers\Api\AuthSyncController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/sync-user', [AuthSyncController::class, 'sync']);
    Route::get('/me', function (Request $request) {
        return $request->user();
    });
});