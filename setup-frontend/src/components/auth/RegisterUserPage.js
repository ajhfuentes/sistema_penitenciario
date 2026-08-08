// src/components/auth/RegisterUserPage.js
import React, { useState, useEffect } from 'react';
import { userService } from '../../services/userService';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSearch, faEdit, faTrash, faUserPlus, faSave } from '@fortawesome/free-solid-svg-icons';
import './RegisterUserPage.css';

const RegisterUserPage = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [editingId, setEditingId] = useState(null);

    // Formulario de nuevo usuario / edición
    const [form, setForm] = useState({
        solicitanteNombre: '',
        cargo: '',
        unidad: '',
        email: '',
        firma: '',
        usuarioId: '',
        usuarioNombre: '',
        tipoIdentificacion: 'DNI',
        numeroDocumento: '',
        password: '',
        rol: 'Custodio', // Administrador, Custodio, Médico
        permisos: {
            'Módulo de Criminales': { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
            Historiales: { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
            Reportes: { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
        }
    });

    // Cargar usuarios al montar
    useEffect(() => {
        loadUsers();
    }, []);

    const loadUsers = async () => {
        try {
            setLoading(true);
            const data = await userService.getAll();
            setUsers(data.data || data || []);
        } catch (err) {
            setError('Error al cargar usuarios: ' + err.message);
        } finally {
            setLoading(false);
        }
    };

    const handleChange = (e) => {
        const { name, value, type, checked } = e.target;
        if (type === 'checkbox') {
            setForm(prev => ({ ...prev, [name]: checked }));
        } else {
            setForm(prev => ({ ...prev, [name]: value }));
        }
    };

    const handleRoleChange = (role) => {
        setForm(prev => ({ ...prev, rol: role }));
    };

    const handlePermissionChange = (module, action) => {
        setForm(prev => ({
            ...prev,
            permisos: {
                ...prev.permisos,
                [module]: {
                    ...prev.permisos[module],
                    [action]: !prev.permisos[module][action]
                }
            }
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError(null);
        try {
            const userData = {
                name: form.usuarioNombre,
                email: form.email || `${form.usuarioId}@sgp.com`,
                password: form.password || 'password123',
                rol: form.rol,
            };
            if (editingId) {
                await userService.update(editingId, userData);
            } else {
                await userService.create(userData);
            }
            // Limpiar formulario
            setForm({
                solicitanteNombre: '',
                cargo: '',
                unidad: '',
                email: '',
                firma: '',
                usuarioId: '',
                usuarioNombre: '',
                tipoIdentificacion: 'DNI',
                numeroDocumento: '',
                password: '',
                rol: 'Custodio',
                permisos: {
                    'Módulo de Criminales': { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
                    Historiales: { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
                    Reportes: { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
                }
            });
            setEditingId(null);
            loadUsers(); // Recargar lista
            alert(editingId ? 'Usuario actualizado' : 'Usuario registrado exitosamente');
        } catch (err) {
            setError('Error al guardar: ' + err.message);
        }
    };

    const handleEdit = (user) => {
        setEditingId(user.id);
        setForm({
            ...form,
            usuarioId: user.id.toString(),
            usuarioNombre: user.name,
            email: user.email,
            rol: user.rol,
            // Los permisos se mantienen o se cargan si existen
        });
    };

    const handleDelete = async (id) => {
        if (window.confirm('¿Eliminar este usuario?')) {
            try {
                await userService.delete(id);
                loadUsers();
            } catch (err) {
                alert('Error al eliminar: ' + err.message);
            }
        }
    };

    const filteredUsers = users.filter(u =>
        u.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        u.email?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        u.rol?.toLowerCase().includes(searchTerm.toLowerCase())
    );

    if (loading) return <div className="loading">Cargando usuarios...</div>;

    return (
        <div className="register-user-container">
            <h2>SISTEMA DE GESTION PENITENCIARIO - Módulo de Registro de Usuarios del Sistema</h2>

            <div className="card">
                <div className="card-title">
                    {editingId ? 'EDITAR USUARIO' : 'REGISTRAR NUEVO USUARIO'}
                </div>
                {error && <div className="error-message">{error}</div>}
                <form onSubmit={handleSubmit}>
                    <div className="form-row">
                        <div className="form-group">
                            <label>Nombre Completo del Usuario (como en Cedula)</label>
                            <input
                                type="text"
                                name="usuarioNombre"
                                value={form.usuarioNombre}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <div className="form-group">
                            <label>Email Institucional</label>
                            <input
                                type="email"
                                name="email"
                                value={form.email}
                                onChange={handleChange}
                                placeholder="usuario@prison.local"
                            />
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                            <label>ID de Usuario Sugerido</label>
                            <input
                                type="text"
                                name="usuarioId"
                                value={form.usuarioId}
                                onChange={handleChange}
                            />
                        </div>
                        <div className="form-group">
                            <label>Contraseña Temporal</label>
                            <input
                                type="password"
                                name="password"
                                value={form.password}
                                onChange={handleChange}
                                placeholder="Dejar en blanco para generar automática"
                            />
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                            <label>Tipo de Identificación</label>
                            <select name="tipoIdentificacion" value={form.tipoIdentificacion} onChange={handleChange}>
                                <option value="DNI">DNI</option>
                                <option value="Pasaporte">Pasaporte</option>
                            </select>
                        </div>
                        <div className="form-group">
                            <label>Número de Documento</label>
                            <input
                                type="text"
                                name="numeroDocumento"
                                value={form.numeroDocumento}
                                onChange={handleChange}
                            />
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                            <label>NIVEL DE ACCESO (ROL)</label>
                            <div className="role-selector">
                                <label>
                                    <input
                                        type="radio"
                                        name="rol"
                                        value="Custodio"
                                        checked={form.rol === 'Custodio'}
                                        onChange={() => handleRoleChange('Custodio')}
                                    /> Custodio
                                </label>
                                <label>
                                    <input
                                        type="radio"
                                        name="rol"
                                        value="Administrador"
                                        checked={form.rol === 'Administrador'}
                                        onChange={() => handleRoleChange('Administrador')}
                                    /> Administrador
                                </label>
                                <label>
                                    <input
                                        type="radio"
                                        name="rol"
                                        value="Médico"
                                        checked={form.rol === 'Médico'}
                                        onChange={() => handleRoleChange('Médico')}
                                    /> Médico
                                </label>
                            </div>
                        </div>
                    </div>

                    <hr />

                    <div className="card-title">ASIGNACIÓN DE PERMISOS (Simulación)</div>
                    <p className="help-text">Los permisos se asignan según el rol seleccionado. Esta sección es informativa.</p>
                    <div className="permissions-grid">
                        {Object.keys(form.permisos).map(module => (
                            <div key={module} className="module-permissions">
                                <strong>{module}</strong>
                                <div className="perm-checkboxes">
                                    {Object.keys(form.permisos[module]).map(action => (
                                        <label key={action}>
                                            <input
                                                type="checkbox"
                                                checked={form.permisos[module][action]}
                                                onChange={() => handlePermissionChange(module, action)}
                                            /> {action.charAt(0).toUpperCase() + action.slice(1)}
                                        </label>
                                    ))}
                                </div>
                            </div>
                        ))}
                    </div>

                    <div className="form-actions">
                        <button type="submit" className="btn btn-success">
                            <FontAwesomeIcon icon={editingId ? faSave : faUserPlus} />
                            {editingId ? ' Actualizar Usuario' : ' Registrar Usuario'}
                        </button>
                        {editingId && (
                            <button type="button" className="btn btn-secondary" onClick={() => { setEditingId(null); setForm({ ...form, usuarioId: '', usuarioNombre: '', email: '', password: '', rol: 'Custodio' }); }}>
                                Cancelar Edición
                            </button>
                        )}
                    </div>
                </form>
            </div>

            <div className="card">
                <div className="card-title">BÚSQUEDA Y GESTIÓN DE USUARIOS EXISTENTES</div>
                <div className="search-bar">
                    <input
                        type="text"
                        placeholder="Buscar por nombre, email o rol..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                    <button className="btn btn-primary"><FontAwesomeIcon icon={faSearch} /> Buscar</button>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Email</th>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredUsers.length === 0 ? (
                            <tr><td colSpan="5">No hay usuarios registrados.</td></tr>
                        ) : (
                            filteredUsers.map(u => (
                                <tr key={u.id}>
                                    <td>{u.id}</td>
                                    <td>{u.name}</td>
                                    <td>{u.email}</td>
                                    <td><span className="badge badge-info">{u.rol}</span></td>
                                    <td>
                                        <button className="btn btn-sm btn-primary" onClick={() => handleEdit(u)}>
                                            <FontAwesomeIcon icon={faEdit} />
                                        </button>
                                        <button className="btn btn-sm btn-danger" onClick={() => handleDelete(u.id)}>
                                            <FontAwesomeIcon icon={faTrash} />
                                        </button>
                                    </td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default RegisterUserPage;
