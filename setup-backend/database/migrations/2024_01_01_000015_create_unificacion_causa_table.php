// database/migrations/2024_01_01_000015_create_unificacion_causa_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('unificacion_causa', function (Blueprint $table) {
            $table->id();
            $table->foreignId('unificacion_id')->constrained()->onDelete('cascade');
            $table->foreignId('causa_penal_id')->constrained()->onDelete('cascade');
            $table->timestamps();
            $table->unique(['unificacion_id', 'causa_penal_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('unificacion_causa');
    }
};
