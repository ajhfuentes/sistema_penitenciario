<?php

namespace Database\Seeders;

use App\Models\CentroPenal;
use Illuminate\Database\Seeder;

class CentroPenalSeeder extends Seeder
{
    public function run(): void
    {
        CentroPenal::create([
            'nombre' => 'Centro Penitenciario Nacional',
            'ubicacion' => 'Av. Principal #123, Zona Industrial',
            'capacidad_aforo' => 2200,
            'nivel_seguridad' => 'Máxima',
        ]);

        CentroPenal::create([
            'nombre' => 'Centro de Rehabilitación Regional',
            'ubicacion' => 'Calle 45 #789, Sector Norte',
            'capacidad_aforo' => 800,
            'nivel_seguridad' => 'Media',
        ]);

        CentroPenal::create([
            'nombre' => 'Centro de Menores Infractores',
            'ubicacion' => 'Av. Juventud #456, Barrio Este',
            'capacidad_aforo' => 300,
            'nivel_seguridad' => 'Mínima',
        ]);
    }
}
