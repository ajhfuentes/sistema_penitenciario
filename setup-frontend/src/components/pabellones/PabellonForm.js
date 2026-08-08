// src/components/pabellones/PabellonForm.js
import React, { useState } from 'react';
import { pabellonService } from '../../services/pabellonService';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSave, faTimes } from '@fortawesome/free-solid-svg-icons';

const PabellonForm = ({ initialData, centros, onSave, onCancel, isEdit }) => {
    const [form, setForm] = useState({
        centro_penal_id: initialData?.centro_penal_id || '',
        nombre: initialData?.nombre || '',
        riesgo_permitido: initialData?.riesgo_permitido || 'Bajo',
        capacidad_maxima: initialData?.capacidad_maxima || '',
    });
    const [submitting, setSubmitting] = useState(false);
    const [error, setError] = useState(null);

    // Obtener nivel de seguridad del centro seleccionado
    const getCentroNivel = (centroId) => {
        const centro = centros.find(c => c.id === parseInt(centroId));
        return centro ? centro.nivel_seguridad : null;
    };

    // Riesgos permitidos según nivel de seguridad
    const getRiesgosPermitidos = (centroId) => {
        const nivel = getCentroNivel(centroId);
        if (!nivel) return ['Bajo', 'Medio', 'Alto'];
        if (nivel === 'Máxima') return ['Bajo', 'Medio', 'Alto'];
        if (nivel === 'Media') return ['Bajo', 'Medio'];
        return ['Bajo'];
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
        // Resetear riesgo si cambia centro
        if (name === 'centro_penal_id') {
            const riesgos = getRiesgosPermitidos(value);
            setForm(prev => ({ ...prev, riesgo_permitido: riesgos[0] || 'Bajo' }));
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError(null);
        setSubmitting(true);

        try {
            const data = {
                ...form,
                capacidad_maxima: parseInt(form.capacidad_maxima)
            };
            if (isEdit) {
                await pabellonService.update(initialData.id, data);
            } else {
                await pabellonService.create(data);
            }
            onSave();
        } catch (err) {
            setError(err.response?.data?.message || 'Error al guardar el pabellón');
        } finally {
            setSubmitting(false);
        }
    };

    const riesgosDisponibles = getRiesgosPermitidos(form.centro_penal_id);
    const centroNivel = getCentroNivel(form.centro_penal_id);

    return (
        <form onSubmit={handleSubmit}>
            {error && <div className="error-message">{error}</div>}

            <div className="form-group">
                <label>Centro Penal *</label>
                <select
                    name="centro_penal_id"
                    value={form.centro_penal_id}
                    onChange={handleChange}
                    required
                >
                    <option value="">Seleccionar centro</option>
                    {centros.map(c => (
                        <option key={c.id} value={c.id}>
                            {c.nombre} ({c.nivel_seguridad})
                        </option>
                    ))}
                </select>
                {centroNivel && (
                    <small className="help-text">
                        Nivel de seguridad del centro: <strong>{centroNivel}</strong>
                    </small>
                )}
            </div>

            <div className="form-group">
                <label>Nombre del Pabellón *</label>
                <input
                    type="text"
                    name="nombre"
                    value={form.nombre}
                    onChange={handleChange}
                    placeholder="Ej: Pabellón A"
                    required
                />
            </div>

            <div className="form-row">
                <div className="form-group">
                    <label>Riesgo Permitido *</label>
                    <select
                        name="riesgo_permitido"
                        value={form.riesgo_permitido}
                        onChange={handleChange}
                        required
                    >
                        {riesgosDisponibles.map(r => (
                            <option key={r} value={r}>{r}</option>
                        ))}
                    </select>
                    <small className="help-text">
                        {centroNivel === 'Máxima' && 'Centro Máxima: permite Alto, Medio y Bajo'}
                        {centroNivel === 'Media' && 'Centro Media: permite Medio y Bajo'}
                        {centroNivel === 'Mínima' && 'Centro Mínima: solo permite Bajo'}
                    </small>
                </div>

                <div className="form-group">
                    <label>Capacidad Máxima *</label>
                    <input
                        type="number"
                        name="capacidad_maxima"
                        value={form.capacidad_maxima}
                        onChange={handleChange}
                        min="1"
                        max="1000"
                        required
                    />
                </div>
            </div>

            <div className="form-actions">
                <button type="button" className="btn btn-secondary" onClick={onCancel}>
                    <FontAwesomeIcon icon={faTimes} /> Cancelar
                </button>
                <button type="submit" className="btn btn-primary" disabled={submitting}>
                    <FontAwesomeIcon icon={faSave} /> {submitting ? 'Guardando...' : 'Guardar'}
                </button>
            </div>
        </form>
    );
};

export default PabellonForm;
