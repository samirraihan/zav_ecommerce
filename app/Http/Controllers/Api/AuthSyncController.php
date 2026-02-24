<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class AuthSyncController extends Controller
{
    public function sync(Request $request)
    {
        $user = $request->user();

        $token = $user->createToken('foodpanda')->plainTextToken;

        return response()->json([
            'user' => $user,
            'token' => $token
        ]);
    }
}
