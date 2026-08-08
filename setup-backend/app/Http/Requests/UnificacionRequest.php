<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UnificacionRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'expediente_id' => 'required|exists:expedientes,id',
            'tipo_unificacion' => ['required', Rule::in(['Acumulación', 'Absorción'])],
            'causa_ids' => 'required|array|min:2',
            'causa_ids.*' => 'exists:causas_penales,id',
            'orden_judicial' => 'required|string|max:100',
        ];
    }

    public function messages(): array
    {
        return [
            'causa_ids.min' => 'Se requieren al menos 2 causas para la unificación.',
        ];
    }
}
