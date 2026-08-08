<?php

namespace App\Services;

use App\Models\Expediente;
use App\Models\Recluso;
use Illuminate\Validation\ValidationException;

class ExpedienteService
{
    public static function crearExpediente(Recluso $recluso): Expediente
    {
        // Verificar si ya tiene expediente activo
        $activo = $recluso->expediente;
        if ($activo) {
            throw ValidationException::withMessages([
                'recluso' => 'El recluso ya tiene un expediente activo.'
            ]);
        }

        $numero = 'EXP-' . str_pad($recluso->id, 6, '0', STR_PAD_LEFT);

        return Expediente::create([
            'recluso_id' => $recluso->id,
            'numero_expediente' => $numero,
            'fecha_creacion' => now()->toDateString(),
            'estado' => 'Activo',
        ]);
    }

    public static function cerrarExpediente(Expediente $expediente): void
    {
        if ($expediente->estado !== 'Activo') {
            throw ValidationException::withMessages([
                'estado' => 'El expediente ya está cerrado.'
            ]);
        }

        $expediente->update(['estado' => 'Cerrado']);
    }

    public static function getCausasUnificables(Expediente $expediente): array
    {
        $causas = $expediente->recluso->causas()
            ->where('estado_procesal', 'Sentenciado')
            ->where('dias_condena', '>', 0)
            ->get();

        return $causas->toArray();
    }
}
