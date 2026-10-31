<?xml version="1.0" encoding="UTF-8"?>
<boleta_excarcelacion>
    <numero_boleta>{{ $boleta->numero_boleta }}</numero_boleta>
    <fecha_emision>{{ $boleta->fecha_emision }}</fecha_emision>
    <nombre_juez>{{ $boleta->nombre_juez }}</nombre_juez>
    <motivo_liberacion>{{ $boleta->motivo_liberacion }}</motivo_liberacion>
    <recluso>
        <cedula>{{ $boleta->recluso->cedula_identidad }}</cedula>
        <nombre_completo>{{ $boleta->recluso->nombres }} {{ $boleta->recluso->apellidos }}</nombre_completo>
    </recluso>
</xml_boleta>




