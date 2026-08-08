<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Personal extends Model
{
    use HasFactory;

    // Define aquí el nombre real de tu tabla en PostgreSQL
    protected $table = 'personal'; // O 'personales' según la hayas nombrado
}

