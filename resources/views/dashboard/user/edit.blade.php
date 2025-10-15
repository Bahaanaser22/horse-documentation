@extends('layouts.dashboard')

@section('content')

    <form method="post" action="{{ route('dashboard.user.update',$user->id) }}" enctype="multipart/form-data" class="m-5">
        @csrf
        @method('put')

        <div class="form-group">
            <label for="name">User Name</label>
            <input type="text" id="name" name="name" class="form-control" value="{{ $user->name }}" required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="text" id="email" name="email" class="form-control" value="{{ $user->email }}" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="text" id="password" name="password" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="role">Role</label>
            <select id="role" name="role" class="form-control" required>
                @foreach($roleOptions as $role)
                    <option value="{{ $role }}">{{ $role }}</option>
                @endforeach
            </select>
        </div>


        <button type="submit" class="btn btn-outline-primary">Edit</button>
    </form>
@endsection
