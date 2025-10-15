@extends('layouts.dashboard')

@section('content')
    <div class="m-5">
        <a class="btn btn-small btn-outline-primary" href="{{ route('dashboard.product.create') }}">New product</a>
    </div>
    <form method="POST" action="{{ route('dashboard.product.store') }}" enctype="multipart/form-data" class="m-5">
        @csrf

        <div class="form-group">
            <label for="name">Product Name</label>
            <input type="text" id="name" name="name" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="description">Product Description</label>
            <textarea id="description" name="description" class="form-control" required></textarea>
        </div>

        <div class="form-group">
            <label for="category">Product Category</label>
            <select id="category" name="category_id" class="form-control" required>
                @foreach(\App\Models\Category::all() as $category)
                    <option value="{{ $category->id }}">{{ $category->name }}</option>
                @endforeach
            </select>
        </div>

        <div class="form-group">
            <label for="image">Product Image</label>
            <input type="file" id="image" name="image" class="form-control-file" required>
        </div>

        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
@endsection
