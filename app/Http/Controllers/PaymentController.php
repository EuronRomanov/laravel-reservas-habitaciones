<?php

namespace App\Http\Controllers;

use App\Models\Payment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\StorePaymentRequest;

class PaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //

        $payments = DB::select("SELECT * FROM payments");
        return response()->json($payments);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StorePaymentRequest  $request)
    {
        //
         $result = DB::select("CALL sp_create_payment(?,?,?,?,?)", [
           
            $request->method,
            $request->amount,
            $request->status,
            $request->transaction_ref,
            $request->details,
        ]);
        return response()->json($result);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
        $payment = DB::select("SELECT * FROM payments WHERE id = ?", [$id]);
        return response()->json($payment);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        //
        $request->validate([
            'status' => 'required|in:pending,authorized,captured,failed,refunded'
        ]);

        $result = DB::select("CALL sp_update_payment(?,?)", [
            $id,
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

        $result = DB::select("CALL sp_delete_payment(?)", [$id]);
        return response()->json($result);
    }
}
