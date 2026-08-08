<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ReclusoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $reclusoId = $this->route('recluso') ? $this->route('recluso')->id : null;

        return [
            'celda_id' => 'nullable|exists:celdas,id',
            'nombres' => 'required|string|max:100',
            'apellidos' => 'required|string|max:100',
            'cedula_identidad' => [
                'required',
                'string',
                'max:20',
                Rule::unique('reclusos')->ignore($reclusoId),
            ],
            'nivel_riesgo' => ['required', Rule::in(['Bajo', 'Medio', 'Alto'])],
            'estado_operativo' => ['required', Rule::in(['En Ingreso', 'Activo', 'Traslado', 'Libertad'])],
            'fecha_nacimiento' => 'nullable|date',
            'huella_dactilar' => 'nullable|string',
            'foto_perfil' => 'nullable|string|max:255',
            'sexo' => ['nullable', Rule::in(['M', 'F'])],
        ];
    }

    public function messages(): array
    {
        return [
            'cedula_identidad.unique' => 'Ya existe un recluso con esa cédula de identidad.',
            'nivel_riesgo.in' => 'El nivel de riesgo debe ser Bajo, Medio o Alto.',
            'estado_operativo.in' => 'El estado operativo debe ser En Ingreso, Activo, Traslado o Libertad.',
        ];
    }
}
