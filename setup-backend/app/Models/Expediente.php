<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Expediente extends Model
{
    use HasFactory;
      // La propiedad debe ir aquí adentro
    protected $table = 'expedientes';

    protected $fillable = [
        'recluso_id',
        'numero_expediente',
        'fecha_creacion',
        'estado',
        'observaciones',
    ];

    protected $casts = [
        'fecha_creacion' => 'date',
    ];

    public function recluso(): BelongsTo
    {
        return $this->belongsTo(Recluso::class);
    }

    public function unificaciones(): HasMany
    {
        return $this->hasMany(Unificacion::class);
    }
}
