// database/migrations/2024_01_01_000002_create_celdas_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('celdas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pabellon_id')->constrained()->onDelete('cascade');
            $table->string('codigo', 20);
            $table->integer('capacidad_maxima');
            $table->timestamps();
            $table->unique(['pabellon_id', 'codigo']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('celdas');
    }
};
