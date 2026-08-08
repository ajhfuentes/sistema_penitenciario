<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
      // La propiedad debe ir aquí adentro
    protected $table = 'users';

    protected $fillable = [
        'name',
        'email',
        'password',
        'rol',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function personal()
    {
        return $this->hasOne(Personal::class);
    }

    public function hasRole($role)
    {
        return $this->rol === $role;
    }

    public function isAdmin()
    {
        return $this->rol === 'Administrador';
    }

    public function isCustodio()
    {
        return $this->rol === 'Custodio';
    }

    public function isMedico()
    {
        return $this->rol === 'Médico';
    }
}
