import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSearch, faEdit, faTrash, faUserPlus, faFingerprint, faEye } from '@fortawesome/free-solid-svg-icons';
import './RegisterUserPage.css';

const RegisterUserPage = () => {
  const [form, setForm] = useState({
    solicitanteNombre: '',
    cargo: '',
    unidad: '',
    email: '',
    firma: '',
    usuarioId: '',
    usuarioNombre: '',
    tipoIdentificacion: '',
    numeroDocumento: '',
    nivelAcceso: 'Básico',
    roles: {
      Administrador: false,
      'Oficial de Campo': false,
      'Analista de Inteligencia': false,
      'Registrador de Biometría': false,
    },
    permisos: {
      'Módulo de Criminales': { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
      Historiales: { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
      Reportes: { visualizacion: false, edicion: false, creacion: false, eliminacion: false },
    }
  });

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    if (type === 'checkbox') {
      setForm(prev => ({
        ...prev,
        [name]: checked
      }));
    } else {
      setForm(prev => ({ ...prev, [name]: value }));
    }
  };

  const handleRoleChange = (role) => {
    setForm(prev => ({
      ...prev,
      roles: {
        ...prev.roles,
        [role]: !prev.roles[role]
      }
    }));
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

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('Usuario registrado (simulación)');
  };

  // Datos mock de usuarios existentes
  const existingUsers = [
    { id: 'ID-0987', name: 'J. Doe', status: 'Recluso Completo' },
    { id: 'ID-0987', name: 'J. Doe', status: 'Recluso Inteligencia' },
    { id: 'ID-0987', name: 'J. Doe', status: 'Recluso de Campo' },
    { id: 'ID-0948', name: 'J. Doe', status: 'Recluso de Campo' },
  ];

  return (
    <div className="register-user-container">
      <h2>SISTEMA INTEGRAL PENITENCIARIO - Módulo de Registro de Usuarios del Sistema</h2>

      <div className="card">
        <div className="card-title">INFORMACIÓN DEL SOLICITANTE</div>
        <form onSubmit={handleSubmit}>
          <div className="form-row">
            <div className="form-group">
              <label>Nombre Completo Institucional (ej. Carmen Díaz)</label>
              <input
                type="text"
                name="solicitanteNombre"
                value={form.solicitanteNombre}
                onChange={handleChange}
              />
            </div>
            <div className="form-group">
              <label>Cargo/Puesto</label>
              <input type="text" name="cargo" value={form.cargo} onChange={handleChange} />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>Unidad/División</label>
              <input type="text" name="unidad" value={form.unidad} onChange={handleChange} />
            </div>
            <div className="form-group">
              <label>Email Institucional</label>
              <input type="email" name="email" value={form.email} onChange={handleChange} />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>Firma Digital de Autorización</label>
              <div className="firma-actions">
                <input type="text" name="firma" value={form.firma} onChange={handleChange} placeholder="Firma digital" />
                <button type="button" className="btn btn-secondary">REGISTRAR FIRMA</button>
              </div>
            </div>
          </div>

          <hr />

          <div className="card-title">DETALLES DEL USUARIO A REGISTRAR</div>
          <div className="form-row">
            <div className="form-group">
              <label>ID de Usuario Sugerido</label>
              <input type="text" name="usuarioId" value={form.usuarioId} onChange={handleChange} />
            </div>
            <div className="form-group">
              <label>Nombre Completo del Usuario (como en DNI)</label>
              <input type="text" name="usuarioNombre" value={form.usuarioNombre} onChange={handleChange} />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>Tipo de Identificación</label>
              <select name="tipoIdentificacion" value={form.tipoIdentificacion} onChange={handleChange}>
                <option value="">Seleccionar</option>
                <option value="DNI">DNI</option>
                <option value="Pasaporte">Pasaporte</option>
              </select>
            </div>
            <div className="form-group">
              <label>Número de Documento</label>
              <input type="text" name="numeroDocumento" value={form.numeroDocumento} onChange={handleChange} />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>Contraseña Temporal (Generada automáticamente/Oculta)</label>
              <input type="password" value="********" readOnly />
            </div>
            <div className="form-group">
              <label>NIVEL DE ACCESO SUGERIDO</label>
              <div style={{ display: 'flex', gap: '20px', alignItems: 'center' }}>
                <label>
                  <input
                    type="radio"
                    name="nivelAcceso"
                    value="Básico"
                    checked={form.nivelAcceso === 'Básico'}
                    onChange={handleChange}
                  /> Básico
                </label>
                <label>
                  <input
                    type="radio"
                    name="nivelAcceso"
                    value="Administrador"
                    checked={form.nivelAcceso === 'Administrador'}
                    onChange={handleChange}
                  /> Administrador
                </label>
                <button type="button" className="btn btn-secondary">REGENERAR</button>
              </div>
            </div>
          </div>

          <hr />

          <div className="card-title">BÚSQUEDA Y GESTIÓN</div>
          <div className="search-bar">
            <input type="text" placeholder="Buscando..." />
            <button className="btn btn-primary"><FontAwesomeIcon icon={faSearch} /> Buscar</button>
          </div>
          <table>
            <thead>
              <tr>
                <th>Usuario ID</th>
                <th>Nombre</th>
                <th>Estado</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              {existingUsers.map((u, idx) => (
                <tr key={idx}>
                  <td>{u.id}</td>
                  <td>{u.name}</td>
                  <td><span className="badge badge-info">{u.status}</span></td>
                  <td>
                    <button className="btn btn-sm btn-primary"><FontAwesomeIcon icon={faEdit} /></button>
                    <button className="btn btn-sm btn-danger"><FontAwesomeIcon icon={faTrash} /></button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          <hr />

          <div className="card-title">ASIGNACIÓN DE ROLES Y PERMISOS</div>
          <div className="roles-grid">
            <div className="roles-list">
              <h4>Roles</h4>
              {Object.keys(form.roles).map(role => (
                <label key={role}>
                  <input
                    type="checkbox"
                    checked={form.roles[role]}
                    onChange={() => handleRoleChange(role)}
                  /> {role}
                </label>
              ))}
            </div>
            <div className="permissions-grid">
              <h4>Permisos por Módulo</h4>
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
          </div>

          <div style={{ marginTop: 20, display: 'flex', justifyContent: 'flex-end', gap: 10 }}>
            <button type="submit" className="btn btn-success"><FontAwesomeIcon icon={faUserPlus} /> Registrar Usuario</button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default RegisterUserPage;