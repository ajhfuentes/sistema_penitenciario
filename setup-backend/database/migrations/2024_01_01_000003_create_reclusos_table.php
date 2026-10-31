// database/migrations/2024_01_01_000003_create_reclusos_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reclusos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('celda_id')->nullable()->constrained()->onDelete('set null');
            $table->string('nombres', 100);
            $table->string('apellidos', 100);
            $table->string('cedula_identidad', 20)->unique();
            $table->enum('nivel_riesgo', ['Bajo', 'Medio', 'Alto']);
            $table->enum('estado_operativo', ['En Ingreso', 'Activo', 'Traslado', 'Libertad'])->default('En Ingreso');
            $table->date('fecha_nacimiento')->nullable();
            $table->text('huella_dactilar')->nullable();
            $table->string('foto_perfil', 255)->nullable();
            $table->timestamp('fecha_ingreso')->useCurrent();
            $table->enum('sexo', ['M', 'F'])->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reclusos');
    }
};
