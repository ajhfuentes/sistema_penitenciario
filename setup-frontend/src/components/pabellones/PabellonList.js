// src/components/pabellones/PabellonList.js
import React, { useState, useEffect } from 'react';
import { pabellonService } from '../../services/pabellonService';
import { centroPenalService } from '../../services/centroPenalService';
import Modal from '../common/Modal';
import PabellonForm from './PabellonForm';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEdit, faTrash, faPlus, faSearch, faSync } from '@fortawesome/free-solid-svg-icons';
import './PabellonList.css';

const PabellonList = () => {
    const [pabellones, setPabellones] = useState([]);
    const [centros, setCentros] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [selected, setSelected] = useState(null);
    const [modalOpen, setModalOpen] = useState(false);
    const [modalMode, setModalMode] = useState('create');
    const [filterCentro, setFilterCentro] = useState('');
    const [searchTerm, setSearchTerm] = useState('');

    const loadData = async () => {
        try {
            setLoading(true);
            const [pabellonesData, centrosData] = await Promise.all([
                pabellonService.getAll(),
                centroPenalService.getAll()
            ]);
            setPabellones(pabellonesData.data || []);
            setCentros(centrosData.data || []);
        } catch (err) {
            setError('Error al cargar datos: ' + err.message);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadData();
    }, []);

    const handleDelete = async (id) => {
        if (window.confirm('¿Eliminar este pabellón? Se eliminarán también sus celdas asociadas.')) {
            try {
                await pabellonService.delete(id);
                loadData();
            } catch (err) {
                alert('Error al eliminar: ' + err.message);
            }
        }
    };

    const handleEdit = (pabellon) => {
        setSelected(pabellon);
        setModalMode('edit');
        setModalOpen(true);
    };

    const handleCreate = () => {
        setSelected(null);
        setModalMode('create');
        setModalOpen(true);
    };

    const handleSave = () => {
        setModalOpen(false);
        loadData();
    };

    // Filtros
    const filtered = pabellones.filter(p => {
        const matchCentro = filterCentro ? p.centro_penal_id === parseInt(filterCentro) : true;
        const matchSearch = searchTerm ? 
            p.nombre.toLowerCase().includes(searchTerm.toLowerCase()) ||
            p.riesgo_permitido.toLowerCase().includes(searchTerm.toLowerCase()) : true;
        return matchCentro && matchSearch;
    });

    const getCentroNombre = (centroId) => {
        const centro = centros.find(c => c.id === centroId);
        return centro ? centro.nombre : 'N/A';
    };

    const getRiesgoBadge = (riesgo) => {
        const clases = {
            'Bajo': 'badge-success',
            'Medio': 'badge-warning',
            'Alto': 'badge-danger'
        };
        return `badge ${clases[riesgo] || 'badge-secondary'}`;
    };

    if (loading) return <div className="loading">Cargando pabellones...</div>;

    return (
        <div className="pabellon-list-container">
            <div className="page-header">
                <h2>Gestión de Pabellones</h2>
                <button className="btn btn-primary" onClick={handleCreate}>
                    <FontAwesomeIcon icon={faPlus} /> Nuevo Pabellón
                </button>
            </div>

            {error && <div className="error-message">{error}</div>}

            <div className="card">
                <div className="card-title">Filtros y Búsqueda</div>
                <div className="filters-row">
                    <div className="filter-group">
                        <label>Centro Penal:</label>
                        <select value={filterCentro} onChange={(e) => setFilterCentro(e.target.value)}>
                            <option value="">Todos</option>
                            {centros.map(c => (
                                <option key={c.id} value={c.id}>{c.nombre}</option>
                            ))}
                        </select>
                    </div>
                    <div className="filter-group">
                        <label>Buscar:</label>
                        <input
                            type="text"
                            placeholder="Nombre o riesgo..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    </div>
                    <button className="btn btn-secondary" onClick={loadData}>
                        <FontAwesomeIcon icon={faSync} /> Actualizar
                    </button>
                </div>
            </div>

            <div className="card">
                <div className="card-title">
                    Lista de Pabellones ({filtered.length})
                </div>
                {filtered.length === 0 ? (
                    <div className="empty-state">No hay pabellones registrados</div>
                ) : (
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Centro Penal</th>
                                <th>Riesgo Permitido</th>
                                <th>Capacidad Máxima</th>
                                <th>Ocupación</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filtered.map(p => (
                                <tr key={p.id}>
                                    <td>{p.id}</td>
                                    <td><strong>{p.nombre}</strong></td>
                                    <td>{getCentroNombre(p.centro_penal_id)}</td>
                                    <td><span className={getRiesgoBadge(p.riesgo_permitido)}>{p.riesgo_permitido}</span></td>
                                    <td>{p.capacidad_maxima}</td>
                                    <td>{p.porcentaje_ocupacion || 0}%</td>
                                    <td>
                                        <button className="btn btn-sm btn-primary" onClick={() => handleEdit(p)}>
                                            <FontAwesomeIcon icon={faEdit} />
                                        </button>
                                        <button className="btn btn-sm btn-danger" onClick={() => handleDelete(p.id)}>
                                            <FontAwesomeIcon icon={faTrash} />
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
            </div>

            <Modal
                isOpen={modalOpen}
                onClose={() => setModalOpen(false)}
                title={modalMode === 'create' ? 'Nuevo Pabellón' : 'Editar Pabellón'}
                size="md"
            >
                <PabellonForm
                    initialData={selected}
                    centros={centros}
                    onSave={handleSave}
                    onCancel={() => setModalOpen(false)}
                    isEdit={modalMode === 'edit'}
                />
            </Modal>
        </div>
    );
};

export default PabellonList;
