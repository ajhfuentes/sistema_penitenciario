// database/migrations/2024_01_01_000006_create_expedientes_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('expedientes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('recluso_id')->constrained()->onDelete('cascade');
            $table->string('numero_expediente', 50)->unique();
            $table->date('fecha_creacion');
            $table->enum('estado', ['Activo', 'Cerrado'])->default('Activo');
            $table->text('observaciones')->nullable();
            $table->timestamps();

            // Índice para evitar duplicados activos (se maneja en lógica)
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('expedientes');
    }
};
