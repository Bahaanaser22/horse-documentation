@extends('layouts.dashboard')

@section('content')

    <form method="POST" action="{{ route('dashboard.product.update', $product->id) }}" enctype="multipart/form-data" class="m-5">
        @csrf
        @method('PUT') <!-- Use PUT method for update -->

        <div class="form-group">
            <label for="name">Product Name</label>
            <input type="text" id="name" name="name" class="form-control" value="{{ $product->name }}" required>
        </div>

        <div class="form-group">
            <label for="description">Product Description</label>
            <textarea id="description" name="description" class="form-control" required>{{ $product->description }}</textarea>
        </div>

        <div class="form-group">
            <label for="category">Product Category</label>
            <select id="category" name="category_id" class="form-control" required>
                @foreach(\App\Models\Category::all() as $category)
                    <option value="{{ $category->id }}" {{ $product->category_id == $category->id ? 'selected' : '' }}>{{ $category->name }}</option>
                @endforeach
            </select>
        </div>

        <div class="form-group">
            <label for="image">Current Image</label><br>
            <img src="{{ asset('storage/products-image/' . $product->image) }}" alt="Current Image" style="max-width: 200px;"><br><br>
            <label for="image">Update Image (Optional)</label>
            <input type="file" id="image" name="image" class="form-control-file">
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
    </form>
@endsection
