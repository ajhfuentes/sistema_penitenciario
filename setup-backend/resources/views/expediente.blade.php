<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Expediente Único</title>
    <style>
        body { font-family: sans-serif; font-size: 12px; }
        h1 { text-align: center; color: #1e3a5f; }
        .header { border-bottom: 2px solid #1e3a5f; margin-bottom: 20px; }
        .section { margin-bottom: 15px; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f4f6f9; }
    </style>
</head>
<body>
    <div class="header">
        <h1>SISTEMA DE GESTIÓN PENITENCIARIA</h1>
        <h2>Expediente Único del Recluso</h2>
    </div>

    <div class="section">
        <strong>ID Sistema:</strong> {{ $recluso->id }} <br>
        <strong>Cédula:</strong> {{ $recluso->cedula_identidad }} <br>
        <strong>Nombre Completo:</strong> {{ $recluso->nombres }} {{ $recluso->apellidos }} <br>
        <strong>Estado Operativo:</strong> {{ $recluso->estado_operativo }} <br>
        <strong>Nivel de Riesgo:</strong> {{ $recluso->nivel_riesgo }} <br>
    </div>

    <div class="section">
        <h3>Causas Penales</h3>
        <table>
            <thead>
                <tr>
                    <th>Nº Causa</th>
                    <th>Delito</th>
                    <th>Estado Procesal</th>
                    <th>Días Condena</th>
                </tr>
            </thead>
            <tbody>
                @forelse($recluso->causas as $causa)
                    <tr>
                        <td>{{ $causa->numero_unico }}</td>
                        <td>{{ $causa->delito_principal }}</td>
                        <td>{{ $causa->estado_procesal }}</td>
                        <td>{{ $causa->dias_condena ?? 'N/A' }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="4">No hay causas registradas.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>
</body>
</html>
