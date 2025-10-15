<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class policyUser extends Model
{
    use HasFactory;

    protected $fillable = ['user_id','policy_id'];
}
