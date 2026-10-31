// database/migrations/2024_01_01_000013_create_recluso_causa_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('recluso_causa', function (Blueprint $table) {
            $table->id();
            $table->foreignId('recluso_id')->constrained()->onDelete('cascade');
            $table->foreignId('causa_penal_id')->constrained()->onDelete('cascade');
            $table->timestamp('fecha_asignacion')->useCurrent();
            $table->timestamps();
            $table->unique(['recluso_id', 'causa_penal_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('recluso_causa');
    }
};
