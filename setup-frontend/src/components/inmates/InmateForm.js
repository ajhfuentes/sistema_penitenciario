// src/components/inmates/InmateForm.js
import React, { useState, useEffect } from 'react';
import { reclusoService } from '../../services/reclusoService';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSave, faTimes } from '@fortawesome/free-solid-svg-icons';

const InmateForm = ({ initialData, centros, pabellones, celdas, onSave, onCancel, isEdit }) => {
    const [form, setForm] = useState({
        celda_id: initialData?.celda_id || '',
        nombres: initialData?.nombres || '',
        apellidos: initialData?.apellidos || '',
        cedula_identidad: initialData?.cedula_identidad || '',
        nivel_riesgo: initialData?.nivel_riesgo || 'Bajo',
        estado_operativo: initialData?.estado_operativo || 'En Ingreso',
        fecha_nacimiento: initialData?.fecha_nacimiento || '',
        sexo: initialData?.sexo || 'M',
        huella_dactilar: initialData?.huella_dactilar || '',
        foto_perfil: initialData?.foto_perfil || '',
    });
    const [submitting, setSubmitting] = useState(false);
    const [error, setError] = useState(null);
    const [pabellonesFiltrados, setPabellonesFiltrados] = useState([]);
    const [celdasFiltradas, setCeldasFiltradas] = useState([]);

    // Filtrar pabellones y celdas según el centro seleccionado (si se selecciona)
    useEffect(() => {
        // Si hay pabellones, mostrar todos por defecto
        setPabellonesFiltrados(pabellones);
    }, [pabellones]);

    // Filtrar celdas según pabellón seleccionado
    useEffect(() => {
        if (form.celda_id) {
            const celda = celdas.find(c => c.id === parseInt(form.celda_id));
            if (celda) {
                const celdasPabellon = celdas.filter(c => c.pabellon_id === celda.pabellon_id);
                setCeldasFiltradas(celdasPabellon);
            }
        } else {
            setCeldasFiltradas(celdas);
        }
    }, [form.celda_id, celdas]);

    const handleChange = (e) => {
        const { name, value, type, checked } = e.target;
        setForm(prev => ({
            ...prev,
            [name]: type === 'checkbox' ? checked : value
        }));
        // Limpiar celda si cambia algo que afecte la disponibilidad
        if (name === 'celda_id') {
            // No limpiar, solo actualizar
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError(null);
        setSubmitting(true);

        try {
            const data = {
                ...form,
                celda_id: form.celda_id ? parseInt(form.celda_id) : null,
                fecha_nacimiento: form.fecha_nacimiento || null,
            };
            
            if (isEdit) {
                await reclusoService.update(initialData.id, data);
            } else {
                await reclusoService.create(data);
            }
            onSave();
        } catch (err) {
            setError(err.response?.data?.message || 'Error al guardar el recluso');
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
                    <label>Fecha de Nacimiento</label>
                    <input
                        type="date"
                        name="fecha_nacimiento"
                        value={form.fecha_nacimiento}
                        onChange={handleChange}
                    />
                </div>
            </div>

            <div className="form-row">
                <div className="form-group">
                    <label>Nivel de Riesgo *</label>
                    <select
                        name="nivel_riesgo"
                        value={form.nivel_riesgo}
                        onChange={handleChange}
                        required
                    >
                        <option value="Bajo">Bajo</option>
                        <option value="Medio">Medio</option>
                        <option value="Alto">Alto</option>
                    </select>
                </div>
                <div className="form-group">
                    <label>Estado Operativo *</label>
                    <select
                        name="estado_operativo"
                        value={form.estado_operativo}
                        onChange={handleChange}
                        required
                    >
                        <option value="En Ingreso">En Ingreso</option>
                        <option value="Activo">Activo</option>
                        <option value="Traslado">Traslado</option>
                        <option value="Libertad">Libertad</option>
                    </select>
                </div>
            </div>

            <div className="form-row">
                <div className="form-group">
                    <label>Sexo</label>
                    <select
                        name="sexo"
                        value={form.sexo}
                        onChange={handleChange}
                    >
                        <option value="M">Masculino</option>
                        <option value="F">Femenino</option>
                    </select>
                </div>
                <div className="form-group">
                    <label>Celda</label>
                    <select
                        name="celda_id"
                        value={form.celda_id}
                        onChange={handleChange}
                    >
                        <option value="">Sin asignar</option>
                        {celdasFiltradas.map(c => {
                            const pabellon = pabellones.find(p => p.id === c.pabellon_id);
                            return (
                                <option key={c.id} value={c.id}>
                                    {c.codigo} - {pabellon?.nombre || 'Sin pabellón'}
                                </option>
                            );
                        })}
                    </select>
                </div>
            </div>

            <div className="form-group">
                <label>Huella Dactilar (opcional)</label>
                <textarea
                    name="huella_dactilar"
                    value={form.huella_dactilar}
                    onChange={handleChange}
                    rows="2"
                    placeholder="Datos biométricos de la huella"
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

export default InmateForm;
