<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class DatabaseTestSeeder extends Seeder
{
    public function run()
    {
        
         // Vaciar tablas antes de iniciar (Sintaxis para PostgreSQL)
        DB::statement('TRUNCATE TABLE centros_penales, pabellones, celdas, defensores, personal, reclusos, causas_penales, recluso_causa RESTART IDENTITY CASCADE;');

        $faker = Faker::create('es_ES');

        // ============================
        // 1. Centros Penales (2 nuevos)
        // ============================
        $centros = [];
        for ($i = 0; $i < 2; $i++) {
            $centros[] = DB::table('centros_penales')->insertGetId([
                // Cambia esto en el bloque 1 de tu Seeder:
                'nombre' => 'Centro de Prueba ' . ($i + 1) . ' (' . microtime(true) . ')',
                'ubicacion' => $faker->address,
                'capacidad_aforo' => $faker->numberBetween(200, 800),
                'nivel_seguridad' => $faker->randomElement(['Mínima', 'Media', 'Máxima']),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // ============================
        // 2. Pabellones (5 por centro)
        // ============================
        $pabellones = [];
        $nivelesRiesgo = ['Bajo', 'Medio', 'Alto'];
        foreach ($centros as $centroId) {
            for ($i = 0; $i < 5; $i++) {
                // El nivel de seguridad del centro restringe el riesgo permitido
                $centroNivel = DB::table('centros_penales')->where('id', $centroId)->value('nivel_seguridad');
                $permitidos = [];
                if ($centroNivel === 'Máxima') $permitidos = ['Bajo', 'Medio', 'Alto'];
                elseif ($centroNivel === 'Media') $permitidos = ['Bajo', 'Medio'];
                else $permitidos = ['Bajo'];
                $riesgo = $faker->randomElement($permitidos);

                $pabellones[] = DB::table('pabellones')->insertGetId([
                    'centro_penal_id' => $centroId,
                    'nombre' => 'Pabellón ' . chr(65 + $i) . ' - Prueba',
                    'riesgo_permitido' => $riesgo,
                    'capacidad_maxima' => $faker->numberBetween(30, 100),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        // ============================
        // 3. Celdas (10 por pabellón)
        // ============================
        $celdas = [];
        foreach ($pabellones as $pabellonId) {
            for ($i = 1; $i <= 10; $i++) {
                $celdas[] = DB::table('celdas')->insertGetId([
                    'pabellon_id' => $pabellonId,
                    'codigo' => 'CEL-' . str_pad($i, 3, '0', STR_PAD_LEFT),
                    'capacidad_maxima' => $faker->numberBetween(4, 12),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        // ============================
        // 4. Defensores (10 nuevos)
        // ============================
        $defensores = [];
        for ($i = 0; $i < 10; $i++) {
            $defensores[] = DB::table('defensores')->insertGetId([
                'nombres' => $faker->firstName,
                'apellidos' => $faker->lastName . ' ' . $faker->lastName,
                'cedula_identidad' => 'V-' . $faker->unique()->numberBetween(1000000, 9999999),
                'credencial_colegio' => 'CRED-' . strtoupper($faker->unique()->bothify('??###')),
                'tipo' => $faker->randomElement(['Público', 'Privado']),
                'telefono' => $faker->phoneNumber,
                'email' => $faker->unique()->safeEmail,
                'direccion' => $faker->address,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // ============================
        // 5. Personal (10 nuevos)
        // ============================
        $personal = [];
        for ($i = 0; $i < 10; $i++) {
            $personal[] = DB::table('personal')->insertGetId([
                'nombres' => $faker->firstName,
                'apellidos' => $faker->lastName,
                'cedula_identidad' => 'V-' . $faker->unique()->numberBetween(1000000, 9999999),
                'rol' => $faker->randomElement(['Administrador', 'Custodio', 'Médico']),
                'telefono' => $faker->phoneNumber,
                'email' => $faker->unique()->safeEmail,
                'fecha_contratacion' => $faker->dateTimeBetween('-5 years', 'now'),
                'activo' => $faker->boolean(80),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // ============================
        // 6. Reclusos (100 nuevos)
        // ============================
        $reclusos = [];
        $estados = ['En Ingreso', 'Activo', 'Traslado', 'Libertad'];
        $riesgos = ['Bajo', 'Medio', 'Alto'];
        $sexos = ['M', 'F'];

        for ($i = 0; $i < 100; $i++) {
            $celdaId = $faker->randomElement($celdas);
            $riesgo = $faker->randomElement($riesgos);
            $estado = $faker->randomElement($estados);

            // Verificar compatibilidad de riesgo con el pabellón
            $pabellonId = DB::table('celdas')->where('id', $celdaId)->value('pabellon_id');
            $riesgoPermitido = DB::table('pabellones')->where('id', $pabellonId)->value('riesgo_permitido');
            $jerarquia = ['Bajo' => 1, 'Medio' => 2, 'Alto' => 3];
            if ($jerarquia[$riesgo] > $jerarquia[$riesgoPermitido]) {
                $riesgo = $riesgoPermitido; // Ajustar para que sea compatible
            }

            $reclusoId = DB::table('reclusos')->insertGetId([
                'celda_id' => $celdaId,
                'nombres' => $faker->firstName,
                'apellidos' => $faker->lastName . ' ' . $faker->lastName,
                'cedula_identidad' => 'V-' . $faker->unique()->numberBetween(1000000, 9999999),
                'nivel_riesgo' => $riesgo,
                'estado_operativo' => $estado,
                'fecha_nacimiento' => $faker->dateTimeBetween('-60 years', '-18 years'),
                'huella_dactilar' => $faker->optional()->text(50),
                'foto_perfil' => $faker->optional()->imageUrl(200, 200, 'people'),
                'fecha_ingreso' => $faker->dateTimeBetween('-3 years', 'now'),
                'sexo' => $faker->randomElement($sexos),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            $reclusos[] = $reclusoId;

                        // Cada recluso tiene 1-3 causas penales
            $numCausas = rand(1, 3);
            for ($j = 0; $j < $numCausas; $j++) {
                $estadoProcesal = $faker->randomElement(['En Juicio', 'Sentenciado', 'Apelación']);
                $diasCondena = ($estadoProcesal === 'Sentenciado' || $estadoProcesal === 'Apelación') ? $faker->numberBetween(30, 3650) : null;

                // SOLUCIÓN: Generamos un patrón y obligamos a Faker a que la combinación completa sea única
                $numeroUnico = $faker->unique()->numerify('EXP-' . $faker->year . '-####');

                $causaId = DB::table('causas_penales')->insertGetId([
                    'numero_unico' => $numeroUnico,
                    'delito_principal' => $faker->randomElement(['Homicidio', 'Robo', 'Hurto', 'Estafa', 'Violación', 'Tráfico de Drogas', 'Violencia Doméstica', 'Corrupción']),
                    'estado_procesal' => $estadoProcesal,
                    'tribunal_origen' => 'Tribunal Penal ' . $faker->numberBetween(1, 10),
                    'fecha_apertura' => $faker->dateTimeBetween('-2 years', 'now'),
                    'dias_condena' => $diasCondena,
                    'observaciones' => $faker->optional()->sentence,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                // Relacionar recluso con causa
                DB::table('recluso_causa')->insert([
                    'recluso_id' => $reclusoId,
                    'causa_penal_id' => $causaId,
                    'fecha_asignacion' => now(),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            // Asignar defensor (1-2 por recluso)
            $numDefensores = rand(0, 2);
            if ($numDefensores > 0) {
                $defensoresSeleccionados = $faker->randomElements($defensores, $numDefensores);
                foreach ($defensoresSeleccionados as $defensorId) {
                    DB::table('recluso_defensor')->insert([
                        'recluso_id' => $reclusoId,
                        'defensor_id' => $defensorId,
                        'fecha_asignacion' => now(),
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                }
            }

            // Si el recluso está "Activo" o "Libertad", puede tener redenciones
            if (in_array($estado, ['Activo', 'Libertad'])) {
                $numRedenciones = rand(0, 3);
                for ($r = 0; $r < $numRedenciones; $r++) {
                    $causaIds = DB::table('recluso_causa')->where('recluso_id', $reclusoId)->pluck('causa_penal_id')->toArray();
                    if (count($causaIds) > 0) {
                        $causaId = $faker->randomElement($causaIds);
                        $horas = $faker->numberBetween(20, 200);
                        $factor = $faker->randomFloat(2, 1, 3);
                        $diasRedimidos = floor($horas / $factor);

                        DB::table('redenciones')->insert([
                            'recluso_id' => $reclusoId,
                            'causa_penal_id' => $causaId,
                            'tipo_actividad' => $faker->randomElement(['Laboral', 'Educativa', 'Cultural', 'Deportiva']),
                            'horas_certificadas' => $horas,
                            'factor_conversion' => $factor,
                            'dias_redimidos' => $diasRedimidos,
                            'fecha_registro' => $faker->dateTimeBetween('-1 year', 'now'),
                            'numero_acta' => 'ACTA-' . $faker->unique()->bothify('######'),
                            'juez_ejecucion' => 'Dr. ' . $faker->lastName,
                            'avalado' => $faker->boolean(70),
                            'fecha_avali' => $faker->optional(0.5)->dateTimeBetween('-6 months', 'now'),
                            'observaciones' => $faker->optional()->sentence,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }
                }
            }

            // Si el recluso está "Libertad", crear boleta de excarcelación
            if ($estado === 'Libertad') {
                DB::table('boletas_excarcelacion')->insert([
                    'recluso_id' => $reclusoId,
                    'numero_boleta' => 'BOL-' . $faker->unique()->bothify('######'),
                    'fecha_emision' => $faker->dateTimeBetween('-1 year', 'now'),
                    'nombre_juez' => 'Dra. ' . $faker->lastName,
                    'hash_documento' => hash('sha256', $faker->text(100)),
                    'documento_pdf' => null,
                    'motivo_liberacion' => $faker->randomElement(['Cumplimiento de condena', 'Redención de pena', 'Libertad condicional', 'Beneficio judicial']),
                    'observaciones' => $faker->optional()->sentence,
                    'activa' => true,
                    'fecha_efectiva' => now(),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        // ============================
        // 7. Turnos (50 aleatorios)
        // ============================
        for ($i = 0; $i < 50; $i++) {
            $personalId = $faker->randomElement($personal);
            $pabellonId = $faker->randomElement($pabellones);
            DB::table('turnos')->insert([
                'personal_id' => $personalId,
                'pabellon_id' => $pabellonId,
                'fecha_turno' => $faker->dateTimeBetween('-1 month', '+1 month'),
                'hora_inicio' => $faker->time('H:i:s'),
                'hora_fin' => $faker->time('H:i:s'),
                'estado' => $faker->randomElement(['Programado', 'En Curso', 'Completado', 'Cancelado']),
                'observaciones' => $faker->optional()->sentence,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // ============================
        // 8. Faltas disciplinarias (50 aleatorias)
        // ============================
        for ($i = 0; $i < 50; $i++) {
            $reclusoId = $faker->randomElement($reclusos);
            DB::table('faltas_disciplinarias')->insert([
                'recluso_id' => $reclusoId,
                'descripcion' => $faker->sentence(5),
                'gravedad' => $faker->randomElement(['Leve', 'Grave']),
                'fecha_falta' => $faker->dateTimeBetween('-1 year', 'now'),
                'sancion' => $faker->optional()->word,
                'activa' => $faker->boolean(60),
                'observaciones' => $faker->optional()->sentence,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // ============================
        // 9. Unificaciones (10 aleatorias)
        // ============================
        // Para unificar, necesitamos expedientes con al menos 2 causas sentenciadas.
        // Vamos a buscar reclusos que tengan al menos 2 causas sentenciadas.
        $reclusosConCausas = DB::table('recluso_causa')
            ->join('causas_penales', 'recluso_causa.causa_penal_id', '=', 'causas_penales.id')
            ->where('causas_penales.estado_procesal', 'Sentenciado')
            ->select('recluso_id', DB::raw('count(*) as total'))
            ->groupBy('recluso_id')
            ->having('total', '>=', 2)
            ->pluck('recluso_id')
            ->toArray();

        if (count($reclusosConCausas) > 0) {
            $reclusosElegidos = $faker->randomElements($reclusosConCausas, min(10, count($reclusosConCausas)));
            foreach ($reclusosElegidos as $reclusoId) {
                // Obtener causas sentenciadas de ese recluso
                $causasIds = DB::table('recluso_causa')
                    ->join('causas_penales', 'recluso_causa.causa_penal_id', '=', 'causas_penales.id')
                    ->where('recluso_causa.recluso_id', $reclusoId)
                    ->where('causas_penales.estado_procesal', 'Sentenciado')
                    ->pluck('causas_penales.id')
                    ->toArray();

                if (count($causasIds) >= 2) {
                    // Seleccionar 2-3 causas
                    $causasSeleccionadas = $faker->randomElements($causasIds, rand(2, 3));
                    // Obtener expediente activo del recluso
                    $expediente = DB::table('expedientes')->where('recluso_id', $reclusoId)->where('estado', 'Activo')->first();
                    if ($expediente) {
                        $tipo = $faker->randomElement(['Acumulación', 'Absorción']);
                        $totalDias = 0;
                        if ($tipo === 'Acumulación') {
                            $totalDias = DB::table('causas_penales')->whereIn('id', $causasSeleccionadas)->sum('dias_condena');
                        } else {
                            $totalDias = DB::table('causas_penales')->whereIn('id', $causasSeleccionadas)->max('dias_condena');
                        }

                        $unificacionId = DB::table('unificaciones')->insertGetId([
                            'expediente_id' => $expediente->id,
                            'tipo_unificacion' => $tipo,
                            'orden_judicial' => 'ORD-' . $faker->unique()->bothify('######'),
                            'fecha_resolucion' => $faker->dateTimeBetween('-6 months', 'now'),
                            'total_dias_condena' => $totalDias,
                            'observaciones' => $faker->optional()->sentence,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);

                        foreach ($causasSeleccionadas as $causaId) {
                            DB::table('unificacion_causa')->insert([
                                'unificacion_id' => $unificacionId,
                                'causa_penal_id' => $causaId,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ]);
                            // Cambiar estado de las causas a 'Unificada'
                            DB::table('causas_penales')->where('id', $causaId)->update(['estado_procesal' => 'Unificada']);
                        }
                    }
                }
            }
        }

        $this->command->info('Se han insertado datos de prueba exitosamente.');
    }
}
