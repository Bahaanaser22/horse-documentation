<?php

namespace App\Http\Controllers\Front;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class RegisterController extends Controller
{
    public function create()
    {
        return view('auth.register');
    }
    public function store()
    {
        $attributes = request()->validate([
            'name' => 'required|min:3',
            'email' => ['required','email',Rule::unique('users','email')],
            'password' => 'required',
        ]);
        $attributes['password'] = Hash::make($attributes['password']);
        $user = User::create($attributes);
        auth()->login($user);
        return redirect('/dashboard')->with('message','User Created And Logged in');
    }
}
