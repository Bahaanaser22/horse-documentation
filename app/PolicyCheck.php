<?php

namespace App;

use App\Models\Policy;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PolicyCheck
{
    /**
     * Create a new class instance.
     */
    public function __construct()
    {
        //
    }


        public static function pv($policyName) {
            $user_id = Auth::user()->id;

            $thePolicy = Policy::where('name', $policyName)->first();

            if ($thePolicy === null) {
                return false; // Policy not found
            }

            $isPolicy = DB::select("SELECT * FROM policy_user WHERE user_id = ? AND policy_id = ?", [$user_id, $thePolicy->id]);

            if (count($isPolicy) == 0) {
                return false;
            } else {
                return true;
            }
        }
}
