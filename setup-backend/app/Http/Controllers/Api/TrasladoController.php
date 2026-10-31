<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Traslado;
use App\Models\Recluso;
use App\Models\Celda;
use App\Services\SeguridadService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TrasladoController extends Controller
{
    public function index()
    {
        $traslados = Traslado::with(['recluso', 'centroOrigen', 'centroDestino', 'celdaDestino'])
            ->orderBy('created_at', 'desc')
            ->get();
        return response()->json(['data' => $traslados]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'recluso_id' => 'required|exists:reclusos,id',
            'centro_destino_id' => 'required|exists:centros_penales,id',
            'motivo' => 'required|string'
        ]);

        $recluso = Recluso::with('celda.pabellon')->findOrFail($request->recluso_id);

        if (!$recluso->celda) {
            return response()->json(['error' => 'El recluso no tiene una celda asignada actualmente.'], 400);
        }

        $traslado = Traslado::create([
            'recluso_id' => $recluso->id,
            'centro_origen_id' => $recluso->celda->pabellon->centro_penal_id,
            'centro_destino_id' => $request->centro_destino_id,
            'motivo' => $request->motivo,
            'estado' => 'Pendiente'
        ]);

        return response()->json(['message' => 'Solicitud de traslado creada', 'data' => $traslado], 201);
    }

    public function aprobar(Request $request, $id)
    {
        $request->validate([
            'celda_destino_id' => 'required|exists:celdas,id',
            'juez_autorizante' => 'required|string'
        ]);

        $traslado = Traslado::findOrFail($id);
        
        if ($traslado->estado !== 'Pendiente') {
            return response()->json(['error' => 'El traslado ya fue procesado anteriormente.'], 400);
        }

        DB::beginTransaction();
        try {
            $celdaDestino = Celda::with('pabellon')->findOrFail($request->celda_destino_id);
            $recluso = $traslado->recluso;

            // Validaciones de negocio (Aforo y Riesgo)
            SeguridadService::validarAforoCelda($celdaDestino);
            SeguridadService::validarRiesgoRecluso($recluso, $celdaDestino->pabellon);

            // Ejecutar el movimiento del recluso
            $recluso->update([
                'celda_id' => $celdaDestino->id,
                'estado_operativo' => 'Activo' 
            ]);

            // Completar el traslado
            $traslado->update([
                'estado' => 'Completado',
                'celda_destino_id' => $celdaDestino->id,
                'juez_autorizante' => $request->juez_autorizante
            ]);

            DB::commit();
            return response()->json(['message' => 'Traslado ejecutado y recluso reubicado correctamente.']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => $e->getMessage()], 422);
        }
    }

    public function rechazar(Request $request, $id)
    {
        $traslado = Traslado::findOrFail($id);
        
        if ($traslado->estado !== 'Pendiente') {
            return response()->json(['error' => 'El traslado ya fue procesado.'], 400);
        }

        $traslado->update([
            'estado' => 'Rechazado',
            'juez_autorizante' => $request->juez_autorizante ?? 'N/A'
        ]);

        return response()->json(['message' => 'Traslado rechazado.']);
    }
}
