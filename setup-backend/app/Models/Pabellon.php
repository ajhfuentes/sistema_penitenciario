<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Pabellon extends Model
{
    use HasFactory;
       // La propiedad debe ir aquí adentro
    protected $table = 'pabellones';


    protected $fillable = [
        'centro_penal_id',
        'nombre',
        'riesgo_permitido',
        'capacidad_maxima',
    ];

    protected $casts = [
        'capacidad_maxima' => 'integer',
    ];

    public function centroPenal(): BelongsTo
    {
        return $this->belongsTo(CentroPenal::class);
    }

    public function celdas(): HasMany
    {
        return $this->hasMany(Celda::class);
    }

    public function turnos(): HasMany
    {
        return $this->hasMany(Turno::class);
    }

    public function getOcupacionAttribute()
    {
        $ocupados = $this->celdas->sum(function ($celda) {
            return $celda->reclusos->count();
        });
        return $ocupados;
    }

    public function getPorcentajeOcupacionAttribute()
    {
        if ($this->capacidad_maxima === 0) {
            return 0;
        }
        return round(($this->ocupacion / $this->capacidad_maxima) * 100, 2);
    }
}
