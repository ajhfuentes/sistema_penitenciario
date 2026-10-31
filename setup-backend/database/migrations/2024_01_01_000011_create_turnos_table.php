// database/migrations/2024_01_01_000011_create_turnos_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('turnos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('personal_id')->constrained()->onDelete('cascade');
            $table->foreignId('pabellon_id')->constrained()->onDelete('cascade');
            $table->date('fecha_turno');
            $table->time('hora_inicio');
            $table->time('hora_fin');
            $table->enum('estado', ['Programado', 'En Curso', 'Completado', 'Cancelado'])->default('Programado');
            $table->text('observaciones')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('turnos');
    }
};
