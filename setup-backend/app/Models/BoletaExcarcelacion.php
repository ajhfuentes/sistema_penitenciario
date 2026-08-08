<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BoletaExcarcelacion extends Model
{
    use HasFactory;

    protected $table = 'boletas_excarcelacion';

    protected $fillable = [
        'recluso_id',
        'numero_boleta',
        'fecha_emision',
        'nombre_juez',
        'hash_documento',
        'documento_pdf',
        'motivo_liberacion',
        'observaciones',
        'activa',
        'fecha_efectiva',
    ];

    protected $casts = [
        'fecha_emision' => 'date',
        'fecha_efectiva' => 'datetime',
        'activa' => 'boolean',
    ];

    /**
     * Relación con el recluso liberado.
     * ¡Esta es la relación que faltaba!
     */
    public function recluso(): BelongsTo
    {
        return $this->belongsTo(Recluso::class, 'recluso_id');
    }

    /**
     * Alias para mantener compatibilidad si se usa 'recluso'
     */
    public function getReclusoAttribute()
    {
        return $this->recluso()->getResults();
    }

    /**
     * Verificar si la boleta está activa
     */
    public function getEstaActivaAttribute(): bool
    {
        return $this->activa === true;
    }
}
