<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CausaPenalResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'numero_unico' => $this->numero_unico,
            'delito_principal' => $this->delito_principal,
            'estado_procesal' => $this->estado_procesal,
            'tribunal_origen' => $this->tribunal_origen,
            'fecha_apertura' => $this->fecha_apertura,
            'dias_condena' => $this->dias_condena,
            'observaciones' => $this->observaciones,
            'puede_unificarse' => $this->estado_procesal === 'Sentenciado' && $this->dias_condena > 0,
        ];
    }
}
