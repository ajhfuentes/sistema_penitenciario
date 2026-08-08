<?php

namespace App\Services;

use App\Models\Celda;
use App\Models\Pabellon;
use App\Models\Recluso;
use Illuminate\Validation\ValidationException;

class SeguridadService
{
    public static function validarTechoSeguridad(Pabellon $pabellon): void
    {
        $centro = $pabellon->centroPenal;
        $nivelCentro = $centro->nivel_seguridad;
        $riesgo = $pabellon->riesgo_permitido;

        $compatible = match ($nivelCentro) {
            'Máxima' => in_array($riesgo, ['Alto', 'Medio', 'Bajo']),
            'Media' => in_array($riesgo, ['Medio', 'Bajo']),
            'Mínima' => $riesgo === 'Bajo',
            default => false,
        };

        if (!$compatible) {
            throw ValidationException::withMessages([
                'riesgo_permitido' => "El riesgo '{$riesgo}' no es compatible con el nivel de seguridad '{$nivelCentro}' del centro penal."
            ]);
        }
    }

    public static function validarAforoCelda(Celda $celda): void
    {
        $ocupados = $celda->reclusos()->count();
        if ($ocupados >= $celda->capacidad_maxima) {
            throw ValidationException::withMessages([
                'celda_id' => "La celda está llena (aforo máximo: {$celda->capacidad_maxima})."
            ]);
        }
    }

    public static function validarRiesgoRecluso(Recluso $recluso, Pabellon $pabellon): void
    {
        $riesgoRecluso = $recluso->nivel_riesgo;
        $riesgoPermitido = $pabellon->riesgo_permitido;

        $jerarquia = ['Bajo' => 1, 'Medio' => 2, 'Alto' => 3];

        if ($jerarquia[$riesgoRecluso] > $jerarquia[$riesgoPermitido]) {
            throw ValidationException::withMessages([
                'nivel_riesgo' => "El riesgo del recluso ({$riesgoRecluso}) excede el permitido en el pabellón ({$riesgoPermitido})."
            ]);
        }
    }

    public static function validarEstadoRecluso(Recluso $recluso): void
    {
        if ($recluso->estado_operativo === 'Libertad') {
            throw ValidationException::withMessages([
                'estado_operativo' => 'El recluso ya se encuentra en libertad.'
            ]);
        }
    }

    public static function validarCausasEnJuicio(array $causaIds): void
    {
        $causas = \App\Models\CausaPenal::whereIn('id', $causaIds)->get();

        foreach ($causas as $causa) {
            if ($causa->estado_procesal === 'En Juicio') {
                throw ValidationException::withMessages([
                    'causa_ids' => "La causa {$causa->numero_unico} está en juicio y no puede ser unificada."
                ]);
            }
        }
    }
}
