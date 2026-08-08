<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class BoletaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'recluso_id' => 'required|exists:reclusos,id',
            'numero_boleta' => 'required|string|max:50|unique:boletas_excarcelacion',
            'nombre_juez' => 'required|string|max:100',
            'documento_pdf' => 'nullable|string',
            'motivo_liberacion' => 'required|string|max:200',
            'observaciones' => 'nullable|string',
        ];
    }
}
