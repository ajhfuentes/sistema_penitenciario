<?php

namespace App\Services;

use App\Models\Redencion;
use App\Models\Recluso;
use Illuminate\Validation\ValidationException;

class RedencionService
{
    public static function registrarRedencion(Recluso $recluso, array $data): Redencion
    {
        // Verificar estado activo
        if ($recluso->estado_operativo !== 'Activo') {
            throw ValidationException::withMessages([
                'recluso_id' => 'El recluso debe estar en estado Activo para redimir pena.'
            ]);
        }

        // Verificar faltas graves
        if ($recluso->tiene_falta_grave) {
            throw ValidationException::withMessages([
                'recluso_id' => 'El recluso tiene una falta disciplinaria grave activa, no puede redimir pena.'
            ]);
        }

        // Verificar que tenga al menos una causa sentenciada
        $causasSentenciadas = $recluso->causas()->where('estado_procesal', 'Sentenciado')->count();
        if ($causasSentenciadas === 0) {
            throw ValidationException::withMessages([
                'recluso_id' => 'El recluso no tiene causas sentenciadas para redimir.'
            ]);
        }

        // Calcular días redimidos
        $factor = $data['factor_conversion'] ?? 2;
        $diasRedimidos = floor($data['horas_certificadas'] / $factor);

        if ($diasRedimidos <= 0) {
            throw ValidationException::withMessages([
                'horas_certificadas' => 'Las horas certificadas no son suficientes para redimir al menos 1 día.'
            ]);
        }

        return Redencion::create([
            'recluso_id' => $recluso->id,
            'causa_penal_id' => $data['causa_penal_id'] ?? null,
            'tipo_actividad' => $data['tipo_actividad'],
            'horas_certificadas' => $data['horas_certificadas'],
            'factor_conversion' => $factor,
            'dias_redimidos' => $diasRedimidos,
            'fecha_registro' => now()->toDateString(),
            'numero_acta' => $data['numero_acta'],
            'juez_ejecucion' => $data['juez_ejecucion'],
            'avalado' => false,
        ]);
    }

    public static function avalar(Redencion $redencion): void
    {
        if ($redencion->avalado) {
            throw ValidationException::withMessages([
                'avalado' => 'Esta redención ya fue avalada.'
            ]);
        }

        $redencion->update([
            'avalado' => true,
            'fecha_avali' => now(),
        ]);

        // Actualizar estado del recluso si corresponde
        $recluso = $redencion->recluso;
        $penaRestante = $recluso->pena_restante;

        if ($penaRestante <= 0) {
            $recluso->update(['estado_operativo' => 'Libertad']);
        }
    }
}
