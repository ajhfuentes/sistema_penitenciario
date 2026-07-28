import React from 'react';
import { mockInmates } from '../../services/mockData';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSearch, faEye, faEdit, faTrash } from '@fortawesome/free-solid-svg-icons';
import './InmateListPage.css';

const InmateListPage = () => {
  // Calculamos estadísticas para mostrar
  const riskCounts = { Alto: 0, Medio: 0, Bajo: 0 };
  mockInmates.forEach(inmate => {
    if (riskCounts[inmate.risk] !== undefined) riskCounts[inmate.risk]++;
  });
  const total = mockInmates.length;

  // Sentencias
  const sentenceCounts = { 'Larga Duración': 0, 'Media Duración': 0, 'Corta Duración': 0 };
  mockInmates.forEach(inmate => {
    if (sentenceCounts[inmate.sentence] !== undefined) sentenceCounts[inmate.sentence]++;
  });

  // Ubicación por bloque
  const blockCounts = { 'Bloque A': 0, 'Bloque B': 0, 'Bloque C': 0, 'Bloque D': 0, 'Bloque E': 0 };
  mockInmates.forEach(inmate => {
    if (blockCounts[inmate.block] !== undefined) blockCounts[inmate.block]++;
  });

  return (
    <div className="inmate-list-container">
      <h2>Registro de Delincuentes</h2>

      <div className="stats-row">
        <div className="stat-box">
          <span>Población Reclusos</span>
          <strong>{total}</strong>
          <span>/Cap. 2200</span>
        </div>
        <div className="stat-box">
          <span>Registro Biométrico Reciente</span>
          <ul>
            <li>ID-0987: J. Doe - Registrado [14:30]</li>
            <li>ID-0987: J. Doe - Registrado [14:30]</li>
            <li>ID-0897: J. Doe - Registrado [14:30]</li>
          </ul>
        </div>
      </div>

      <div className="dashboard-grid">
        <div className="card">
          <div className="card-title">Clasificación de Riesgo</div>
          <div className="risk-chart">
            <div className="risk-item">
              <span>Alto: {riskCounts.Alto}%</span>
              <div className="bar"><div style={{ width: `${(riskCounts.Alto/total)*100}%` }} className="fill-danger"></div></div>
            </div>
            <div className="risk-item">
              <span>Medio: {riskCounts.Medio}%</span>
              <div className="bar"><div style={{ width: `${(riskCounts.Medio/total)*100}%` }} className="fill-warning"></div></div>
            </div>
            <div className="risk-item">
              <span>Bajo: {riskCounts.Bajo}%</span>
              <div className="bar"><div style={{ width: `${(riskCounts.Bajo/total)*100}%` }} className="fill-success"></div></div>
            </div>
          </div>
        </div>

        <div className="card">
          <div className="card-title">Sentencias Activas</div>
          <div className="sentence-list">
            <div><span>Larga Duración</span> <span className="badge badge-info">{sentenceCounts['Larga Duración']}</span></div>
            <div><span>Media Duración</span> <span className="badge badge-warning">{sentenceCounts['Media Duración']}</span></div>
            <div><span>Corta Duración</span> <span className="badge badge-success">{sentenceCounts['Corta Duración']}</span></div>
          </div>
        </div>

        <div className="card">
          <div className="card-title">Incidencias Delictivas Recientes</div>
          <ul className="incident-list">
            <li>[14:41] Pelela</li>
            <li>[14:41] Pelela</li>
            <li>[14:41] Saterna</li>
            <li>[14:31] Pelela</li>
          </ul>
          <div className="total-incidents">Total: 12</div>
        </div>

        <div className="card">
          <div className="card-title">Ubicación por Bloque</div>
          <div className="block-chart">
            {Object.entries(blockCounts).map(([block, count]) => (
              <div key={block} className="block-item">
                <span>{block}</span>
                <div className="bar"><div style={{ width: `${(count/total)*100}%` }} className="fill-primary"></div></div>
                <span>{count}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Historial de movimientos */}
      <div className="card">
        <div className="card-title">Historial de Movimientos Recientes</div>
        <ul className="movement-list">
          <li>[14:32] Recluso M. Garcia - Bloque C → Bloque B</li>
          <li>[14:32] Recluso M. Garcia - Bloque C → Bloque B</li>
          <li>[14:32] Recluso M. Garcia - Bloque C → Bloque B</li>
        </ul>
      </div>

      {/* Alertas de seguridad */}
      <div className="card">
        <div className="card-title">Alertas de Seguridad</div>
        <ul className="alert-list">
          <li><span className="badge badge-success">Resuelto</span> Intentó de Fuga - Bloque E</li>
          <li><span className="badge badge-danger">Activa</span> Recluso Reincidente Confirmado</li>
          <li><span className="badge badge-danger">Activa</span> Recluso Reincidente Confirmado</li>
        </ul>
      </div>

      {/* Tabla de reclusos */}
      <div className="card">
        <div className="card-title">Listado de Reclusos</div>
        <div className="search-bar">
          <input type="text" placeholder="Buscar..." />
          <button className="btn btn-primary"><FontAwesomeIcon icon={faSearch} /> Buscar</button>
        </div>
        <table>
          <thead>
            <tr><th>ID</th><th>Nombre</th><th>Riesgo</th><th>Estado</th><th>Bloque</th><th>Sentencia</th><th>Acciones</th></tr>
          </thead>
          <tbody>
            {mockInmates.map((inmate, idx) => (
              <tr key={idx}>
                <td>{inmate.id}</td>
                <td>{inmate.name}</td>
                <td><span className={`badge ${inmate.risk === 'Alto' ? 'badge-danger' : inmate.risk === 'Medio' ? 'badge-warning' : 'badge-success'}`}>{inmate.risk}</span></td>
                <td><span className={`badge ${inmate.status === 'Activo' ? 'badge-success' : inmate.status === 'Libertad' ? 'badge-info' : 'badge-secondary'}`}>{inmate.status}</span></td>
                <td>{inmate.block}</td>
                <td>{inmate.sentence}</td>
                <td>
                  <button className="btn btn-sm btn-primary"><FontAwesomeIcon icon={faEye} /></button>
                  <button className="btn btn-sm btn-secondary"><FontAwesomeIcon icon={faEdit} /></button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Solicitudes de traslado (solo estado) */}
      <div className="card">
        <div className="card-title">Solicitudes de Traslado por Estado</div>
        <div className="transfer-status">
          <span><span className="badge badge-success">Aprobado</span> 3</span>
          <span><span className="badge badge-warning">Pendiente</span> 2</span>
          <span><span className="badge badge-danger">Denegado</span> 1</span>
        </div>
      </div>

      {/* Visitas programadas */}
      <div className="card">
        <div className="card-title">Visitas Programadas (Hoy)</div>
        <ul className="visit-list">
          <li>[16:00] Recluso J. Doe - Visitante M. Smith</li>
          <li>[16:00] Recluso J. Doe - Visitante M. Smith</li>
        </ul>
      </div>

      <div className="footer-info">
        <span>03/10/2023 14:35:07</span>
        <span>Ofícisi Germen Dlar</span>
      </div>
    </div>
  );
};

export default InmateListPage;