// database/migrations/2024_01_01_000008_create_redenciones_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('redenciones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('recluso_id')->constrained()->onDelete('cascade');
            $table->foreignId('causa_penal_id')->nullable()->constrained()->onDelete('set null');
            $table->enum('tipo_actividad', ['Laboral', 'Educativa', 'Cultural', 'Deportiva']);
            $table->integer('horas_certificadas');
            $table->decimal('factor_conversion', 5, 2)->default(2);
            $table->integer('dias_redimidos');
            $table->date('fecha_registro');
            $table->string('numero_acta', 50)->unique();
            $table->string('juez_ejecucion', 100);
            $table->boolean('avalado')->default(false);
            $table->timestamp('fecha_avali')->nullable();
            $table->text('observaciones')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('redenciones');
    }
};
