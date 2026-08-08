// src/components/defensores/DefensorForm.js
import React, { useState } from 'react';
import { defensorService } from '../../services/defensorService';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSave, faTimes } from '@fortawesome/free-solid-svg-icons';

const DefensorForm = ({ initialData, onSave, onCancel, isEdit }) => {
    const [form, setForm] = useState({
        nombres: initialData?.nombres || '',
        apellidos: initialData?.apellidos || '',
        cedula_identidad: initialData?.cedula_identidad || '',
        credencial_colegio: initialData?.credencial_colegio || '',
        tipo: initialData?.tipo || 'Público',
        telefono: initialData?.telefono || '',
        email: initialData?.email || '',
        direccion: initialData?.direccion || '',
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
            if (isEdit) {
                await defensorService.update(initialData.id, form);
            } else {
                await defensorService.create(form);
            }
            onSave();
        } catch (err) {
            setError(err.response?.data?.message || 'Error al guardar el defensor');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            {error && <div className="error-message">{error}</div>}

            <div className="form-row">
                <div className="form-group">
                    <label>Nombres *</label>
                    <input
                        type="text"
                        name="nombres"
                        value={form.nombres}
                        onChange={handleChange}
                        placeholder="Nombres completos"
                        required
                    />
                </div>
                <div className="form-group">
                    <label>Apellidos *</label>
                    <input
                        type="text"
                        name="apellidos"
                        value={form.apellidos}
                        onChange={handleChange}
                        placeholder="Apellidos completos"
                        required
                    />
                </div>
            </div>

            <div className="form-row">
                <div className="form-group">
                    <label>Cédula de Identidad *</label>
                    <input
                        type="text"
                        name="cedula_identidad"
                        value={form.cedula_identidad}
                        onChange={handleChange}
                        placeholder="V-12345678"
                        required
                    />
                </div>
                <div className="form-group">
                    <label>Credencial del Colegio *</label>
                    <input
                        type="text"
                        name="credencial_colegio"
                        value={form.credencial_colegio}
                        onChange={handleChange}
                        placeholder="CRED-XXXXXX"
                        required
                    />
                </div>
            </div>

            <div className="form-group">
                <label>Tipo de Defensor *</label>
                <select
                    name="tipo"
                    value={form.tipo}
                    onChange={handleChange}
                    required
                >
                    <option value="Público">Público</option>
                    <option value="Privado">Privado</option>
                </select>
            </div>

            <div className="form-row">
                <div className="form-group">
                    <label>Teléfono</label>
                    <input
                        type="text"
                        name="telefono"
                        value={form.telefono}
                        onChange={handleChange}
                        placeholder="0412-1234567"
                    />
                </div>
                <div className="form-group">
                    <label>Email</label>
                    <input
                        type="email"
                        name="email"
                        value={form.email}
                        onChange={handleChange}
                        placeholder="defensor@mail.com"
                    />
                </div>
            </div>

            <div className="form-group">
                <label>Dirección</label>
                <textarea
                    name="direccion"
                    value={form.direccion}
                    onChange={handleChange}
                    rows="2"
                    placeholder="Dirección de la oficina"
                />
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

export default DefensorForm;
