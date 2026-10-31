// database/migrations/2024_01_01_000005_create_causas_penales_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('causas_penales', function (Blueprint $table) {
            $table->id();
            $table->string('numero_unico', 50)->unique();
            $table->string('delito_principal', 200);
            $table->enum('estado_procesal', ['En Juicio', 'Sentenciado', 'Apelación', 'Unificada']);
            $table->string('tribunal_origen', 100);
            $table->date('fecha_apertura');
            $table->integer('dias_condena')->nullable();
            $table->text('observaciones')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('causas_penales');
    }
};
