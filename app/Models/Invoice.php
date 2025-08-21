<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory; 

class Invoice extends Model
{
    //
    use HasFactory;
    protected $fillable = ['reservation_id','number','issue_date','subtotal','tax','total','pdf_path'];
    protected $casts = ['issue_date'=>'date'];

    public function reservation(){ return $this->belongsTo(Reservation::class); }
}
