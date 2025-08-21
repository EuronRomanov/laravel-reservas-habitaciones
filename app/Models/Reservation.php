<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
class Reservation extends Model
{
    //
     use HasFactory;
    protected $fillable = [
        'user_id','room_id','check_in','check_out','guests',
        'nightly_rate','subtotal','tax','total','status','meta'
    ];
    protected $casts = ['check_in'=>'date','check_out'=>'date','meta'=>'array'];

    public function user()  { return $this->belongsTo(User::class); }
    public function room()  { return $this->belongsTo(Room::class); }
    public function payments(){ return $this->hasMany(Payment::class); }
    public function invoice() { return $this->hasOne(Invoice::class); }
}
