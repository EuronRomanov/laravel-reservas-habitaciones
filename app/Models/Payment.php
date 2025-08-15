<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    //

     use HasFactory;
    protected $fillable = ['reservation_id','method','amount','status','transaction_ref','details'];
    protected $casts = ['details'=>'array'];

    public function reservation(){ return $this->belongsTo(Reservation::class); }
}
