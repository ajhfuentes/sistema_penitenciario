// database/migrations/2024_01_01_000012_create_faltas_disciplinarias_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('faltas_disciplinarias', function (Blueprint $table) {
            $table->id();
            $table->foreignId('recluso_id')->constrained()->onDelete('cascade');
            $table->string('descripcion', 255);
            $table->enum('gravedad', ['Leve', 'Grave']);
            $table->date('fecha_falta');
            $table->string('sancion', 100)->nullable();
            $table->boolean('activa')->default(true);
            $table->text('observaciones')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('faltas_disciplinarias');
    }
};
