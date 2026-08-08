import React from 'react';
import { useAuth } from '../../context/AuthContext'; //AÑADIDO 03/08/26 PARA USAR EL CONTEXTO DE AUTENTICACIÓN
import { dashboardStats, mockInmates } from '../../services/mockData';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faUsers, faUserShield, faExclamationTriangle, faClock, faDoorOpen } from '@fortawesome/free-solid-svg-icons';
import './DashboardPage.css';

const DashboardPage = () => {
  const stats = dashboardStats;
  const { user } = useAuth(); //AÑADIDO 03/08/26 PARA OBTENER EL USUARIO AUTENTICADO
  return (
    <div className="dashboard-container">
      <h2>Panel de Control</h2>

      {/* Indicadores clave */}
      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-icon"><FontAwesomeIcon icon={faUsers} /></div>
          <div className="stat-content">
            <div className="stat-number">{stats.totalInmates}</div>
            <div className="stat-label">Población Reclusos</div>
            <div className="stat-sub">/Cap. {stats.capacity}</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon"><FontAwesomeIcon icon={faUsers} /></div>
          <div className="stat-content">
            <div className="stat-number">{stats.occupancy}%</div>
            <div className="stat-label">Ocupación</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon"><FontAwesomeIcon icon={faUserShield} /></div>
          <div className="stat-content">
            <div className="stat-number">{stats.securityStaff}</div>
            <div className="stat-label">Personal de Seguridad</div>
            <div className="stat-sub">Activos</div>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon"><FontAwesomeIcon icon={faExclamationTriangle} /></div>
          <div className="stat-content">
            <div className="stat-number">{stats.activeIncidents}</div>
            <div className="stat-label">Incidencias Activas</div>
          </div>
        </div>
      </div>

      <div className="dashboard-grid">
        {/* Estado de usuarios */}
        <div className="card">
          <div className="card-title">Estado de Usuarios</div>
          <div className="user-status-bars">
            <div className="status-bar">
              <span>Activos</span>
              <span>{stats.userStatus.active}</span>
              <div className="bar"><div style={{ width: '60%' }} className="fill-success"></div></div>
            </div>
            <div className="status-bar">
              <span>Inactivos</span>
              <span>{stats.userStatus.inactive}</span>
              <div className="bar"><div style={{ width: '20%' }} className="fill-warning"></div></div>
            </div>
            <div className="status-bar">
              <span>Bloqueados</span>
              <span>{stats.userStatus.blocked}</span>
              <div className="bar"><div style={{ width: '10%' }} className="fill-danger"></div></div>
            </div>
          </div>
        </div>

        {/* Control de acceso */}
        <div className="card">
          <div className="card-title">Control de Acceso</div>
          {stats.accessControls.map((ctrl, idx) => (
            <div key={idx} className="access-item">
              <span>{ctrl.name}</span>
              <span className={`badge ${ctrl.status === 'Acceso en curso' ? 'badge-success' : 'badge-secondary'}`}>
                {ctrl.status}
              </span>
            </div>
          ))}
        </div>

        {/* Alertas críticas */}
        <div className="card">
          <div className="card-title">Alertas de Acceso Críticas</div>
          <ul className="alert-list">
            {stats.criticalAlerts.map((alert, idx) => (
              <li key={idx}><FontAwesomeIcon icon={faExclamationTriangle} /> {alert}</li>
            ))}
          </ul>
        </div>

        {/* Solicitudes por rol */}
        <div className="card">
          <div className="card-title">Solicitudes de Acceso por Rol</div>
          <ul className="role-requests">
            {Object.entries(stats.accessRequests).map(([role, count]) => (
              <li key={role}><span>{role}</span><span className="badge badge-info">{count}</span></li>
            ))}
          </ul>
        </div>
      </div>

      {/* Historial de inicios de sesión */}
      <div className="card">
        <div className="card-title">Historial de Inicios de Sesión Recientes</div>
        <table>
          <thead>
            <tr><th>Hora</th><th>Usuario</th><th>Ubicación</th><th>Estado</th></tr>
          </thead>
          <tbody>
            {stats.recentLogins.map((log, idx) => (
              <tr key={idx}>
                <td>{log.time}</td>
                <td>{log.user}</td>
                <td>{log.location}</td>
                <td><span className={`badge ${log.status === 'Autenticado' ? 'badge-success' : log.status === 'Sesión Cerrada' ? 'badge-secondary' : 'badge-danger'}`}>{log.status}</span></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Actividad por hora/día (simulado) */}
      <div className="card">
        <div className="card-title">Actividad de Acceso por Hora/Día</div>
        <div className="activity-chart">
          <div className="bar-chart">
            <div className="bar" style={{ height: '30%' }}></div>
            <div className="bar" style={{ height: '50%' }}></div>
            <div className="bar" style={{ height: '80%' }}></div>
            <div className="bar" style={{ height: '60%' }}></div>
            <div className="bar" style={{ height: '90%' }}></div>
            <div className="bar" style={{ height: '40%' }}></div>
            <div className="bar" style={{ height: '70%' }}></div>
            <div className="bar" style={{ height: '55%' }}></div>
          </div>
          <div className="chart-labels">
            <span>Hora</span><span>Hora</span><span>Hora</span><span>Hora</span>
          </div>
        </div>
        <div className="footer-info">
            <div className="status-item">
               <span className="status-indicator"></span> Date / Time: {new Date().toLocaleString()}
           </div>
           <div className="header-right">
              <span>Logout {user?.rol || 'Sin rol'}, {user?.name || 'Usuario'}</span>
          </div>
          
        </div>
      </div>
    </div>
  );
};

export default DashboardPage;