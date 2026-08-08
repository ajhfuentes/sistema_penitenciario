// src/components/centros/CentroPenalForm.js
import React, { useState } from 'react';
import { centroPenalService } from '../../services/centroPenalService';

const CentroPenalForm = ({ initialData, onSave, onCancel, isEdit }) => {
    const [form, setForm] = useState({
        nombre: initialData?.nombre || '',
        ubicacion: initialData?.ubicacion || '',
        capacidad_aforo: initialData?.capacidad_aforo || '',
        nivel_seguridad: initialData?.nivel_seguridad || 'Media',
    });
    const [submitting, setSubmitting] = useState(false);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            if (isEdit) {
                await centroPenalService.update(initialData.id, form);
            } else {
                await centroPenalService.create(form);
            }
            onSave();
        } catch (err) {
            alert('Error al guardar');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            <div className="form-group">
                <label>Nombre</label>
                <input name="nombre" value={form.nombre} onChange={handleChange} required />
            </div>
            <div className="form-group">
                <label>Ubicación</label>
                <input name="ubicacion" value={form.ubicacion} onChange={handleChange} required />
            </div>
            <div className="form-group">
                <label>Capacidad</label>
                <input type="number" name="capacidad_aforo" value={form.capacidad_aforo} onChange={handleChange} required />
            </div>
            <div className="form-group">
                <label>Nivel de Seguridad</label>
                <select name="nivel_seguridad" value={form.nivel_seguridad} onChange={handleChange}>
                    <option value="Mínima">Mínima</option>
                    <option value="Media">Media</option>
                    <option value="Máxima">Máxima</option>
                </select>
            </div>
            <div className="form-actions">
                <button type="button" className="btn btn-secondary" onClick={onCancel}>Cancelar</button>
                <button type="submit" className="btn btn-primary" disabled={submitting}>
                    {submitting ? 'Guardando...' : 'Guardar'}
                </button>
            </div>
        </form>
    );
};

export default CentroPenalForm;
