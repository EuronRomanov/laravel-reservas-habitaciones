<?php

namespace App\Http\Controllers;

use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\StoreRoomRequest;
use App\Http\Requests\UpdateRoomRequest;


class RoomController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $rooms = DB::select("SELECT * FROM rooms");
        return response()->json($rooms);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreRoomRequest $request)
    {
        //
    $result=DB::select("CALL sp_create_room(?,?,?,?,?)",[
     $request->name,
            $request->description,
            $request->capacity,
            $request->base_price,
            $request->status,]);
     return response()->json($result);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
        $room=DB::select("SELECT * FROM rooms WHERE id=?",[$id]);
        return response()->json($room);

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateRoomRequest $request, $id)
    {
        //
 $result = DB::select("CALL sp_update_room(?,?,?,?,?,?)", [
            $id,
            $request->name,
            $request->description,
            $request->capacity,
            $request->base_price,
            $request->status,
        ]);
        return response()->json($result);
        
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        //
        $result = DB::select("CALL sp_delete_room(?)", [$id]);
        return response()->json($result);
    }
}
