<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\Models\Policy;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class UserController extends Controller
{
    public function index()
    {
        $users = User::all();

        return view('dashboard.user.index',compact('users'));
    }
    public function create()
    {
        $users = User::all();
        $roleOptions = User::getRoleOptions();
        return view('dashboard.user.create',[
            'users' => $users,
            'roleOptions' => $roleOptions
        ]);
    }
    public function store()
    {
        $attributes = request()->validate([
            'name' => 'required|min:3',
            'email' => ['required','email',Rule::unique('users','email')],
            'password' => 'required',
            'role' => 'required|in:supervisor,admin,editor'
        ]);
        $attributes['password'] = Hash::make($attributes['password']);

        User::create($attributes);
        return redirect()->route('dashboard.user.index');
    }
    public function edit(string $id)
    {
        $user = User::findOrFail($id)->first();
        $roleOptions = User::getRoleOptions();
        return view('dashboard.user.edit',[
            'user' => $user,
            'roleOptions' => $roleOptions
        ]);
    }
    public function update(Request $request ,User $user)
    {
        $attributes = request()->validate([
            'name' => 'required|min:3',
            'email' => ['required','email',Rule::unique('users','email')],
            'password' => 'required',
            'role' => 'required'
        ]);
        $attributes['password'] = Hash::make($attributes['password']);

        $user->update($attributes);
        return redirect()->route('dashboard.user.index')->with('message','User Updated');
    }
    public function destroy(string $id)
    {
        $category = User::findOrFail($id)->first();
        $category->destroy($id);
        return redirect()->route('dashboard.user.index')->with('message','User Deleted');

    }
}
