<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class RedencionRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'recluso_id' => 'required|exists:reclusos,id',
            'causa_penal_id' => 'nullable|exists:causas_penales,id',
            'tipo_actividad' => ['required', Rule::in(['Laboral', 'Educativa', 'Cultural', 'Deportiva'])],
            'horas_certificadas' => 'required|integer|min:1',
            'factor_conversion' => 'nullable|numeric|min:1',
            'numero_acta' => 'required|string|max:50|unique:redenciones',
            'juez_ejecucion' => 'required|string|max:100',
            'observaciones' => 'nullable|string',
        ];
    }
}
