// database/migrations/2024_01_01_000007_create_unificaciones_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('unificaciones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('expediente_id')->constrained()->onDelete('cascade');
            $table->enum('tipo_unificacion', ['Acumulación', 'Absorción']);
            $table->string('orden_judicial', 100);
            $table->date('fecha_resolucion');
            $table->integer('total_dias_condena')->nullable();
            $table->text('observaciones')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('unificaciones');
    }
};
