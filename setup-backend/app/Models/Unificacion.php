<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Unificacion extends Model
{
    use HasFactory;

    protected $table = 'unificaciones';

    protected $fillable = [
        'expediente_id',
        'tipo_unificacion',
        'orden_judicial',
        'fecha_resolucion',
        'total_dias_condena',
        'observaciones',
    ];

    protected $casts = [
        'fecha_resolucion' => 'date',
        'total_dias_condena' => 'integer',
    ];

    /**
     * Expediente al que pertenece esta unificación
     */
    public function expediente(): BelongsTo
    {
        return $this->belongsTo(Expediente::class);
    }

    /**
     * Causas que forman parte de esta unificación
     */
    public function causas(): BelongsToMany
    {
        return $this->belongsToMany(CausaPenal::class, 'unificacion_causa')
                    ->withTimestamps();
    }

    /**
     * Obtener el recluso a través del expediente
     */
    public function getReclusoAttribute()
    {
        return $this->expediente?->recluso;
    }
}
