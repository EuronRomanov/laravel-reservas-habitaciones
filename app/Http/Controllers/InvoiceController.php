<?php

namespace App\Http\Controllers;

use App\Models\Invoice;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\StoreInvoiceRequest;
use App\Http\Requests\UpdateInvoiceRequest;


class InvoiceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
         $invoices = DB::select("SELECT * FROM invoices");
        return response()->json($invoices);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreInvoiceRequest $request)
    {
        //
        $result = DB::select("CALL sp_create_invoice(?,?,?,?,?,?)", [
            
            $request->number,
            $request->issue_date,
            $request->subtotal,
            $request->tax,
            $request->total,
            $request->pdf_path,
        ]);
        return response()->json($result);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
         $invoice = DB::select("SELECT * FROM invoices WHERE id = ?", [$id]);
        return response()->json($invoice);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateInvoiceRequest $request, $id)
    {
        //
        $result = DB::select("CALL sp_update_invoice(?,?,?,?)", [
            $id,
            $request->tax,
            $request->total,
            $request->pdf_path,
        ]);
        return response()->json($result);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        //
         $result = DB::select("CALL sp_delete_invoice(?)", [$id]);
        return response()->json($result);
    }
}
