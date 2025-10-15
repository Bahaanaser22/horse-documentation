@extends('layouts.dashboard')

@section('content')

    <form method="POST" action="{{ route('dashboard.user.store') }}" enctype="multipart/form-data" class="m-5">
        @csrf

        <div class="form-group">
            <label for="name">User Name</label>
            <input type="text" id="name" name="name" class="form-control"  required>
        </div>
        @error('name')
        <p>{{ $message }}</p>
        @enderror


        <div class="form-group">
            <label for="email">Email</label>
            <input type="text" id="email" name="email" class="form-control"  required>
        </div>
        @error('email')
        <p>{{ $message }}</p>
        @enderror


        <div class="form-group">
            <label for="password">Password</label>
            <input type="text" id="password" name="password" class="form-control" required>
        </div>
        @error('password')
        <p>{{ $message }}</p>
        @enderror


        <div class="form-group">
            <label for="role">Role</label>
            <select id="role" name="role" class="form-control" required>
                @foreach($roleOptions as $role)
                    <option value="{{ $role }}">{{ $role }}</option>
                @endforeach
            </select>
            @error('role')
            <p>{{ $message }}</p>
            @enderror
        </div>


        <button type="submit" class="btn btn-outline-primary">Add</button>
    </form>
@endsection
