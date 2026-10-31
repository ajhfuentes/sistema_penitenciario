<!DOCTYPE html>
<html>
<head>
    <title>Expediente</title>
    <style>
        body { font-family: sans-serif; }
        h1 { text-align: center; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #000; padding: 5px; }
    </style>
</head>
<body>
    <h1>Expediente Único - SGP</h1>
    <p><strong>Recluso:</strong> {{ $recluso->nombres }} {{ $recluso->apellidos }}</p>
    <p><strong>Cédula:</strong> {{ $recluso->cedula_identidad }}</p>
    <p><strong>Riesgo:</strong> {{ $recluso->nivel_riesgo }}</p>
    
    <h3>Causas</h3>
    <table>
        <thead>
            <tr><th>Nº Causa</th><th>Delito</th><th>Estado</th></tr>
        </thead>
        <tbody>
            @foreach($recluso->causas as $causa)
            <tr>
                <td>{{ $causa->numero_unico }}</td>
                <td>{{ $causa->delito_principal }}</td>
                <td>{{ $causa->estado_procesal }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>
