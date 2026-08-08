<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\ExpedienteResource;
use App\Models\Expediente;
use App\Models\Recluso;
use App\Services\ExpedienteService;
use Illuminate\Http\Request;

class ExpedienteController extends Controller
{
    public function show(Recluso $recluso)
    {
        $expediente = $recluso->expediente;

        if (!$expediente) {
            return response()->json(['message' => 'El recluso no tiene expediente activo'], 404);
        }

        return new ExpedienteResource($expediente->load('recluso', 'unificaciones.causas'));
    }

    public function cerrar(Expediente $expediente)
    {
        ExpedienteService::cerrarExpediente($expediente);
        return response()->json(['message' => 'Expediente cerrado correctamente']);
    }

    public function getCausas(Expediente $expediente)
    {
        $causas = $expediente->recluso->causas;
        return response()->json($causas);
    }
}
