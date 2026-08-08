<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\BoletaRequest;
use App\Http\Resources\BoletaResource;
use App\Models\BoletaExcarcelacion;
use App\Models\Recluso;
use App\Services\BoletaService;
use Illuminate\Http\Request;

class BoletaExcarcelacionController extends Controller
{
    public function index()
    {
        $boletas = BoletaExcarcelacion::with('recluso')->get();
        return BoletaResource::collection($boletas);
    }

    public function store(BoletaRequest $request)
    {
        $data = $request->validated();
        $recluso = Recluso::find($data['recluso_id']);

        if (!$recluso) {
            return response()->json(['message' => 'Recluso no encontrado'], 404);
        }

        $boleta = BoletaService::emitirBoleta($recluso, $data);

        return new BoletaResource($boleta->load('recluso'));
    }

    public function show(BoletaExcarcelacion $boleta)
    {
        return new BoletaResource($boleta->load('recluso'));
    }

    public function desactivar(BoletaExcarcelacion $boleta)
    {
        $boleta->update(['activa' => false]);
        return response()->json(['message' => 'Boleta desactivada correctamente']);
    }
}
