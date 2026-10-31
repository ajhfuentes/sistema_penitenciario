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
        Schema::create('traslados', function (Blueprint $table) {
            $table->id();
            $table->foreignId('recluso_id')->constrained('reclusos')->onDelete('cascade');
            $table->foreignId('centro_origen_id')->constrained('centros_penales');
            $table->foreignId('centro_destino_id')->constrained('centros_penales');
            $table->foreignId('celda_destino_id')->nullable()->constrained('celdas');
            $table->enum('estado', ['Pendiente', 'Aprobado', 'Rechazado', 'Completado'])->default('Pendiente');
            $table->text('motivo');
            $table->string('juez_autorizante')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('traslados');
    }
};
