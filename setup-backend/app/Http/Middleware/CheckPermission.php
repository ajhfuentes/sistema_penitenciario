<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckPermission
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, $modulo, $accion): Response
    {
        $user = $request->user();

        if (!$user) {
            return response()->json(['error' => 'No autenticado'], 401);
        }

        // El Administrador siempre tiene acceso total
        if ($user->rol === 'Administrador') {
            return $next($request);
        }

        // Revisar el JSON de permisos del usuario
        $permisos = $user->permisos ?? [];
        $permisosModulo = $permisos[$modulo] ?? [];

        // Si la acción solicitada no está en su lista de permisos, se deniega
        if (!in_array($accion, $permisosModulo)) {
            return response()->json([
                'error' => 'No tiene permisos para realizar esta acción.',
                'modulo' => $modulo,
                'accion_requerida' => $accion
            ], 403); // 403 significa "Prohibido"
        }

        return $next($request);
    }
}
