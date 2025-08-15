<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('rooms', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();     // ej: APT-301
            $table->string('name');               // nombre comercial
            $table->text('description')->nullable();
            $table->unsignedInteger('capacity')->default(1);
            $table->decimal('base_price', 10, 2); // precio por noche
            $table->enum('status', ['available','maintenance','unlisted'])->default('available');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rooms');
    }
};
