<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        DB::unprepared(file_get_contents(database_path('sql/sp_crud_reservation.sql')));
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
         DB::unprepared("
            DROP PROCEDURE IF EXISTS sp_create_reservation;
            DROP PROCEDURE IF EXISTS sp_update_reservation;
            DROP PROCEDURE IF EXISTS sp_delete_reservation;
        ");
    }
};
