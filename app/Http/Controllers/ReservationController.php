<?php

namespace App\Http\Controllers;

use App\Models\Reservation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\StoreReservationRequest;
use App\Http\Requests\UpdateReservationRequest;


class ReservationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
         $reservations = DB::select("SELECT * FROM reservations");
        return response()->json($reservations);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreReservationRequest $request)
    {
        //
        $result = DB::select("CALL sp_create_reservation(?,?,?,?)", [
            $request->room_id,
            $request->check_in,
            $request->check_out,
            $request->status,
        ]);
        return response()->json($result);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
        $reservation = DB::select("SELECT * FROM reservations WHERE id = ?", [$id]);
        return response()->json($reservation);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateReservationRequest $request, $id)
    {
        //

        $result = DB::select("CALL sp_update_reservation(?,?,?,?)", [
            $id,
            $request->check_in,
            $request->check_out,
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
        $result = DB::select("CALL sp_delete_reservation(?)", [$id]);
        return response()->json($result);
    }
}
