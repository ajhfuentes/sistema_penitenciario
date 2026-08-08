// src/components/centros/CentroPenalList.js
import React, { useState, useEffect } from 'react';
import { centroPenalService } from '../../services/centroPenalService';
import Modal from '../common/Modal';
import CentroPenalForm from './CentroPenalForm';

const CentroPenalList = () => {
    const [centros, setCentros] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [selected, setSelected] = useState(null);
    const [modalOpen, setModalOpen] = useState(false);
    const [modalMode, setModalMode] = useState('create');

    const loadData = async () => {
        try {
            setLoading(true);
            const data = await centroPenalService.getAll();
            setCentros(data.data || []);
        } catch (err) {
            setError(err.message);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadData();
    }, []);

    const handleDelete = async (id) => {
        if (window.confirm('¿Eliminar este centro penal?')) {
            await centroPenalService.delete(id);
            loadData();
        }
    };

    const handleEdit = (centro) => {
        setSelected(centro);
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

    if (loading) return <div>Cargando centros penales...</div>;
    if (error) return <div>Error: {error}</div>;

    return (
        <div className="card">
            <div className="card-title">
                Centros Penales
                <button className="btn btn-primary" onClick={handleCreate}>Nuevo</button>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Ubicación</th>
                        <th>Capacidad</th>
                        <th>Seguridad</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    {centros.map(c => (
                        <tr key={c.id}>
                            <td>{c.id}</td>
                            <td>{c.nombre}</td>
                            <td>{c.ubicacion}</td>
                            <td>{c.capacidad_aforo}</td>
                            <td>{c.nivel_seguridad}</td>
                            <td>
                                <button className="btn btn-sm btn-secondary" onClick={() => handleEdit(c)}>Editar</button>
                                <button className="btn btn-sm btn-danger" onClick={() => handleDelete(c.id)}>Eliminar</button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <Modal isOpen={modalOpen} onClose={() => setModalOpen(false)} title={modalMode === 'create' ? 'Nuevo Centro Penal' : 'Editar Centro Penal'}>
                <CentroPenalForm 
                    initialData={selected} 
                    onSave={handleSave} 
                    onCancel={() => setModalOpen(false)} 
                    isEdit={modalMode === 'edit'} 
                />
            </Modal>
        </div>
    );
};

export default CentroPenalList;
