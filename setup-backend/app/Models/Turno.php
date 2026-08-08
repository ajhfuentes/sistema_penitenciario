<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Turno extends Model
{
    use HasFactory;
      // La propiedad debe ir aquí adentro
    protected $table = 'turnos';
    
}
