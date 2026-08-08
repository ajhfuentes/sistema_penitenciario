// src/components/defensores/DefensorList.js
import React, { useState, useEffect } from 'react';
import { defensorService } from '../../services/defensorService';
import Modal from '../common/Modal';
import DefensorForm from './DefensorForm';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEdit, faTrash, faPlus, faSearch, faSync, faUserShield } from '@fortawesome/free-solid-svg-icons';
import './DefensorList.css';

const DefensorList = () => {
    const [defensores, setDefensores] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [selected, setSelected] = useState(null);
    const [modalOpen, setModalOpen] = useState(false);
    const [modalMode, setModalMode] = useState('create');
    const [searchTerm, setSearchTerm] = useState('');

    const loadData = async () => {
        try {
            setLoading(true);
            const data = await defensorService.getAll();
            setDefensores(data.data || []);
        } catch (err) {
            setError('Error al cargar defensores: ' + err.message);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadData();
    }, []);

    const handleDelete = async (id) => {
        if (window.confirm('¿Eliminar este defensor? Se eliminará también su relación con reclusos.')) {
            try {
                await defensorService.delete(id);
                loadData();
            } catch (err) {
                alert('Error al eliminar: ' + err.message);
            }
        }
    };

    const handleEdit = (defensor) => {
        setSelected(defensor);
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

    const filtered = defensores.filter(d => {
        const search = searchTerm.toLowerCase();
        return d.nombres.toLowerCase().includes(search) ||
               d.apellidos.toLowerCase().includes(search) ||
               d.cedula_identidad.includes(search) ||
               d.tipo.toLowerCase().includes(search);
    });

    if (loading) return <div className="loading">Cargando defensores...</div>;

    return (
        <div className="defensor-list-container">
            <div className="page-header">
                <h2>Gestión de Defensores</h2>
                <button className="btn btn-primary" onClick={handleCreate}>
                    <FontAwesomeIcon icon={faPlus} /> Nuevo Defensor
                </button>
            </div>

            {error && <div className="error-message">{error}</div>}

            <div className="card">
                <div className="card-title">Filtros y Búsqueda</div>
                <div className="filters-row">
                    <div className="filter-group">
                        <label>Buscar:</label>
                        <input
                            type="text"
                            placeholder="Nombre, apellido, cédula o tipo..."
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
                    Lista de Defensores ({filtered.length})
                    <span className="subtitle">Públicos y Privados</span>
                </div>
                {filtered.length === 0 ? (
                    <div className="empty-state">No hay defensores registrados</div>
                ) : (
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre Completo</th>
                                <th>Cédula</th>
                                <th>Credencial</th>
                                <th>Tipo</th>
                                <th>Contacto</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filtered.map(d => (
                                <tr key={d.id}>
                                    <td>{d.id}</td>
                                    <td>
                                        <strong>{d.nombres} {d.apellidos}</strong>
                                    </td>
                                    <td>{d.cedula_identidad}</td>
                                    <td><code>{d.credencial_colegio}</code></td>
                                    <td>
                                        <span className={`badge ${d.tipo === 'Público' ? 'badge-info' : 'badge-warning'}`}>
                                            <FontAwesomeIcon icon={faUserShield} /> {d.tipo}
                                        </span>
                                    </td>
                                    <td>
                                        <div className="contact-info">
                                            {d.telefono && <div>📞 {d.telefono}</div>}
                                            {d.email && <div>✉️ {d.email}</div>}
                                        </div>
                                    </td>
                                    <td>
                                        <button className="btn btn-sm btn-primary" onClick={() => handleEdit(d)}>
                                            <FontAwesomeIcon icon={faEdit} />
                                        </button>
                                        <button className="btn btn-sm btn-danger" onClick={() => handleDelete(d.id)}>
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
                title={modalMode === 'create' ? 'Nuevo Defensor' : 'Editar Defensor'}
                size="md"
            >
                <DefensorForm
                    initialData={selected}
                    onSave={handleSave}
                    onCancel={() => setModalOpen(false)}
                    isEdit={modalMode === 'edit'}
                />
            </Modal>
        </div>
    );
};

export default DefensorList;
