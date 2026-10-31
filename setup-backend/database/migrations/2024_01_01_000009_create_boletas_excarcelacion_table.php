// database/migrations/2024_01_01_000009_create_boletas_excarcelacion_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('boletas_excarcelacion', function (Blueprint $table) {
            $table->id();
            $table->foreignId('recluso_id')->constrained()->onDelete('cascade');
            $table->string('numero_boleta', 50)->unique();
            $table->date('fecha_emision');
            $table->string('nombre_juez', 100);
            $table->string('hash_documento', 64)->nullable();
            $table->text('documento_pdf')->nullable();
            $table->string('motivo_liberacion', 200);
            $table->text('observaciones')->nullable();
            $table->boolean('activa')->default(true);
            $table->timestamp('fecha_efectiva')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('boletas_excarcelacion');
    }
};
