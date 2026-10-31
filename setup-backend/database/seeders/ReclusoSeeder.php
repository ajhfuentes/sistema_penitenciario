<?php

namespace Database\Seeders;

use App\Models\Recluso;
use App\Models\Celda;
use App\Services\ExpedienteService;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class ReclusoSeeder extends Seeder
{
    public function run(): void
    {
        $faker = Faker::create('es_ES');

        // Asignar reclusos a celdas existentes
        $celdas = Celda::all();

        $riesgos = ['Bajo', 'Medio', 'Alto'];
        $estados = ['En Ingreso', 'Activo', 'Traslado', 'Libertad'];

        for ($i = 0; $i < 50; $i++) {
            $celda = $celdas->random();
            $riesgo = $riesgos[array_rand($riesgos)];

            // Asegurar compatibilidad de riesgo con el pabellón
            $pabellon = $celda->pabellon;
            $riesgosPermitidos = ['Bajo', 'Medio', 'Alto'];
            $riesgosPosibles = array_intersect($riesgosPermitidos, [$riesgo]);
            if (empty($riesgosPosibles)) {
                $riesgo = 'Bajo';
            }

            $recluso = Recluso::create([
                'celda_id' => $celda->id,
                'nombres' => $faker->firstName,
                'apellidos' => $faker->lastName . ' ' . $faker->lastName,
                'cedula_identidad' => $faker->unique()->numerify('##########'),
                'nivel_riesgo' => $riesgo,
                'estado_operativo' => $estados[array_rand($estados)],
                'fecha_nacimiento' => $faker->dateTimeBetween('-60 years', '-18 years'),
                'sexo' => $faker->randomElement(['M', 'F']),
            ]);

            // Crear expediente automáticamente
            try {
                ExpedienteService::crearExpediente($recluso);
            } catch (\Exception $e) {
                // Si ya tiene expediente, continuar
            }
        }
    }
}
