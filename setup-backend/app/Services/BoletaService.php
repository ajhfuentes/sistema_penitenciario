<?php

namespace App\Services;

use App\Models\BoletaExcarcelacion;
use App\Models\Recluso;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class BoletaService
{
    public static function emitirBoleta(Recluso $recluso, array $data): BoletaExcarcelacion
    {
        // Verificar que no tenga boleta activa
        if ($recluso->boleta) {
            throw ValidationException::withMessages([
                'recluso_id' => 'El recluso ya tiene una boleta de excarcelación activa.'
            ]);
        }

        // Verificar que el recluso pueda ser liberado
        if ($recluso->estado_operativo === 'Libertad') {
            throw ValidationException::withMessages([
                'recluso_id' => 'El recluso ya está en libertad.'
            ]);
        }

        // Generar hash del documento (simulado)
        $hash = null;
        if (!empty($data['documento_pdf'])) {
            $hash = Hash::make($data['documento_pdf']);
        }

        $boleta = BoletaExcarcelacion::create([
            'recluso_id' => $recluso->id,
            'numero_boleta' => $data['numero_boleta'],
            'fecha_emision' => now()->toDateString(),
            'nombre_juez' => $data['nombre_juez'],
            'hash_documento' => $hash,
            'documento_pdf' => $data['documento_pdf'] ?? null,
            'motivo_liberacion' => $data['motivo_liberacion'],
            'observaciones' => $data['observaciones'] ?? null,
            'activa' => true,
            'fecha_efectiva' => now(),
        ]);

        // Cambiar estado del recluso a 'Libertad'
        $recluso->update(['estado_operativo' => 'Libertad']);

        // Cerrar expediente activo
        $expediente = $recluso->expediente;
        if ($expediente) {
            ExpedienteService::cerrarExpediente($expediente);
        }

        return $boleta;
    }
}
