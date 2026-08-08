<?php

namespace App\Services;

use App\Models\CausaPenal;
use App\Models\Expediente;
use App\Models\Unificacion;
use Illuminate\Validation\ValidationException;

class UnificacionService
{
    public static function unificar(Expediente $expediente, string $tipo, array $causaIds, string $ordenJudicial): Unificacion
    {
        // Validar que todas las causas estén sentenciadas
        $causas = CausaPenal::whereIn('id', $causaIds)->get();

        if ($causas->count() < 2) {
            throw ValidationException::withMessages([
                'causa_ids' => 'Se requieren al menos dos causas sentenciadas.'
            ]);
        }

        foreach ($causas as $causa) {
            if ($causa->estado_procesal !== 'Sentenciado') {
                throw ValidationException::withMessages([
                    'causa_ids' => "La causa {$causa->numero_unico} no está sentenciada."
                ]);
            }

            if (!$causa->dias_condena || $causa->dias_condena <= 0) {
                throw ValidationException::withMessages([
                    'causa_ids' => "La causa {$causa->numero_unico} no tiene días de condena asignados."
                ]);
            }
        }

        // Calcular total días según tipo
        $totalDias = 0;
        if ($tipo === 'Acumulación') {
            $totalDias = $causas->sum('dias_condena');
        } elseif ($tipo === 'Absorción') {
            $totalDias = $causas->max('dias_condena');
        }

        // Crear unificación
        $unificacion = Unificacion::create([
            'expediente_id' => $expediente->id,
            'tipo_unificacion' => $tipo,
            'orden_judicial' => $ordenJudicial,
            'fecha_resolucion' => now()->toDateString(),
            'total_dias_condena' => $totalDias,
        ]);

        // Asociar causas
        foreach ($causas as $causa) {
            $unificacion->causas()->attach($causa->id);
            // Cambiar estado de la causa a 'Unificada'
            $causa->update(['estado_procesal' => 'Unificada']);
        }

        return $unificacion;
    }
}
