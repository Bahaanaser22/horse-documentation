@extends('layouts.dashboard')


@section('content')
    <div class="container mt-5">
        <form action="{{ route('dashboard.category.update',$category->id) }}" method="post">
            @csrf
            @method('PUT')
            <div class="form-group row">
                <label for="name" class="col-sm-2 col-form-label">Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="name" value="{{ $category->name }}" name="name">
                </div>
            </div>
            <div class="form-group row">
                <label for="description" class="col-sm-2 col-form-label ">Description</label>
                <div class="col-sm-10">
                    <textarea class="form-control" id="description" name="description" rows="3">{{ $category->description }}</textarea>
                </div>
            </div>
            <fieldset class="form-group row">
                <legend class="col-form-label col-sm-2 pt-0">Is Active:</legend>
                <div class="col-sm-10">
                    <div class="form-check">
                        <input class="form-check-input"  type="radio" name="isActive" id="isActiveYes" value="1" <?php echo ($category->isActive == 1) ? 'checked' : ''; ?>
                        <label class="form-check-label" for="isActiveYes">
                            Yes
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="isActive" id="isActiveNo" value="0" <?php echo ($category->isActive == 1) ? 'checked' : ''; ?>
                        <label class="form-check-label" for="isActiveNo">
                            No
                        </label>
                    </div>
                </div>
            </fieldset>
            <div class="form-group row">
                <div class="col-sm-10 offset-sm-2">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>
    </div>

@endsection
