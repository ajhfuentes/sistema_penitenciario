import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faFingerprint, faEye, faUserPlus, faCheckCircle, faClock } from '@fortawesome/free-solid-svg-icons';
import { transferRequests } from '../../services/mockData';
import './InmateCapturePage.css';

const InmateCapturePage = () => {
  const [form, setForm] = useState({
    nombre: '',
    id: '',
    fechaNacimiento: '',
    nacionalidad: '',
    genero: '',
    delitoPrincipal: '',
    historialDelictivo: '',
    afiliacionPandillas: '',
    comportamiento: '',
  });

  const [currentStep, setCurrentStep] = useState(0);
  const steps = ['Captura Biométrica', 'Ingreso de Datos', 'Evaluación de Riesgo', 'Asignación de Celda', 'Entrevista'];

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('Recluso registrado (simulación)');
  };

  return (
    <div className="inmate-capture-container">
      <h2>Módulo de Registro de Delincuentes (Captura)</h2>

      <div className="capture-grid">
        {/* Flujo de admisión */}
        <div className="card admission-flow">
          <div className="card-title">Flujo de Admisión</div>
          <div className="step-indicators">
            {steps.map((step, idx) => (
              <div key={idx} className={`step ${idx === currentStep ? 'active' : idx < currentStep ? 'completed' : ''}`}>
                <span className="step-number">{idx + 1}</span>
                <span className="step-label">{step}</span>
                {idx < steps.length - 1 && <span className="step-connector"></span>}
              </div>
            ))}
          </div>
        </div>

        {/* Registro biométrico */}
        <div className="card biometric-capture">
          <div className="card-title">REGISTRO BIOMÉTRICO (NUEVO)</div>
          <div className="biometric-actions">
            <button className="btn btn-primary"><FontAwesomeIcon icon={faEye} /> Escanear Iris</button>
            <button className="btn btn-primary"><FontAwesomeIcon icon={faFingerprint} /> Registrar Huellas Digitales</button>
          </div>
          <div className="biometric-preview">
            <div className="preview-box">Huella</div>
            <div className="preview-box">Iris</div>
          </div>
        </div>
      </div>

      {/* Datos personales */}
      <div className="card">
        <div className="card-title">DATOS PERSONALES</div>
        <form onSubmit={handleSubmit}>
          <div className="form-row">
            <div className="form-group">
              <label>Nombre Completo (como en DNI/Pasaporte)</label>
              <input type="text" name="nombre" value={form.nombre} onChange={handleChange} placeholder="J... Doe" />
            </div>
            <div className="form-group">
              <label>ID/DNI</label>
              <input type="text" name="id" value={form.id} onChange={handleChange} placeholder="ID/98X" />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>Fecha de Nacimiento</label>
              <input type="date" name="fechaNacimiento" value={form.fechaNacimiento} onChange={handleChange} />
            </div>
            <div className="form-group">
              <label>Nacionalidad</label>
              <input type="text" name="nacionalidad" value={form.nacionalidad} onChange={handleChange} />
            </div>
            <div className="form-group">
              <label>Género</label>
              <select name="genero" value={form.genero} onChange={handleChange}>
                <option value="">Seleccionar</option>
                <option value="M">Masculino</option>
                <option value="F">Femenino</option>
              </select>
            </div>
          </div>

          <div className="card-title" style={{ marginTop: 20 }}>CLASIFICACIÓN INICIAL DE RIESGO (ASISTIDA)</div>
          <div className="form-row">
            <div className="form-group">
              <label>Delito Principal</label>
              <input type="text" name="delitoPrincipal" value={form.delitoPrincipal} onChange={handleChange} />
            </div>
            <div className="form-group">
              <label>Historial Delictivo</label>
              <input type="text" name="historialDelictivo" value={form.historialDelictivo} onChange={handleChange} />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>Afiliación Pandillas</label>
              <input type="text" name="afiliacionPandillas" value={form.afiliacionPandillas} onChange={handleChange} />
            </div>
            <div className="form-group">
              <label>Comportamiento en Tránsito</label>
              <input type="text" name="comportamiento" value={form.comportamiento} onChange={handleChange} />
            </div>
          </div>
          <div className="risk-assessment">
            <span>Evaluación de Riesgo: <strong>Generado nivel sugestivo</strong></span>
          </div>
          <button type="submit" className="btn btn-success" style={{ marginTop: 15 }}>
            <FontAwesomeIcon icon={faUserPlus} /> Registrar Recluso
          </button>
        </form>
      </div>

      {/* Solicitudes de traslado pendientes */}
      <div className="card">
        <div className="card-title">REVISIÓN DE SOLICITUDES DE TRASLADO (PENDIENTES)</div>
        <table>
          <thead>
            <tr><th>Pendientes</th><th>ID Recluso</th><th>Nombre</th><th>Origen</th><th>Destino</th><th>Motivo</th><th>Estado</th></tr>
          </thead>
          <tbody>
            {transferRequests.map((req, idx) => (
              <tr key={idx}>
                <td><FontAwesomeIcon icon={req.status === 'Pendiente' ? faClock : req.status === 'Aprobado' ? faCheckCircle : faClock} /></td>
                <td>{req.id}</td>
                <td>{req.name}</td>
                <td>{req.origin}</td>
                <td>{req.destination}</td>
                <td>{req.motive}</td>
                <td><span className={`badge ${req.status === 'Aprobado' ? 'badge-success' : req.status === 'Denegado' ? 'badge-danger' : 'badge-warning'}`}>{req.status}</span></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default InmateCapturePage;