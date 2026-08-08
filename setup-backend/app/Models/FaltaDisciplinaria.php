<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class FaltaDisciplinaria extends Model
{
    use HasFactory;

    protected $table = 'faltas_disciplinarias';

    protected $fillable = [
        'recluso_id',
        'descripcion',
        'gravedad',
        'fecha_falta',
        'sancion',
        'activa',
        'observaciones',
    ];

    protected $casts = [
        'fecha_falta' => 'date',
        'activa' => 'boolean',
    ];

    /**
     * Recluso que cometió la falta
     */
    public function recluso(): BelongsTo
    {
        return $this->belongsTo(Recluso::class);
    }

    /**
     * Verificar si es una falta grave
     */
    public function getEsGraveAttribute(): bool
    {
        return $this->gravedad === 'Grave';
    }

    /**
     * Verificar si la falta está activa
     */
    public function getEstaActivaAttribute(): bool
    {
        return $this->activa === true;
    }
}
