@extends('layouts.dashboard')

@section('content')
    <div class="m-5 ">
        <a class="btn btn-small btn-outline-primary" href="{{ route('dashboard.product.create') }}">New product</a>
    </div>
    <table class="table m-5">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Category</th>
            <th>Image</th>
            <th>Created At</th>
            <th colspan="2"></th>
        </tr>
        </thead>
        <tbody>
        @foreach($products as $product)
            <tr>
                <td>{{ $product->id }}</td>
                <td><a href="{{ route('dashboard.product.show',$product->id) }}"> {{ $product->name }}</a></td>
                <td>{{ $product->description }}</td>
                <td>{{ $product->category->name }}</td>
                <td>
                    @if($product->image)
                        <img src="{{ asset('storage/products-image/' . $product->image) }}" alt="Product Image" style="max-width: 100px;">
                    @else
                        No Image
                    @endif
                </td>
                <td>{{ $product->created_at }}</td>
                <td>
                    <a href="{{ route('dashboard.product.edit', $product->id) }}" class="btn btn-sm btn-outline-success">Edit</a>
                </td>
                <td>
                    <form action="{{ route('dashboard.product.destroy', $product->id) }}" method="POST">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-sm btn-outline-danger">Delete</button>
                    </form>
                </td>
            </tr>
        @endforeach
        </tbody>
    </table>
@endsection
