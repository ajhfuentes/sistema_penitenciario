<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\UnificacionRequest;
use App\Http\Resources\UnificacionResource;
use App\Models\Expediente;
use App\Services\UnificacionService;
use Illuminate\Http\Request;

class UnificacionController extends Controller
{
    public function store(UnificacionRequest $request)
    {
        $data = $request->validated();

        $expediente = Expediente::find($data['expediente_id']);

        if (!$expediente || $expediente->estado !== 'Activo') {
            return response()->json(['message' => 'El expediente no está activo'], 422);
        }

        $unificacion = UnificacionService::unificar(
            $expediente,
            $data['tipo_unificacion'],
            $data['causa_ids'],
            $data['orden_judicial']
        );

        return new UnificacionResource($unificacion->load('causas', 'expediente.recluso'));
    }

    public function show(Unificacion $unificacion)
    {
        return new UnificacionResource($unificacion->load('causas', 'expediente.recluso'));
    }
}
