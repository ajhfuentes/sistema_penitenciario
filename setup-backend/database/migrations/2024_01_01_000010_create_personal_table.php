// database/migrations/2024_01_01_000010_create_personal_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('personal', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained()->onDelete('set null');
            $table->string('nombres', 100);
            $table->string('apellidos', 100);
            $table->string('cedula_identidad', 20)->unique();
            $table->enum('rol', ['Administrador', 'Custodio', 'Médico']);
            $table->string('telefono', 20)->nullable();
            $table->string('email', 100)->nullable();
            $table->date('fecha_contratacion');
            $table->boolean('activo')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('personal');
    }
};
