// database/migrations/2024_01_01_000001_create_pabellones_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pabellones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('centro_penal_id')->constrained()->onDelete('cascade');
            $table->string('nombre', 50);
            $table->enum('riesgo_permitido', ['Bajo', 'Medio', 'Alto']);
            $table->integer('capacidad_maxima');
            $table->timestamps();
            $table->unique(['centro_penal_id', 'nombre']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pabellones');
    }
};
