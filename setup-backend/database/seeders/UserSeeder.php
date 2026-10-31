<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        User::updateOrCreate(
            ['email' => 'admin@prison.com'],
            [
                'name' => 'Administrador',
                'password' => Hash::make('admin123'),
                'rol' => 'Administrador',
            ]
        );

        User::updateOrCreate(
            ['email' => 'c.diaz@prison.com'],
            [
                'name' => 'Carmen Díaz',
                'password' => Hash::make('password'),
                'rol' => 'Custodio',
            ]
        );

        User::updateOrCreate(
            ['email' => 'medico@prison.com'],
            [
                'name' => 'Dr. Pérez',
                'password' => Hash::make('medico123'),
                'rol' => 'Médico',
            ]
        );
    }
}
