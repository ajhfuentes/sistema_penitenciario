<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CausaPenal extends Model
{
    use HasFactory;

    protected $table = 'causas_penales';

    protected $fillable = [
        'numero_unico',
        'delito_principal',
        'estado_procesal',
        'tribunal_origen',
        'fecha_apertura',
        'dias_condena',
        'observaciones',
    ];

    protected $casts = [
        'fecha_apertura' => 'date',
        'dias_condena' => 'integer',
    ];

    /**
     * Reclusos asociados a esta causa (relación muchos a muchos)
     */
    public function reclusos(): BelongsToMany
    {
        return $this->belongsToMany(Recluso::class, 'recluso_causa')
                    ->withPivot('fecha_asignacion')
                    ->withTimestamps();
    }

    /**
     * Redenciones asociadas a esta causa
     */
    public function redenciones(): HasMany
    {
        return $this->hasMany(Redencion::class);
    }

    /**
     * Unificaciones en las que participa esta causa
     */
    public function unificaciones(): BelongsToMany
    {
        return $this->belongsToMany(Unificacion::class, 'unificacion_causa')
                    ->withTimestamps();
    }

    /**
     * Verificar si la causa puede ser unificada
     */
    public function getPuedeUnificarseAttribute(): bool
    {
        return $this->estado_procesal === 'Sentenciado' && $this->dias_condena > 0;
    }
}
