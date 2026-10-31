<?php

namespace Database\Seeders;

use App\Models\Celda;
use Illuminate\Database\Seeder;

class CeldaSeeder extends Seeder
{
    public function run(): void
    {
        $pabellones = [
            1 => ['capacidad' => 6, 'cantidad' => 10],  // Pabellón A
            2 => ['capacidad' => 4, 'cantidad' => 15],  // Pabellón B
            3 => ['capacidad' => 8, 'cantidad' => 8],   // Pabellón C
            4 => ['capacidad' => 4, 'cantidad' => 12],  // Pabellón Norte
            5 => ['capacidad' => 6, 'cantidad' => 8],   // Pabellón Sur
        ];

        foreach ($pabellones as $pabellonId => $config) {
            for ($i = 1; $i <= $config['cantidad']; $i++) {
                Celda::create([
                    'pabellon_id' => $pabellonId,
                    'codigo' => str_pad($i, 3, '0', STR_PAD_LEFT),
                    'capacidad_maxima' => $config['capacidad'],
                ]);
            }
        }
    }
}
