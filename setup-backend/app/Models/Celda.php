<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Celda extends Model
{
    use HasFactory;
      // La propiedad debe ir aquí adentro
    protected $table = 'celdas';

    protected $fillable = [
        'pabellon_id',
        'codigo',
        'capacidad_maxima',
    ];

    protected $casts = [
        'capacidad_maxima' => 'integer',
    ];

    public function pabellon(): BelongsTo
    {
        return $this->belongsTo(Pabellon::class);
    }

    public function reclusos(): HasMany
    {
        return $this->hasMany(Recluso::class);
    }

    public function getOcupacionAttribute()
    {
        return $this->reclusos->count();
    }

    public function getDisponibleAttribute()
    {
        return $this->capacidad_maxima - $this->ocupacion;
    }

    public function getEstaLLenaAttribute()
    {
        return $this->ocupacion >= $this->capacidad_maxima;
    }
}
