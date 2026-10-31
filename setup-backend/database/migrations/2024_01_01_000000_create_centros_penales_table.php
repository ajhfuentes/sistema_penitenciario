// database/migrations/2024_01_01_000000_create_centros_penales_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('centros_penales', function (Blueprint $table) {
            $table->id();
            $table->string('nombre', 100)->unique();
            $table->text('ubicacion');
            $table->integer('capacidad_aforo');
            $table->enum('nivel_seguridad', ['Mínima', 'Media', 'Máxima']);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('centros_penales');
    }
};
