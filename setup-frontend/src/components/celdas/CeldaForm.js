// src/components/celdas/CeldaForm.js
import React, { useState } from 'react';
import { celdaService } from '../../services/celdaService';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSave, faTimes } from '@fortawesome/free-solid-svg-icons';

const CeldaForm = ({ initialData, pabellones, onSave, onCancel, isEdit }) => {
    const [form, setForm] = useState({
        pabellon_id: initialData?.pabellon_id || '',
        codigo: initialData?.codigo || '',
        capacidad_maxima: initialData?.capacidad_maxima || '',
    });
    const [submitting, setSubmitting] = useState(false);
    const [error, setError] = useState(null);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
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
                await celdaService.update(initialData.id, data);
            } else {
                await celdaService.create(data);
            }
            onSave();
        } catch (err) {
            setError(err.response?.data?.message || 'Error al guardar la celda');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            {error && <div className="error-message">{error}</div>}

            <div className="form-group">
                <label>Pabellón *</label>
                <select
                    name="pabellon_id"
                    value={form.pabellon_id}
                    onChange={handleChange}
                    required
                >
                    <option value="">Seleccionar pabellón</option>
                    {pabellones.map(p => (
                        <option key={p.id} value={p.id}>
                            {p.nombre} (Riesgo: {p.riesgo_permitido})
                        </option>
                    ))}
                </select>
            </div>

            <div className="form-group">
                <label>Código de Celda *</label>
                <input
                    type="text"
                    name="codigo"
                    value={form.codigo}
                    onChange={handleChange}
                    placeholder="Ej: A-001, B-02, C-12"
                    required
                />
                <small className="help-text">Código único dentro del pabellón</small>
            </div>

            <div className="form-group">
                <label>Capacidad Máxima *</label>
                <input
                    type="number"
                    name="capacidad_maxima"
                    value={form.capacidad_maxima}
                    onChange={handleChange}
                    min="1"
                    max="50"
                    required
                />
                <small className="help-text">Número máximo de reclusos que puede albergar</small>
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

export default CeldaForm;
