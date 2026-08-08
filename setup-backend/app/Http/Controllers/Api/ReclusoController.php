<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ReclusoRequest;
use App\Http\Resources\ReclusoResource;
use App\Models\Celda;
use App\Models\Recluso;
use App\Services\ExpedienteService;
use App\Services\SeguridadService;
use Illuminate\Http\Request;

class ReclusoController extends Controller
{
    public function index()
    {
        $reclusos = Recluso::with(['celda.pabellon', 'causas', 'defensores'])->get();
        return ReclusoResource::collection($reclusos);
    }

    public function store(ReclusoRequest $request)
    {
        $data = $request->validated();

        // Validar aforo de celda
        if (isset($data['celda_id'])) {
            $celda = Celda::find($data['celda_id']);
            if ($celda) {
                SeguridadService::validarAforoCelda($celda);
            }
        }

        // Crear recluso
        $recluso = Recluso::create($data);

        // Crear expediente automáticamente
        ExpedienteService::crearExpediente($recluso);

        return new ReclusoResource($recluso->load(['celda', 'causas', 'defensores']));
    }

    public function show(Recluso $recluso)
    {
        return new ReclusoResource($recluso->load(['celda.pabellon', 'causas', 'defensores', 'expediente', 'boleta']));
    }

    public function update(ReclusoRequest $request, Recluso $recluso)
    {
        $data = $request->validated();

        // Si se cambia celda, validar aforo
        if (isset($data['celda_id']) && $data['celda_id'] != $recluso->celda_id) {
            $celda = Celda::find($data['celda_id']);
            if ($celda) {
                SeguridadService::validarAforoCelda($celda);
            }
        }

        $recluso->update($data);
        return new ReclusoResource($recluso->load(['celda', 'causas', 'defensores']));
    }

    public function destroy(Recluso $recluso)
    {
        $recluso->delete();
        return response()->json(['message' => 'Recluso eliminado correctamente']);
    }

    public function getByCedula($cedula)
    {
        $recluso = Recluso::with(['celda.pabellon', 'causas', 'defensores'])
                          ->where('cedula_identidad', $cedula)
                          ->first();

        if (!$recluso) {
            return response()->json(['message' => 'Recluso no encontrado'], 404);
        }

        return new ReclusoResource($recluso);
    }

    public function getEstadisticas()
    {
        $total = Recluso::count();
        $activos = Recluso::where('estado_operativo', 'Activo')->count();
        $enIngreso = Recluso::where('estado_operativo', 'En Ingreso')->count();
        $traslado = Recluso::where('estado_operativo', 'Traslado')->count();
        $libertad = Recluso::where('estado_operativo', 'Libertad')->count();

        $riesgoAlto = Recluso::where('nivel_riesgo', 'Alto')->count();
        $riesgoMedio = Recluso::where('nivel_riesgo', 'Medio')->count();
        $riesgoBajo = Recluso::where('nivel_riesgo', 'Bajo')->count();

        return response()->json([
            'total' => $total,
            'activos' => $activos,
            'en_ingreso' => $enIngreso,
            'traslado' => $traslado,
            'libertad' => $libertad,
            'riesgo' => [
                'Alto' => $riesgoAlto,
                'Medio' => $riesgoMedio,
                'Bajo' => $riesgoBajo,
            ],
            'porcentaje_riesgo' => [
                'Alto' => $total > 0 ? round(($riesgoAlto / $total) * 100, 1) : 0,
                'Medio' => $total > 0 ? round(($riesgoMedio / $total) * 100, 1) : 0,
                'Bajo' => $total > 0 ? round(($riesgoBajo / $total) * 100, 1) : 0,
            ]
        ]);
    }
}
