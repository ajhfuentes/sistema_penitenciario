<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Redencion extends Model
{
    use HasFactory;

    protected $table = 'redenciones';

    protected $fillable = [
        'recluso_id',
        'causa_penal_id',
        'tipo_actividad',
        'horas_certificadas',
        'factor_conversion',
        'dias_redimidos',
        'fecha_registro',
        'numero_acta',
        'juez_ejecucion',
        'avalado',
        'fecha_avali',
        'observaciones',
    ];

    protected $casts = [
        'horas_certificadas' => 'integer',
        'factor_conversion' => 'decimal:2',
        'dias_redimidos' => 'integer',
        'fecha_registro' => 'date',
        'fecha_avali' => 'datetime',
        'avalado' => 'boolean',
    ];

    /**
     * Recluso que redime la pena
     */
    public function recluso(): BelongsTo
    {
        return $this->belongsTo(Recluso::class);
    }

    /**
     * Causa asociada a esta redención (opcional)
     */
    public function causaPenal(): BelongsTo
    {
        return $this->belongsTo(CausaPenal::class);
    }

    /**
     * Verificar si la redención ya fue avalada
     */
    public function getEstaAvaladaAttribute(): bool
    {
        return $this->avalado === true;
    }
}
