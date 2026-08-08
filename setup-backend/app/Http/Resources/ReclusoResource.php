<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ReclusoResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'nombres' => $this->nombres,
            'apellidos' => $this->apellidos,
            'nombre_completo' => $this->nombre_completo,
            'cedula_identidad' => $this->cedula_identidad,
            'nivel_riesgo' => $this->nivel_riesgo,
            'estado_operativo' => $this->estado_operativo,
            'sexo' => $this->sexo,
            'fecha_nacimiento' => $this->fecha_nacimiento,
            'fecha_ingreso' => $this->fecha_ingreso,
            'celda' => $this->whenLoaded('celda', function () {
                return [
                    'id' => $this->celda->id,
                    'codigo' => $this->celda->codigo,
                    'capacidad_maxima' => $this->celda->capacidad_maxima,
                    'pabellon' => $this->celda->pabellon ? [
                        'id' => $this->celda->pabellon->id,
                        'nombre' => $this->celda->pabellon->nombre,
                        'riesgo_permitido' => $this->celda->pabellon->riesgo_permitido,
                    ] : null,
                ];
            }),
            'causas' => CausaPenalResource::collection($this->whenLoaded('causas')),
            'defensores' => DefensorResource::collection($this->whenLoaded('defensores')),
            'expediente' => $this->whenLoaded('expediente', function () {
                return [
                    'id' => $this->expediente->id,
                    'numero_expediente' => $this->expediente->numero_expediente,
                    'estado' => $this->expediente->estado,
                ];
            }),
            'boleta' => $this->whenLoaded('boleta', function () {
                return [
                    'id' => $this->boleta->id,
                    'numero_boleta' => $this->boleta->numero_boleta,
                    'fecha_emision' => $this->boleta->fecha_emision,
                    'activa' => $this->boleta->activa,
                ];
            }),
            'total_dias_redimidos' => $this->total_dias_redimidos,
            'pena_restante' => $this->pena_restante,
            'tiene_falta_grave' => $this->tiene_falta_grave,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
