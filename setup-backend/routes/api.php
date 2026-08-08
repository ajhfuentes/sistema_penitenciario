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
use App\Http\Controllers\Api\UserController; //añadido 04/08/26
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Ruta de prueba pública
Route::get('/test', function () {
    return response()->json(['message' => 'API funcionando correctamente']);
});

// Autenticación
Route::post('/login', [AuthController::class, 'login']);

// Rutas protegidas
Route::middleware('auth:sanctum')->group(function () {
    // Usuario
    Route::get('/user', [AuthController::class, 'user']);
    Route::post('/logout', [AuthController::class, 'logout']);
    
    // Gestión de usuarios (solo administradores) //agregada la gestion de usuarios 04/08/26
    Route::get('/users', [App\Http\Controllers\Api\UserController::class, 'index']);
    Route::post('/users', [App\Http\Controllers\Api\UserController::class, 'store']);
    Route::put('/users/{user}', [App\Http\Controllers\Api\UserController::class, 'update']);
    Route::delete('/users/{user}', [App\Http\Controllers\Api\UserController::class, 'destroy']);

    // Dashboard
    Route::get('/dashboard/stats', function () {
        return response()->json([
            'reclusos' => \App\Models\Recluso::count(),
            'centros_penales' => \App\Models\CentroPenal::count(),
            'personal' => \App\Models\Personal::where('activo', true)->count(),
            'incidencias' => \App\Models\FaltaDisciplinaria::where('activa', true)->count(),
        ]);
    });

    // Centros Penales
    Route::apiResource('centros-penales', CentroPenalController::class);
    
    // Pabellones
    Route::apiResource('pabellones', PabellonController::class);
    
    // Celdas
    Route::apiResource('celdas', CeldaController::class);
    
    // Reclusos
    Route::get('reclusos/estadisticas', [ReclusoController::class, 'getEstadisticas']);
    Route::get('reclusos/cedula/{cedula}', [ReclusoController::class, 'getByCedula']);
    Route::apiResource('reclusos', ReclusoController::class);
    
    // Defensores
    Route::apiResource('defensores', DefensorController::class);
    
    // Causas Penales
    Route::apiResource('causas-penales', CausaPenalController::class);
    
    // Expedientes
    Route::get('expedientes/recluso/{recluso}', [ExpedienteController::class, 'show']);
    Route::post('expedientes/{expediente}/cerrar', [ExpedienteController::class, 'cerrar']);
    Route::get('expedientes/{expediente}/causas', [ExpedienteController::class, 'getCausas']);
    
    // Unificaciones
    Route::post('unificaciones', [UnificacionController::class, 'store']);
    Route::get('unificaciones/{unificacion}', [UnificacionController::class, 'show']);
    
    // Redenciones
    Route::apiResource('redenciones', RedencionController::class);
    Route::post('redenciones/{redencion}/avalar', [RedencionController::class, 'avalar']);
    
    // Boletas
    Route::apiResource('boletas', BoletaExcarcelacionController::class);
    Route::post('boletas/{boleta}/desactivar', [BoletaExcarcelacionController::class, 'desactivar']);
    
    // Personal
    Route::apiResource('personal', PersonalController::class);
    
    // Turnos
    Route::apiResource('turnos', TurnoController::class);
});
