<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CentroPenalController;
use App\Http\Controllers\Api\PabellonController;
use App\Http\Controllers\Api\CeldaController;
use App\Http\Controllers\Api\ReclusoController;
use App\Http\Controllers\Api\DefensorController;
use App\Http\Controllers\Api\CausaPenalController;
use App\Http\Controllers\Api\ExpedienteController;
use App\Http\Controllers\Api\UnificacionController;
use App\Http\Controllers\Api\RedencionController;
use App\Http\Controllers\Api\BoletaExcarcelacionController;
use App\Http\Controllers\Api\PersonalController;
use App\Http\Controllers\Api\TurnoController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Ruta de prueba pública
Route::get('/test', function () {
    return response()->json(['message' => 'API funcionando correctamente']);
});

// Autenticación
Route::post('/login', [AuthController::class, 'login']);

// Rutas protegidas por Autenticación
Route::middleware('auth:sanctum')->group(function () {
    
    // Usuario autenticado
    Route::get('/user', [AuthController::class, 'user']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // ==========================================
    // GESTIÓN DE USUARIOS (Solo Administradores)
    // ==========================================
    // Nota: El middleware 'role:Administrador' es una forma directa, 
    // o puedes usar 'permiso:Usuarios,creacion' si lo tienes configurado.
    Route::middleware('permiso:Usuarios,todos')->group(function () {
        Route::apiResource('users', UserController::class);
    });

    // ==========================================
    // MÓDULO: REPORTES (Dashboard)
    // ==========================================
    Route::middleware('permiso:Reportes,visualizacion')->group(function () {
        Route::get('/dashboard/stats', function () {
            return response()->json([
                'reclusos' => \App\Models\Recluso::count(),
                'centros_penales' => \App\Models\CentroPenal::count(),
                'personal' => \App\Models\Personal::where('activo', true)->count(),
                'incidencias' => \App\Models\FaltaDisciplinaria::where('activa', true)->count(),
            ]);
        });
    });

    // ==========================================
    // MÓDULO DE CRIMINALES (Reclusos, Centros, etc.)
    // ==========================================

    // --- VISUALIZACIÓN ---
    Route::middleware('permiso:Módulo de Criminales,visualizacion')->group(function () {
        // Reclusos
        Route::get('reclusos/estadisticas', [ReclusoController::class, 'getEstadisticas']);
        Route::get('reclusos/cedula/{cedula}', [ReclusoController::class, 'getByCedula']);
        Route::apiResource('reclusos', ReclusoController::class)->only(['index', 'show']);
        
        // Catálogos y otros
        Route::apiResource('centros-penales', CentroPenalController::class)->only(['index', 'show']);
        Route::apiResource('pabellones', PabellonController::class)->only(['index', 'show']);
        Route::apiResource('celdas', CeldaController::class)->only(['index', 'show']);
        Route::apiResource('defensores', DefensorController::class)->only(['index', 'show']);
        Route::apiResource('causas-penales', CausaPenalController::class)->only(['index', 'show']);
        Route::apiResource('personal', PersonalController::class)->only(['index', 'show']);
        Route::apiResource('turnos', TurnoController::class)->only(['index', 'show']);
        
        // Expedientes
        Route::get('expedientes/recluso/{recluso}', [ExpedienteController::class, 'show']);
        Route::get('expedientes/{expediente}/causas', [ExpedienteController::class, 'getCausas']);
        Route::get('unificaciones/{unificacion}', [UnificacionController::class, 'show']);
    });

    // --- CREACIÓN ---
    Route::middleware('permiso:Módulo de Criminales,creacion')->group(function () {
        Route::apiResource('reclusos', ReclusoController::class)->only(['store']);
        Route::apiResource('centros-penales', CentroPenalController::class)->only(['store']);
        Route::apiResource('pabellones', PabellonController::class)->only(['store']);
        Route::apiResource('celdas', CeldaController::class)->only(['store']);
        Route::apiResource('defensores', DefensorController::class)->only(['store']);
        Route::apiResource('causas-penales', CausaPenalController::class)->only(['store']);
        Route::apiResource('personal', PersonalController::class)->only(['store']);
        Route::apiResource('turnos', TurnoController::class)->only(['store']);
        Route::post('unificaciones', [UnificacionController::class, 'store']);
    });

    // --- EDICIÓN ---
    Route::middleware('permiso:Módulo de Criminales,edicion')->group(function () {
        Route::apiResource('reclusos', ReclusoController::class)->only(['update']);
        Route::apiResource('centros-penales', CentroPenalController::class)->only(['update']);
        Route::apiResource('pabellones', PabellonController::class)->only(['update']);
        Route::apiResource('celdas', CeldaController::class)->only(['update']);
        Route::apiResource('defensores', DefensorController::class)->only(['update']);
        Route::apiResource('causas-penales', CausaPenalController::class)->only(['update']);
        Route::apiResource('personal', PersonalController::class)->only(['update']);
        Route::apiResource('turnos', TurnoController::class)->only(['update']);
        Route::post('expedientes/{expediente}/cerrar', [ExpedienteController::class, 'cerrar']);
    });

    // --- ELIMINACIÓN ---
    Route::middleware('permiso:Módulo de Criminales,eliminacion')->group(function () {
        Route::apiResource('reclusos', ReclusoController::class)->only(['destroy']);
        Route::apiResource('centros-penales', CentroPenalController::class)->only(['destroy']);
        Route::apiResource('pabellones', PabellonController::class)->only(['destroy']);
        Route::apiResource('celdas', CeldaController::class)->only(['destroy']);
        Route::apiResource('defensores', DefensorController::class)->only(['destroy']);
        Route::apiResource('causas-penales', CausaPenalController::class)->only(['destroy']);
        Route::apiResource('personal', PersonalController::class)->only(['destroy']);
        Route::apiResource('turnos', TurnoController::class)->only(['destroy']);
    });

    // ==========================================
    // MÓDULO: HISTORIALES (Redenciones, Boletas)
    // ==========================================

    // --- VISUALIZACIÓN ---
    Route::middleware('permiso:Historiales,visualizacion')->group(function () {
        Route::apiResource('redenciones', RedencionController::class)->only(['index', 'show']);
        Route::apiResource('boletas', BoletaExcarcelacionController::class)->only(['index', 'show']);
    });

    // --- CREACIÓN ---
    Route::middleware('permiso:Historiales,creacion')->group(function () {
        Route::apiResource('redenciones', RedencionController::class)->only(['store']);
        Route::apiResource('boletas', BoletaExcarcelacionController::class)->only(['store']);
    });

    // --- EDICIÓN / ACCIONES ESPECIALES ---
    Route::middleware('permiso:Historiales,edicion')->group(function () {
        Route::apiResource('redenciones', RedencionController::class)->only(['update']);
        Route::apiResource('boletas', BoletaExcarcelacionController::class)->only(['update']);
        Route::post('redenciones/{redencion}/avalar', [RedencionController::class, 'avalar']);
        Route::post('boletas/{boleta}/desactivar', [BoletaExcarcelacionController::class, 'desactivar']);
    });

    // --- ELIMINACIÓN ---
    Route::middleware('permiso:Historiales,eliminacion')->group(function () {
        Route::apiResource('redenciones', RedencionController::class)->only(['destroy']);
        Route::apiResource('boletas', BoletaExcarcelacionController::class)->only(['destroy']);
    });

    // ==========================================
    // MÓDULO DE EXPORTACIONES
    // ==========================================
    Route::get('/export/expediente/{reclusoId}', [App\Http\Controllers\Api\ExportController::class, 'exportarExpedientePdf']);
    Route::get('/export/causa/{causaId}', [App\Http\Controllers\Api\ExportController::class, 'exportarCausaPdf']);
    Route::get('/export/boleta/{boletaId}/xml', [App\Http\Controllers\Api\ExportController::class, 'exportarBoletaXml']);

        // ==========================================
    // MÓDULO DE TRASLADOS
    // ==========================================
    Route::get('traslados', [App\Http\Controllers\Api\TrasladoController::class, 'index']);
    Route::post('traslados', [App\Http\Controllers\Api\TrasladoController::class, 'store']);
    Route::post('traslados/{id}/aprobar', [App\Http\Controllers\Api\TrasladoController::class, 'aprobar']);
    Route::post('traslados/{id}/rechazar', [App\Http\Controllers\Api\TrasladoController::class, 'rechazar']);


});
