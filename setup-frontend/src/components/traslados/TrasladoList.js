import React, { useState, useEffect } from 'react';
import { trasladoService } from '../../services/trasladoService';
import { reclusoService } from '../../services/reclusoService';
import { centroPenalService } from '../../services/centroPenalService';
import { celdaService } from '../../services/celdaService';
import Modal from '../common/Modal';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faPlus, faCheck, faTimes, faSync } from '@fortawesome/free-solid-svg-icons';
import './TrasladoList.css';

const TrasladoList = () => {
    const [traslados, setTraslados] = useState([]);
    const [reclusos, setReclusos] = useState([]);
    const [centros, setCentros] = useState([]);
    const [celdas, setCeldas] = useState([]);
    const [loading, setLoading] = useState(true);
    
    // Modales
    const [modalSolicitud, setModalSolicitud] = useState(false);
    const [modalAprobar, setModalAprobar] = useState(false);
    const [trasladoSeleccionado, setTrasladoSeleccionado] = useState(null);

    // Formularios
    const [formSolicitud, setFormSolicitud] = useState({ recluso_id: '', centro_destino_id: '', motivo: '' });
    const [formAprobar, setFormAprobar] = useState({ celda_destino_id: '', juez_autorizante: '' });

    const loadData = async () => {
        try {
            setLoading(true);
            const [t, r, c, cel] = await Promise.all([
                trasladoService.getAll(),
                reclusoService.getAll(),
                centroPenalService.getAll(),
                celdaService.getAll()
            ]);
            setTraslados(t.data || []);
            setReclusos(r.data || []);
            setCentros(c.data || []);
            setCeldas(cel.data || []);
        } catch (err) {
            console.error(err);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => { loadData(); }, []);

    const handleSolicitar = async (e) => {
        e.preventDefault();
        try {
            await trasladoService.create(formSolicitud);
            setModalSolicitud(false);
            setFormSolicitud({ recluso_id: '', centro_destino_id: '', motivo: '' });
            loadData();
        } catch (err) {
            alert(err.response?.data?.error || 'Error al solicitar traslado');
        }
    };

    const handleAprobar = async (e) => {
        e.preventDefault();
        try {
            await trasladoService.aprobar(trasladoSeleccionado.id, formAprobar);
            setModalAprobar(false);
            setFormAprobar({ celda_destino_id: '', juez_autorizante: '' });
            loadData();
        } catch (err) {
            alert(err.response?.data?.error || 'Error al aprobar traslado (Verifique aforo y riesgo)');
        }
    };

    const handleRechazar = async (id) => {
        if (window.confirm('¿Rechazar esta solicitud de traslado?')) {
            await trasladoService.rechazar(id, { juez_autorizante: 'Rechazado por administrador' });
            loadData();
        }
    };

    const getBadge = (estado) => {
        const map = { 'Pendiente': 'badge-warning', 'Completado': 'badge-success', 'Rechazado': 'badge-danger' };
        return `badge ${map[estado]}`;
    };

    if (loading) return <div className="loading">Cargando traslados...</div>;

    return (
        <div className="traslado-container">
            <div className="page-header">
                <h2>Gestión de Traslados</h2>
                <button className="btn btn-primary" onClick={() => setModalSolicitud(true)}>
                    <FontAwesomeIcon icon={faPlus} /> Solicitar Traslado
                </button>
            </div>

            <div className="card">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th><th>Recluso</th><th>Origen</th><th>Destino</th><th>Motivo</th><th>Estado</th><th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {traslados.map(t => (
                            <tr key={t.id}>
                                <td>{t.id}</td>
                                <td>{t.recluso?.nombres} {t.recluso?.apellidos}</td>
                                <td>{t.centro_origen?.nombre || 'N/A'}</td>
                                <td>{t.centro_destino?.nombre}</td>
                                <td>{t.motivo}</td>
                                <td><span className={getBadge(t.estado)}>{t.estado}</span></td>
                                <td>
                                    {t.estado === 'Pendiente' && (
                                        <>
                                            <button className="btn btn-sm btn-success" onClick={() => {
                                                setTrasladoSeleccionado(t);
                                                setModalAprobar(true);
                                            }}><FontAwesomeIcon icon={faCheck} /></button>
                                            <button className="btn btn-sm btn-danger" onClick={() => handleRechazar(t.id)}><FontAwesomeIcon icon={faTimes} /></button>
                                        </>
                                    )}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            {/* Modal Solicitar */}
            <Modal isOpen={modalSolicitud} onClose={() => setModalSolicitud(false)} title="Nueva Solicitud de Traslado">
                <form onSubmit={handleSolicitar}>
                    <div className="form-group">
                        <label>Recluso *</label>
                        <select required value={formSolicitud.recluso_id} onChange={e => setFormSolicitud({...formSolicitud, recluso_id: e.target.value})}>
                            <option value="">Seleccione recluso</option>
                            {reclusos.map(r => <option key={r.id} value={r.id}>{r.nombres} {r.apellidos}</option>)}
                        </select>
                    </div>
                    <div className="form-group">
                        <label>Centro Destino *</label>
                        <select required value={formSolicitud.centro_destino_id} onChange={e => setFormSolicitud({...formSolicitud, centro_destino_id: e.target.value})}>
                            <option value="">Seleccione centro</option>
                            {centros.map(c => <option key={c.id} value={c.id}>{c.nombre}</option>)}
                        </select>
                    </div>
                    <div className="form-group">
                        <label>Motivo *</label>
                        <textarea required value={formSolicitud.motivo} onChange={e => setFormSolicitud({...formSolicitud, motivo: e.target.value})} />
                    </div>
                    <div className="form-actions">
                        <button type="button" className="btn btn-secondary" onClick={() => setModalSolicitud(false)}>Cancelar</button>
                        <button type="submit" className="btn btn-primary">Solicitar</button>
                    </div>
                </form>
            </Modal>

            {/* Modal Aprobar */}
            <Modal isOpen={modalAprobar} onClose={() => setModalAprobar(false)} title="Aprobar y Ejecutar Traslado">
                <form onSubmit={handleAprobar}>
                    <p><strong>Recluso:</strong> {trasladoSeleccionado?.recluso?.nombres} {trasladoSeleccionado?.recluso?.apellidos}</p>
                    <div className="form-group">
                        <label>Celda Destino *</label>
                        <select required value={formAprobar.celda_destino_id} onChange={e => setFormAprobar({...formAprobar, celda_destino_id: e.target.value})}>
                            <option value="">Seleccione celda</option>
                            {celdas.map(c => <option key={c.id} value={c.id}>{c.codigo} (Cap. {c.capacidad_maxima})</option>)}
                        </select>
                    </div>
                    <div className="form-group">
                        <label>Juez Autorizante *</label>
                        <input type="text" required value={formAprobar.juez_autorizante} onChange={e => setFormAprobar({...formAprobar, juez_autorizante: e.target.value})} />
                    </div>
                    <div className="form-actions">
                        <button type="button" className="btn btn-secondary" onClick={() => setModalAprobar(false)}>Cancelar</button>
                        <button type="submit" className="btn btn-success">Aprobar y Mover</button>
                    </div>
                </form>
            </Modal>
        </div>
    );
};

export default TrasladoList;
