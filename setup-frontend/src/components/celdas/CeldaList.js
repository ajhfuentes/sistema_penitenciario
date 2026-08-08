// src/components/celdas/CeldaList.js
import React, { useState, useEffect } from 'react';
import { celdaService } from '../../services/celdaService';
import { pabellonService } from '../../services/pabellonService';
import Modal from '../common/Modal';
import CeldaForm from './CeldaForm';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEdit, faTrash, faPlus, faSearch, faSync, faUsers } from '@fortawesome/free-solid-svg-icons';
import './CeldaList.css';

const CeldaList = () => {
    const [celdas, setCeldas] = useState([]);
    const [pabellones, setPabellones] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [selected, setSelected] = useState(null);
    const [modalOpen, setModalOpen] = useState(false);
    const [modalMode, setModalMode] = useState('create');
    const [filterPabellon, setFilterPabellon] = useState('');
    const [searchTerm, setSearchTerm] = useState('');

    const loadData = async () => {
        try {
            setLoading(true);
            const [celdasData, pabellonesData] = await Promise.all([
                celdaService.getAll(),
                pabellonService.getAll()
            ]);
            setCeldas(celdasData.data || []);
            setPabellones(pabellonesData.data || []);
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
        if (window.confirm('¿Eliminar esta celda? Los reclusos asociados quedarán sin celda.')) {
            try {
                await celdaService.delete(id);
                loadData();
            } catch (err) {
                alert('Error al eliminar: ' + err.message);
            }
        }
    };

    const handleEdit = (celda) => {
        setSelected(celda);
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

    const getPabellonNombre = (pabellonId) => {
        const pabellon = pabellones.find(p => p.id === pabellonId);
        return pabellon ? pabellon.nombre : 'N/A';
    };

    const getOcupacionBadge = (celda) => {
        const ocupacion = celda.ocupacion || 0;
        const capacidad = celda.capacidad_maxima || 1;
        const porcentaje = (ocupacion / capacidad) * 100;
        if (porcentaje >= 90) return 'badge-danger';
        if (porcentaje >= 70) return 'badge-warning';
        return 'badge-success';
    };

    const filtered = celdas.filter(c => {
        const matchPabellon = filterPabellon ? c.pabellon_id === parseInt(filterPabellon) : true;
        const matchSearch = searchTerm ? 
            c.codigo.toLowerCase().includes(searchTerm.toLowerCase()) ||
            getPabellonNombre(c.pabellon_id).toLowerCase().includes(searchTerm.toLowerCase()) : true;
        return matchPabellon && matchSearch;
    });

    if (loading) return <div className="loading">Cargando celdas...</div>;

    return (
        <div className="celda-list-container">
            <div className="page-header">
                <h2>Gestión de Celdas</h2>
                <button className="btn btn-primary" onClick={handleCreate}>
                    <FontAwesomeIcon icon={faPlus} /> Nueva Celda
                </button>
            </div>

            {error && <div className="error-message">{error}</div>}

            <div className="card">
                <div className="card-title">Filtros y Búsqueda</div>
                <div className="filters-row">
                    <div className="filter-group">
                        <label>Pabellón:</label>
                        <select value={filterPabellon} onChange={(e) => setFilterPabellon(e.target.value)}>
                            <option value="">Todos</option>
                            {pabellones.map(p => (
                                <option key={p.id} value={p.id}>{p.nombre}</option>
                            ))}
                        </select>
                    </div>
                    <div className="filter-group">
                        <label>Buscar:</label>
                        <input
                            type="text"
                            placeholder="Código o pabellón..."
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
                    Lista de Celdas ({filtered.length})
                </div>
                {filtered.length === 0 ? (
                    <div className="empty-state">No hay celdas registradas</div>
                ) : (
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Código</th>
                                <th>Pabellón</th>
                                <th>Capacidad</th>
                                <th>Ocupación</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filtered.map(c => {
                                const ocupacion = c.ocupacion || 0;
                                const capacidad = c.capacidad_maxima || 1;
                                const estaLlena = ocupacion >= capacidad;
                                return (
                                    <tr key={c.id}>
                                        <td>{c.id}</td>
                                        <td><strong>{c.codigo}</strong></td>
                                        <td>{getPabellonNombre(c.pabellon_id)}</td>
                                        <td>{capacidad}</td>
                                        <td>
                                            <span className={getOcupacionBadge(c)}>
                                                {ocupacion} / {capacidad}
                                            </span>
                                        </td>
                                        <td>
                                            {estaLlena ? (
                                                <span className="badge badge-danger">Llena</span>
                                            ) : (
                                                <span className="badge badge-success">Disponible</span>
                                            )}
                                        </td>
                                        <td>
                                            <button className="btn btn-sm btn-primary" onClick={() => handleEdit(c)}>
                                                <FontAwesomeIcon icon={faEdit} />
                                            </button>
                                            <button className="btn btn-sm btn-danger" onClick={() => handleDelete(c.id)}>
                                                <FontAwesomeIcon icon={faTrash} />
                                            </button>
                                        </td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                )}
            </div>

            <Modal
                isOpen={modalOpen}
                onClose={() => setModalOpen(false)}
                title={modalMode === 'create' ? 'Nueva Celda' : 'Editar Celda'}
                size="md"
            >
                <CeldaForm
                    initialData={selected}
                    pabellones={pabellones}
                    onSave={handleSave}
                    onCancel={() => setModalOpen(false)}
                    isEdit={modalMode === 'edit'}
                />
            </Modal>
        </div>
    );
};

export default CeldaList;
