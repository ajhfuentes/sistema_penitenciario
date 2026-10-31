<?php

namespace Database\Seeders;

use App\Models\Pabellon;
use Illuminate\Database\Seeder;

class PabellonSeeder extends Seeder
{
    public function run(): void
    {
        // Centro Penitenciario Nacional (Máxima)
        Pabellon::create([
            'centro_penal_id' => 1,
            'nombre' => 'Pabellón A - Alta Seguridad',
            'riesgo_permitido' => 'Alto',
            'capacidad_maxima' => 300,
        ]);

        Pabellon::create([
            'centro_penal_id' => 1,
            'nombre' => 'Pabellón B - Media Seguridad',
            'riesgo_permitido' => 'Medio',
            'capacidad_maxima' => 400,
        ]);

        Pabellon::create([
            'centro_penal_id' => 1,
            'nombre' => 'Pabellón C - Baja Seguridad',
            'riesgo_permitido' => 'Bajo',
            'capacidad_maxima' => 200,
        ]);

        // Centro de Rehabilitación Regional (Media)
        Pabellon::create([
            'centro_penal_id' => 2,
            'nombre' => 'Pabellón Norte',
            'riesgo_permitido' => 'Medio',
            'capacidad_maxima' => 250,
        ]);

        Pabellon::create([
            'centro_penal_id' => 2,
            'nombre' => 'Pabellón Sur',
            'riesgo_permitido' => 'Bajo',
            'capacidad_maxima' => 200,
        ]);
    }
}
