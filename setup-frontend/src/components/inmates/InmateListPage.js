// src/components/inmates/InmateListPage.js
import React, { useState, useEffect } from 'react';
import { reclusoService } from '../../services/reclusoService';
import { centroPenalService } from '../../services/centroPenalService';
import { pabellonService } from '../../services/pabellonService';
import { celdaService } from '../../services/celdaService';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { 
    faSearch, faEye, faEdit, faTrash, faSync, 
    faUserPlus, faFilter, faFilePdf, faChartBar 
} from '@fortawesome/free-solid-svg-icons';
import Modal from '../common/Modal';
import InmateForm from './InmateForm';
import './InmateListPage.css';

const InmateListPage = () => {
    // Estados principales
    const [inmates, setInmates] = useState([]);
    const [estadisticas, setEstadisticas] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [filterEstado, setFilterEstado] = useState('');
    const [filterRiesgo, setFilterRiesgo] = useState('');
    
    // Modal
    const [modalOpen, setModalOpen] = useState(false);
    const [modalMode, setModalMode] = useState('create');
    const [selectedInmate, setSelectedInmate] = useState(null);
    
    // Datos para selects
    const [centros, setCentros] = useState([]);
    const [pabellones, setPabellones] = useState([]);
    const [celdas, setCeldas] = useState([]);

    const loadData = async () => {
        try {
            setLoading(true);
            setError(null);
            
            const [lista, stats, centrosData, pabellonesData, celdasData] = await Promise.all([
                reclusoService.getAll(),
                reclusoService.getEstadisticas(),
                centroPenalService.getAll(),
                pabellonService.getAll(),
                celdaService.getAll()
            ]);
            
            setInmates(lista.data || []);
            setEstadisticas(stats);
            setCentros(centrosData.data || []);
            setPabellones(pabellonesData.data || []);
            setCeldas(celdasData.data || []);
            
        } catch (err) {
            console.error('Error cargando datos:', err);
            setError('Error al cargar los datos: ' + (err.response?.data?.message || err.message));
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadData();
    }, []);

    // Filtrar reclusos
    const filteredInmates = inmates.filter(inmate => {
        const matchSearch = searchTerm === '' || 
            inmate.nombres?.toLowerCase().includes(searchTerm.toLowerCase()) ||
            inmate.apellidos?.toLowerCase().includes(searchTerm.toLowerCase()) ||
            inmate.cedula_identidad?.includes(searchTerm) ||
            inmate.id?.toString().includes(searchTerm);
        
        const matchEstado = filterEstado === '' || inmate.estado_operativo === filterEstado;
        const matchRiesgo = filterRiesgo === '' || inmate.nivel_riesgo === filterRiesgo;
        
        return matchSearch && matchEstado && matchRiesgo;
    });

    // Obtener nombre de celda
    const getCeldaInfo = (celdaId) => {
        const celda = celdas.find(c => c.id === celdaId);
        if (!celda) return { codigo: 'N/A', pabellon: 'N/A' };
        const pabellon = pabellones.find(p => p.id === celda.pabellon_id);
        return {
            codigo: celda.codigo,
            pabellon: pabellon?.nombre || 'N/A'
        };
    };

    // Obtener badge de riesgo
    const getRiesgoBadge = (riesgo) => {
        const clases = {
            'Alto': 'badge-danger',
            'Medio': 'badge-warning',
            'Bajo': 'badge-success'
        };
        return `badge ${clases[riesgo] || 'badge-secondary'}`;
    };

    // Obtener badge de estado
    const getEstadoBadge = (estado) => {
        const clases = {
            'Activo': 'badge-success',
            'En Ingreso': 'badge-info',
            'Traslado': 'badge-warning',
            'Libertad': 'badge-primary'
        };
        return `badge ${clases[estado] || 'badge-secondary'}`;
    };

    // Handlers CRUD
    const handleCreate = () => {
        setSelectedInmate(null);
        setModalMode('create');
        setModalOpen(true);
    };

    const handleEdit = (inmate) => {
        setSelectedInmate(inmate);
        setModalMode('edit');
        setModalOpen(true);
    };

    const handleDelete = async (id) => {
        if (window.confirm('¿Está seguro de eliminar este recluso? Esta acción no se puede deshacer.')) {
            try {
                await reclusoService.delete(id);
                loadData();
            } catch (err) {
                alert('Error al eliminar: ' + (err.response?.data?.message || err.message));
            }
        }
    };

    const handleSave = () => {
        setModalOpen(false);
        loadData();
    };

    // Ver detalles
    const handleView = (inmate) => {
        // Podrías abrir un modal de detalles o navegar a una página de detalle
        alert(`Recluso: ${inmate.nombres} ${inmate.apellidos}\nCédula: ${inmate.cedula_identidad}\nRiesgo: ${inmate.nivel_riesgo}\nEstado: ${inmate.estado_operativo}`);
    };

    if (loading) {
        return (
            <div className="inmate-list-container">
                <div className="loading-spinner">
                    <div className="spinner"></div>
                    <p>Cargando datos del sistema...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="inmate-list-container">
            {/* Header */}
            <div className="page-header">
                <div>
                    <h2>📋 Registro de Reclusos</h2>
                    <p className="subtitle">Gestión completa de la población penitenciaria</p>
                </div>
                <div className="header-actions">
                    <button className="btn btn-secondary" onClick={loadData}>
                        <FontAwesomeIcon icon={faSync} /> Actualizar
                    </button>
                    <button className="btn btn-primary" onClick={handleCreate}>
                        <FontAwesomeIcon icon={faUserPlus} /> Nuevo Recluso
                    </button>
                </div>
            </div>

            {/* Stats Cards */}
            {estadisticas && (
                <div className="stats-grid">
                    <div className="stat-card">
                        <div className="stat-icon">👥</div>
                        <div className="stat-content">
                            <div className="stat-number">{estadisticas.total}</div>
                            <div className="stat-label">Total Reclusos</div>
                        </div>
                    </div>
                    <div className="stat-card">
                        <div className="stat-icon">🟢</div>
                        <div className="stat-content">
                            <div className="stat-number">{estadisticas.activos}</div>
                            <div className="stat-label">Activos</div>
                        </div>
                    </div>
                    <div className="stat-card">
                        <div className="stat-icon">🔵</div>
                        <div className="stat-content">
                            <div className="stat-number">{estadisticas.en_ingreso}</div>
                            <div className="stat-label">En Ingreso</div>
                        </div>
                    </div>
                    <div className="stat-card">
                        <div className="stat-icon">🟡</div>
                        <div className="stat-content">
                            <div className="stat-number">{estadisticas.traslado}</div>
                            <div className="stat-label">Traslado</div>
                        </div>
                    </div>
                    <div className="stat-card">
                        <div className="stat-icon">🟣</div>
                        <div className="stat-content">
                            <div className="stat-number">{estadisticas.libertad}</div>
                            <div className="stat-label">Libertad</div>
                        </div>
                    </div>
                </div>
            )}

            {/* Distribución de Riesgo */}
            {estadisticas?.riesgo && (
                <div className="card risk-distribution">
                    <div className="card-title">Distribución por Nivel de Riesgo</div>
                    <div className="risk-bars">
                        <div className="risk-item">
                            <span>Alto {estadisticas.porcentaje_riesgo?.Alto || 0}%</span>
                            <div className="bar">
                                <div className="fill-danger" style={{ width: `${estadisticas.porcentaje_riesgo?.Alto || 0}%` }}></div>
                            </div>
                            <span className="count">{estadisticas.riesgo.Alto}</span>
                        </div>
                        <div className="risk-item">
                            <span>Medio {estadisticas.porcentaje_riesgo?.Medio || 0}%</span>
                            <div className="bar">
                                <div className="fill-warning" style={{ width: `${estadisticas.porcentaje_riesgo?.Medio || 0}%` }}></div>
                            </div>
                            <span className="count">{estadisticas.riesgo.Medio}</span>
                        </div>
                        <div className="risk-item">
                            <span>Bajo {estadisticas.porcentaje_riesgo?.Bajo || 0}%</span>
                            <div className="bar">
                                <div className="fill-success" style={{ width: `${estadisticas.porcentaje_riesgo?.Bajo || 0}%` }}></div>
                            </div>
                            <span className="count">{estadisticas.riesgo.Bajo}</span>
                        </div>
                    </div>
                </div>
            )}

            {/* Filtros y Búsqueda */}
            <div className="card filters-card">
                <div className="card-title">
                    <FontAwesomeIcon icon={faFilter} /> Filtros y Búsqueda
                </div>
                <div className="filters-row">
                    <div className="filter-group">
                        <label>🔍 Buscar</label>
                        <input
                            type="text"
                            placeholder="Nombre, cédula o ID..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    </div>
                    <div className="filter-group">
                        <label>📊 Estado</label>
                        <select value={filterEstado} onChange={(e) => setFilterEstado(e.target.value)}>
                            <option value="">Todos</option>
                            <option value="Activo">Activo</option>
                            <option value="En Ingreso">En Ingreso</option>
                            <option value="Traslado">Traslado</option>
                            <option value="Libertad">Libertad</option>
                        </select>
                    </div>
                    <div className="filter-group">
                        <label>⚠️ Riesgo</label>
                        <select value={filterRiesgo} onChange={(e) => setFilterRiesgo(e.target.value)}>
                            <option value="">Todos</option>
                            <option value="Alto">Alto</option>
                            <option value="Medio">Medio</option>
                            <option value="Bajo">Bajo</option>
                        </select>
                    </div>
                    <button className="btn btn-secondary" onClick={() => {
                        setSearchTerm('');
                        setFilterEstado('');
                        setFilterRiesgo('');
                    }}>
                        Limpiar Filtros
                    </button>
                </div>
            </div>

            {/* Tabla de Reclusos */}
            <div className="card table-card">
                <div className="card-title">
                    <span>📋 Lista de Reclusos ({filteredInmates.length})</span>
                    <span className="subtitle">Mostrando {filteredInmates.length} de {inmates.length} registros</span>
                </div>
                
                {error && <div className="error-message">{error}</div>}

                {filteredInmates.length === 0 ? (
                    <div className="empty-state">
                        <p>No se encontraron reclusos</p>
                        <button className="btn btn-primary" onClick={handleCreate}>
                            <FontAwesomeIcon icon={faUserPlus} /> Registrar Primer Recluso
                        </button>
                    </div>
                ) : (
                    <div className="table-responsive">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre Completo</th>
                                    <th>Cédula</th>
                                    <th>Riesgo</th>
                                    <th>Estado</th>
                                    <th>Ubicación</th>
                                    <th>Ingreso</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                {filteredInmates.map(inmate => {
                                    const celdaInfo = getCeldaInfo(inmate.celda_id);
                                    return (
                                        <tr key={inmate.id}>
                                            <td><strong>#{inmate.id}</strong></td>
                                            <td>
                                                <div className="inmate-name">
                                                    <strong>{inmate.nombres} {inmate.apellidos}</strong>
                                                    <small>{inmate.sexo === 'M' ? '♂' : '♀'}</small>
                                                </div>
                                            </td>
                                            <td>{inmate.cedula_identidad}</td>
                                            <td>
                                                <span className={getRiesgoBadge(inmate.nivel_riesgo)}>
                                                    {inmate.nivel_riesgo}
                                                </span>
                                            </td>
                                            <td>
                                                <span className={getEstadoBadge(inmate.estado_operativo)}>
                                                    {inmate.estado_operativo}
                                                </span>
                                            </td>
                                            <td>
                                                <div className="location-info">
                                                    <div className="celda">{celdaInfo.codigo}</div>
                                                    <div className="pabellon">{celdaInfo.pabellon}</div>
                                                </div>
                                            </td>
                                            <td>
                                                {inmate.fecha_ingreso ? 
                                                    new Date(inmate.fecha_ingreso).toLocaleDateString() : 
                                                    'N/A'
                                                }
                                            </td>
                                            <td>
                                                <div className="action-buttons">
                                                    <button 
                                                        className="btn btn-sm btn-info" 
                                                        onClick={() => handleView(inmate)}
                                                        title="Ver detalles"
                                                    >
                                                        <FontAwesomeIcon icon={faEye} />
                                                    </button>
                                                    <button 
                                                        className="btn btn-sm btn-primary" 
                                                        onClick={() => handleEdit(inmate)}
                                                        title="Editar"
                                                    >
                                                        <FontAwesomeIcon icon={faEdit} />
                                                    </button>
                                                    <button 
                                                        className="btn btn-sm btn-danger" 
                                                        onClick={() => handleDelete(inmate.id)}
                                                        title="Eliminar"
                                                    >
                                                        <FontAwesomeIcon icon={faTrash} />
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    </div>
                )}
            </div>

            {/* Modal para Crear/Editar */}
            <Modal
                isOpen={modalOpen}
                onClose={() => setModalOpen(false)}
                title={modalMode === 'create' ? 'Nuevo Recluso' : 'Editar Recluso'}
                size="lg"
            >
                <InmateForm
                    initialData={selectedInmate}
                    centros={centros}
                    pabellones={pabellones}
                    celdas={celdas}
                    onSave={handleSave}
                    onCancel={() => setModalOpen(false)}
                    isEdit={modalMode === 'edit'}
                />
            </Modal>
        </div>
    );
};

export default InmateListPage;
