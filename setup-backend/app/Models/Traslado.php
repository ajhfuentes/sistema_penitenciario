<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Traslado extends Model
{
    use HasFactory;

    protected $table = 'traslados';

    protected $fillable = [
        'recluso_id',
        'centro_origen_id',
        'centro_destino_id',
        'celda_destino_id',
        'estado',
        'motivo',
        'juez_autorizante'
    ];

    // Relaciones
    public function recluso()
    {
        return $this->belongsTo(Recluso::class);
    }

    public function centroOrigen()
    {
        return $this->belongsTo(CentroPenal::class, 'centro_origen_id');
    }

    public function centroDestino()
    {
        return $this->belongsTo(CentroPenal::class, 'centro_destino_id');
    }

    public function celdaDestino()
    {
        return $this->belongsTo(Celda::class, 'celda_destino_id');
    }
}
