<?php

use App\Http\Controllers\Api\AuthSyncController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->get('/sync-user', [AuthSyncController::class, 'sync']);
