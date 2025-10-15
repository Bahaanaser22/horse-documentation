<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        $products = Product::all();
        return view('dashboard.product.index' , compact('products'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('dashboard.product.create' );

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
          $request->validate([
            'name' => 'required|string|min:3|max:255',
            'description' => 'nullable|string',
            'image' => 'image',
            'category_id' => 'required|exists:categories,id'
        ]);
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $fileName = time() . '_' . $image->getClientOriginalName();
            $filePath = $request->file('image')->storeAs('public/products-image', $fileName);
        }

        $product = new Product();
        $product->name = $request->name;
        $product->description = $request->description;
        $product->category_id = $request->category_id;
        $product->image = $fileName; // Save the file name to the database

        $product->save();

        return redirect()->route('dashboard.product.index');


    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $category = product::findOrFail($id);
        return view('dashboard.category.edit',compact('category'));
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id,Product $product)
    {
       $request->validate([
            'name' => 'required|string|min:3|max:255',
            'description' => 'nullable|string',
            'image' => 'image',
            'category_id' => 'required|exists:categories,id'
        ]);
        $product = Product::findOrFail($id);

        // Handle file upload if a new image is provided
        if ($request->hasFile('image')) {
            // Delete old image
            if ($product->image !== null) {
                Storage::delete('public/products-image/' . $product->image);
            }

            // Upload new image
            $image = $request->file('image');
            $fileName = time() . '_' . $image->getClientOriginalName();
            $filePath = $request->file('image')->storeAs('public/products-image', $fileName);

            // Update product with new image
            $product->image = $fileName;
        }

        // Update other fields
        $product->name = $request->input('name');
        $product->description = $request->input('description');

        $product->save();


        return redirect()->route('dashboard.product.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $category = Product::findOrFail($id)->first();
        $category->destroy($id);
        return redirect()->route('dashboard.product.index')->with('success','Category Deleted');
    }
}
