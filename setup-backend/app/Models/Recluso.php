<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Recluso extends Model
{
    use HasFactory;
    protected $table = 'reclusos'; // O el nombre real en tu BD

    protected $fillable = [
        'celda_id',
        'nombres',
        'apellidos',
        'cedula_identidad',
        'nivel_riesgo',
        'estado_operativo',
        'fecha_nacimiento',
        'huella_dactilar',
        'foto_perfil',
        'fecha_ingreso',
        'sexo',
    ];

    protected $casts = [
        'fecha_nacimiento' => 'date',
        'fecha_ingreso' => 'datetime',
    ];

    public function celda(): BelongsTo
    {
        return $this->belongsTo(Celda::class);
    }

    public function causas(): BelongsToMany
    {
        return $this->belongsToMany(CausaPenal::class, 'recluso_causa')
                    ->withPivot('fecha_asignacion')
                    ->withTimestamps();
    }

    public function defensores(): BelongsToMany
    {
        return $this->belongsToMany(Defensor::class, 'recluso_defensor')
                    ->withPivot('fecha_asignacion')
                    ->withTimestamps();
    }

    public function expediente(): HasOne
    {
        return $this->hasOne(Expediente::class)->where('estado', 'Activo');
    }

    public function expedientes(): HasMany
    {
        return $this->hasMany(Expediente::class);
    }

    public function redenciones(): HasMany
    {
        return $this->hasMany(Redencion::class);
    }

    public function boleta(): HasOne
    {
        return $this->hasOne(BoletaExcarcelacion::class)->where('activa', true);
    }

    public function boletas(): HasMany
    {
        return $this->hasMany(BoletaExcarcelacion::class);
    }

    public function faltas(): HasMany
    {
        return $this->hasMany(FaltaDisciplinaria::class);
    }

    public function getNombreCompletoAttribute()
    {
        return $this->nombres . ' ' . $this->apellidos;
    }

    public function getTieneFaltaGraveAttribute()
    {
        return $this->faltas()
                    ->where('gravedad', 'Grave')
                    ->where('activa', true)
                    ->exists();
    }

    public function getTotalDiasRedimidosAttribute()
    {
        return $this->redenciones()
                    ->where('avalado', true)
                    ->sum('dias_redimidos');
    }

    public function getPenaRestanteAttribute()
    {
        // Suma de días de condena de causas sentenciadas
        $totalCondena = $this->causas()
                             ->where('estado_procesal', 'Sentenciado')
                             ->sum('dias_condena');

        return max(0, $totalCondena - $this->total_dias_redimidos);
    }
}
