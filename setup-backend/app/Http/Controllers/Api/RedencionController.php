<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\RedencionRequest;
use App\Http\Resources\RedencionResource;
use App\Models\Redencion;
use App\Models\Recluso;
use App\Services\RedencionService;
use Illuminate\Http\Request;

class RedencionController extends Controller
{
    public function index()
    {
        $redenciones = Redencion::with(['recluso', 'causaPenal'])->get();
        return RedencionResource::collection($redenciones);
    }

    public function store(RedencionRequest $request)
    {
        $data = $request->validated();
        $recluso = Recluso::find($data['recluso_id']);

        if (!$recluso) {
            return response()->json(['message' => 'Recluso no encontrado'], 404);
        }

        $redencion = RedencionService::registrarRedencion($recluso, $data);

        return new RedencionResource($redencion->load('recluso', 'causaPenal'));
    }

    public function show(Redencion $redencion)
    {
        return new RedencionResource($redencion->load('recluso', 'causaPenal'));
    }

    public function avalar(Redencion $redencion)
    {
        RedencionService::avalar($redencion);
        return response()->json(['message' => 'Redención avalada correctamente']);
    }
}
