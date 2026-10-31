<!DOCTYPE html>
<html>
<head>
    <title>Causa Penal</title>
</head>
<body>
    <h1>Causa Penal: {{ $causa->numero_unico }}</h1>
    <p><strong>Delito:</strong> {{ $causa->delito_principal }}</p>
    <p><strong>Tribunal:</strong> {{ $causa->tribunal_origen }}</p>
    <p><strong>Estado:</strong> {{ $causa->estado_procesal }}</p>
</body>
</html>
