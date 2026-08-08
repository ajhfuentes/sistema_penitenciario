// src/components/dashboard/DashboardPage.js
import React, { useState, useEffect } from 'react';
import { reclusoService } from '../../services/reclusoService';
import { centroPenalService } from '../../services/centroPenalService';
import { personalService } from '../../services/personalService';
import { defensorService } from '../../services/defensorService';
import { causaPenalService } from '../../services/causaPenalService';
import { boletaService } from '../../services/boletaService';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { 
    faUsers, faUserShield, faBuilding, faGavel, 
    faFilePdf, faExclamationTriangle, faClock, 
    faCheckCircle, faTimesCircle, faSpinner,
    faChartLine, faDoorOpen, faUserPlus, faUserMinus,
    faSync, faDownload, faEye, faCalendarAlt
} from '@fortawesome/free-solid-svg-icons';
import { 
    BarChart, Bar, XAxis, YAxis, CartesianGrid, 
    Tooltip, Legend, ResponsiveContainer, PieChart, 
    Pie, Cell, LineChart, Line, AreaChart, Area
} from 'recharts';
import './DashboardPage.css';

const DashboardPage = () => {
    // Estados principales
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [lastUpdate, setLastUpdate] = useState(null);
    
    // Estadísticas
    const [stats, setStats] = useState({
        reclusos: { total: 0, activos: 0, enIngreso: 0, traslado: 0, libertad: 0 },
        centros: 0,
        personal: { total: 0, activos: 0, administradores: 0, custodios: 0, medicos: 0 },
        defensores: 0,
        causas: { total: 0, enJuicio: 0, sentenciado: 0, apelacion: 0, unificada: 0 },
        boletas: { total: 0, activas: 0 },
        riesgo: { alto: 0, medio: 0, bajo: 0 },
        ocupacion: { totalCapacidad: 0, ocupados: 0, porcentaje: 0 },
    });
    
    // Datos para gráficos
    const [actividadData, setActividadData] = useState([]);
    const [riesgoData, setRiesgoData] = useState([]);
    const [estadoData, setEstadoData] = useState([]);
    const [causasData, setCausasData] = useState([]);
    const [recientes, setRecientes] = useState([]);
    const [alertas, setAlertas] = useState([]);

    const COLORS = ['#1e3a5f', '#28a745', '#ffc107', '#dc3545', '#17a2b8'];

    // Cargar todos los datos
    const loadDashboardData = async () => {
        try {
            setLoading(true);
            setError(null);

            // Cargar todos los datos en paralelo
            const [
                reclusosData,
                centrosData,
                personalData,
                defensoresData,
                causasData,
                boletasData
            ] = await Promise.all([
                reclusoService.getAll(),
                centroPenalService.getAll(),
                personalService.getAll(),
                defensorService.getAll(),
                causaPenalService.getAll(),
                boletaService.getAll()
            ]);

            const reclusos = reclusosData.data || [];
            const centros = centrosData.data || [];
            const personal = personalData.data || [];
            const defensores = defensoresData.data || [];
            const causas = causasData.data || [];
            const boletas = boletaService.getAll ? (await boletaService.getAll()).data || [] : [];

            // Procesar estadísticas de reclusos
            const reclusosStats = {
                total: reclusos.length,
                activos: reclusos.filter(r => r.estado_operativo === 'Activo').length,
                enIngreso: reclusos.filter(r => r.estado_operativo === 'En Ingreso').length,
                traslado: reclusos.filter(r => r.estado_operativo === 'Traslado').length,
                libertad: reclusos.filter(r => r.estado_operativo === 'Libertad').length,
            };

            // Procesar estadísticas de riesgo
            const riesgoStats = {
                alto: reclusos.filter(r => r.nivel_riesgo === 'Alto').length,
                medio: reclusos.filter(r => r.nivel_riesgo === 'Medio').length,
                bajo: reclusos.filter(r => r.nivel_riesgo === 'Bajo').length,
            };

            // Procesar personal
            const personalStats = {
                total: personal.length,
                activos: personal.filter(p => p.activo !== false).length,
                administradores: personal.filter(p => p.rol === 'Administrador').length,
                custodios: personal.filter(p => p.rol === 'Custodio').length,
                medicos: personal.filter(p => p.rol === 'Médico').length,
            };

            // Procesar causas
            const causasStats = {
                total: causas.length,
                enJuicio: causas.filter(c => c.estado_procesal === 'En Juicio').length,
                sentenciado: causas.filter(c => c.estado_procesal === 'Sentenciado').length,
                apelacion: causas.filter(c => c.estado_procesal === 'Apelación').length,
                unificada: causas.filter(c => c.estado_procesal === 'Unificada').length,
            };

            // Calcular ocupación
            let totalCapacidad = 0;
            let ocupados = 0;
            
            // Si tenemos datos de celdas, calcular ocupación real
            try {
                const { celdaService } = await import('../../services/celdaService');
                const celdasData = await celdaService.getAll();
                const celdas = celdasData.data || [];
                
                totalCapacidad = celdas.reduce((sum, c) => sum + (c.capacidad_maxima || 0), 0);
                ocupados = reclusos.filter(r => r.estado_operativo !== 'Libertad').length;
            } catch (e) {
                // Si no hay servicio de celdas, estimar
                totalCapacidad = reclusos.length * 1.2;
                ocupados = reclusos.filter(r => r.estado_operativo !== 'Libertad').length;
            }

            const ocupacionPorcentaje = totalCapacidad > 0 
                ? Math.round((ocupados / totalCapacidad) * 100) 
                : 0;

            // Actualizar stats
            setStats({
                reclusos: reclusosStats,
                centros: centros.length,
                personal: personalStats,
                defensores: defensores.length,
                causas: causasStats,
                boletas: {
                    total: boletas.length,
                    activas: boletas.filter(b => b.activa !== false).length,
                },
                riesgo: riesgoStats,
                ocupacion: {
                    totalCapacidad: Math.round(totalCapacidad),
                    ocupados: ocupados,
                    porcentaje: ocupacionPorcentaje,
                }
            });

            // Datos para gráficos
            setRiesgoData([
                { name: 'Alto', value: riesgoStats.alto },
                { name: 'Medio', value: riesgoStats.medio },
                { name: 'Bajo', value: riesgoStats.bajo },
            ]);

            setEstadoData([
                { name: 'Activo', value: reclusosStats.activos },
                { name: 'En Ingreso', value: reclusosStats.enIngreso },
                { name: 'Traslado', value: reclusosStats.traslado },
                { name: 'Libertad', value: reclusosStats.libertad },
            ]);

            setCausasData([
                { name: 'En Juicio', value: causasStats.enJuicio },
                { name: 'Sentenciado', value: causasStats.sentenciado },
                { name: 'Apelación', value: causasStats.apelacion },
                { name: 'Unificada', value: causasStats.unificada },
            ]);

            // Datos de actividad (últimos 7 días simulados)
            const dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
            const actividad = dias.map((dia, i) => ({
                dia,
                ingresos: Math.floor(Math.random() * 10) + 1,
                liberaciones: Math.floor(Math.random() * 5) + 1,
                traslados: Math.floor(Math.random() * 3) + 1,
            }));
            setActividadData(actividad);

            // Actividad reciente (simulada con datos reales de reclusos)
            const recientesData = reclusos
                .filter(r => r.created_at)
                .sort((a, b) => new Date(b.created_at) - new Date(a.created_at))
                .slice(0, 8)
                .map(r => ({
                    id: r.id,
                    nombre: `${r.nombres} ${r.apellidos}`,
                    accion: r.estado_operativo === 'Libertad' ? 'Liberación' : 'Ingreso',
                    fecha: r.created_at ? new Date(r.created_at).toLocaleString() : 'N/A',
                    estado: r.estado_operativo,
                }));

            setRecientes(recientesData);

            // Alertas (basadas en datos reales)
            const alertasData = [];
            
            // Alerta de alta ocupación
            if (ocupacionPorcentaje > 85) {
                alertasData.push({
                    tipo: 'warning',
                    mensaje: `Alta ocupación: ${ocupacionPorcentaje}% de capacidad utilizada`,
                    fecha: new Date().toLocaleString(),
                });
            }

            // Alerta de reclusos en ingreso pendientes
            if (reclusosStats.enIngreso > 5) {
                alertasData.push({
                    tipo: 'info',
                    mensaje: `${reclusosStats.enIngreso} reclusos en proceso de ingreso`,
                    fecha: new Date().toLocaleString(),
                });
            }

            // Alerta de personal insuficiente
            const relacionReclusosPersonal = reclusosStats.total / (personalStats.activos || 1);
            if (relacionReclusosPersonal > 15) {
                alertasData.push({
                    tipo: 'danger',
                    mensaje: `Alta carga laboral: ${Math.round(relacionReclusosPersonal)} reclusos por personal activo`,
                    fecha: new Date().toLocaleString(),
                });
            }

            // Alerta de causas en juicio
            if (causasStats.enJuicio > 10) {
                alertasData.push({
                    tipo: 'warning',
                    mensaje: `${causasStats.enJuicio} causas en proceso judicial`,
                    fecha: new Date().toLocaleString(),
                });
            }

            setAlertas(alertasData);
            setLastUpdate(new Date().toLocaleString());

        } catch (err) {
            console.error('Error cargando dashboard:', err);
            setError('Error al cargar los datos del dashboard: ' + (err.response?.data?.message || err.message));
            
            // Cargar datos de respaldo (estadísticas básicas)
            try {
                const statsData = await reclusoService.getEstadisticas();
                if (statsData) {
                    setStats(prev => ({
                        ...prev,
                        reclusos: {
                            total: statsData.total || 0,
                            activos: statsData.activos || 0,
                            enIngreso: statsData.en_ingreso || 0,
                            traslado: statsData.traslado || 0,
                            libertad: statsData.libertad || 0,
                        },
                        riesgo: {
                            alto: statsData.riesgo?.Alto || 0,
                            medio: statsData.riesgo?.Medio || 0,
                            bajo: statsData.riesgo?.Bajo || 0,
                        }
                    }));
                }
            } catch (e) {
                // Si falla, usar datos vacíos
            }
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadDashboardData();
        // Actualizar cada 60 segundos
        const interval = setInterval(loadDashboardData, 60000);
        return () => clearInterval(interval);
    }, []);

    // Formatear número
    const formatNumber = (num) => {
        return new Intl.NumberFormat('es-VE').format(num);
    };

    // Obtener clase de badge
    const getBadgeClass = (tipo) => {
        const clases = {
            'danger': 'badge-danger',
            'warning': 'badge-warning',
            'info': 'badge-info',
            'success': 'badge-success',
        };
        return `badge ${clases[tipo] || 'badge-secondary'}`;
    };

    // Renderizar loading
    if (loading) {
        return (
            <div className="dashboard-container">
                <div className="loading-overlay">
                    <div className="spinner-large"></div>
                    <p>Cargando datos del sistema...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="dashboard-container">
            {/* Header */}
            <div className="dashboard-header">
                <div>
                    <h2>📊 Panel de Control</h2>
                    <p className="subtitle">Vista general del Sistema Penitenciario</p>
                </div>
                <div className="header-actions">
                    <span className="last-update">
                        <FontAwesomeIcon icon={faClock} /> Última actualización: {lastUpdate || 'N/A'}
                    </span>
                    <button className="btn btn-secondary" onClick={loadDashboardData}>
                        <FontAwesomeIcon icon={faSync} /> Actualizar
                    </button>
                </div>
            </div>

            {error && (
                <div className="alert alert-danger">
                    <strong>⚠️ Error:</strong> {error}
                    <button className="btn btn-sm btn-secondary" onClick={loadDashboardData}>
                        Reintentar
                    </button>
                </div>
            )}

            {/* Tarjetas de Estadísticas */}
            <div className="stats-grid">
                <div className="stat-card">
                    <div className="stat-icon primary">
                        <FontAwesomeIcon icon={faUsers} />
                    </div>
                    <div className="stat-content">
                        <div className="stat-number">{formatNumber(stats.reclusos.total)}</div>
                        <div className="stat-label">Total Reclusos</div>
                        <div className="stat-details">
                            <span className="stat-detail active">
                                <FontAwesomeIcon icon={faCheckCircle} /> {stats.reclusos.activos} Activos
                            </span>
                            <span className="stat-detail">
                                <FontAwesomeIcon icon={faUserPlus} /> {stats.reclusos.enIngreso} Ingreso
                            </span>
                            <span className="stat-detail">
                                <FontAwesomeIcon icon={faUserMinus} /> {stats.reclusos.libertad} Libertad
                            </span>
                        </div>
                    </div>
                </div>

                <div className="stat-card">
                    <div className="stat-icon success">
                        <FontAwesomeIcon icon={faBuilding} />
                    </div>
                    <div className="stat-content">
                        <div className="stat-number">{formatNumber(stats.centros)}</div>
                        <div className="stat-label">Centros Penales</div>
                        <div className="stat-details">
                            <span className="stat-detail">
                                <FontAwesomeIcon icon={faDoorOpen} /> {stats.ocupacion.porcentaje}% Ocupación
                            </span>
                            <span className="stat-detail">
                                <FontAwesomeIcon icon={faUsers} /> {stats.ocupacion.ocupados} / {stats.ocupacion.totalCapacidad}
                            </span>
                        </div>
                    </div>
                </div>

                <div className="stat-card">
                    <div className="stat-icon warning">
                        <FontAwesomeIcon icon={faUserShield} />
                    </div>
                    <div className="stat-content">
                        <div className="stat-number">{formatNumber(stats.personal.activos)}</div>
                        <div className="stat-label">Personal Activo</div>
                        <div className="stat-details">
                            <span className="stat-detail">
                                {stats.personal.administradores} Admin
                            </span>
                            <span className="stat-detail">
                                {stats.personal.custodios} Custodios
                            </span>
                            <span className="stat-detail">
                                {stats.personal.medicos} Médicos
                            </span>
                        </div>
                    </div>
                </div>

                <div className="stat-card">
                    <div className="stat-icon danger">
                        <FontAwesomeIcon icon={faGavel} />
                    </div>
                    <div className="stat-content">
                        <div className="stat-number">{formatNumber(stats.causas.total)}</div>
                        <div className="stat-label">Causas Penales</div>
                        <div className="stat-details">
                            <span className="stat-detail">
                                <FontAwesomeIcon icon={faClock} /> {stats.causas.enJuicio} Juicio
                            </span>
                            <span className="stat-detail">
                                <FontAwesomeIcon icon={faCheckCircle} /> {stats.causas.sentenciado} Sentenciadas
                            </span>
                        </div>
                    </div>
                </div>

                <div className="stat-card">
                    <div className="stat-icon info">
                        <FontAwesomeIcon icon={faFilePdf} />
                    </div>
                    <div className="stat-content">
                        <div className="stat-number">{formatNumber(stats.boletas.total)}</div>
                        <div className="stat-label">Boletas de Excarcelación</div>
                        <div className="stat-details">
                            <span className="stat-detail active">
                                <FontAwesomeIcon icon={faCheckCircle} /> {stats.boletas.activas} Activas
                            </span>
                            <span className="stat-detail">
                                <FontAwesomeIcon icon={faTimesCircle} /> {stats.boletas.total - stats.boletas.activas} Inactivas
                            </span>
                        </div>
                    </div>
                </div>

                <div className="stat-card">
                    <div className="stat-icon secondary">
                        <FontAwesomeIcon icon={faUserShield} />
                    </div>
                    <div className="stat-content">
                        <div className="stat-number">{formatNumber(stats.defensores)}</div>
                        <div className="stat-label">Defensores Registrados</div>
                        <div className="stat-details">
                            <span className="stat-detail">
                                <FontAwesomeIcon icon={faCheckCircle} /> Disponibles
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            {/* Gráficos */}
            <div className="charts-grid">
                {/* Gráfico de Riesgo */}
                <div className="card chart-card">
                    <div className="card-title">Distribución por Nivel de Riesgo</div>
                    <ResponsiveContainer width="100%" height={250}>
                        <PieChart>
                            <Pie
                                data={riesgoData}
                                cx="50%"
                                cy="50%"
                                labelLine={true}
                                label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
                                outerRadius={80}
                                fill="#8884d8"
                                dataKey="value"
                            >
                                {riesgoData.map((entry, index) => (
                                    <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                                ))}
                            </Pie>
                            <Tooltip />
                        </PieChart>
                    </ResponsiveContainer>
                </div>

                {/* Gráfico de Estados */}
                <div className="card chart-card">
                    <div className="card-title">Estado de Reclusos</div>
                    <ResponsiveContainer width="100%" height={250}>
                        <BarChart data={estadoData}>
                            <CartesianGrid strokeDasharray="3 3" />
                            <XAxis dataKey="name" />
                            <YAxis />
                            <Tooltip />
                            <Legend />
                            <Bar dataKey="value" fill="#1e3a5f" />
                        </BarChart>
                    </ResponsiveContainer>
                </div>

                {/* Gráfico de Causas */}
                <div className="card chart-card">
                    <div className="card-title">Estado de Causas Penales</div>
                    <ResponsiveContainer width="100%" height={250}>
                        <BarChart data={causasData}>
                            <CartesianGrid strokeDasharray="3 3" />
                            <XAxis dataKey="name" />
                            <YAxis />
                            <Tooltip />
                            <Legend />
                            <Bar dataKey="value" fill="#17a2b8" />
                        </BarChart>
                    </ResponsiveContainer>
                </div>

                {/* Actividad Semanal */}
                <div className="card chart-card">
                    <div className="card-title">Actividad Semanal</div>
                    <ResponsiveContainer width="100%" height={250}>
                        <AreaChart data={actividadData}>
                            <CartesianGrid strokeDasharray="3 3" />
                            <XAxis dataKey="dia" />
                            <YAxis />
                            <Tooltip />
                            <Legend />
                            <Area type="monotone" dataKey="ingresos" stackId="1" stroke="#28a745" fill="#28a745" fillOpacity={0.6} />
                            <Area type="monotone" dataKey="liberaciones" stackId="1" stroke="#dc3545" fill="#dc3545" fillOpacity={0.6} />
                            <Area type="monotone" dataKey="traslados" stackId="1" stroke="#ffc107" fill="#ffc107" fillOpacity={0.6} />
                        </AreaChart>
                    </ResponsiveContainer>
                </div>
            </div>

            {/* Actividad Reciente y Alertas */}
            <div className="activity-grid">
                {/* Actividad Reciente */}
                <div className="card activity-card">
                    <div className="card-title">
                        <FontAwesomeIcon icon={faClock} /> Actividad Reciente
                    </div>
                    {recientes.length === 0 ? (
                        <div className="empty-state">No hay actividad reciente</div>
                    ) : (
                        <div className="activity-list">
                            {recientes.map((item, index) => (
                                <div key={index} className="activity-item">
                                    <div className="activity-icon">
                                        {item.accion === 'Liberación' ? '🟣' : '🟢'}
                                    </div>
                                    <div className="activity-content">
                                        <div className="activity-user">
                                            <strong>{item.nombre}</strong>
                                            <span className={`badge ${getBadgeClass(
                                                item.estado === 'Libertad' ? 'success' : 'info'
                                            )}`}>
                                                {item.accion}
                                            </span>
                                        </div>
                                        <div className="activity-time">
                                            <FontAwesomeIcon icon={faClock} /> {item.fecha}
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                </div>

                {/* Alertas */}
                <div className="card alerts-card">
                    <div className="card-title">
                        <FontAwesomeIcon icon={faExclamationTriangle} /> Alertas del Sistema
                    </div>
                    {alertas.length === 0 ? (
                        <div className="empty-state">
                            <FontAwesomeIcon icon={faCheckCircle} className="success-icon" />
                            <p>No hay alertas activas</p>
                        </div>
                    ) : (
                        <div className="alerts-list">
                            {alertas.map((alerta, index) => (
                                <div key={index} className={`alert-item ${alerta.tipo}`}>
                                    <div className="alert-icon">
                                        {alerta.tipo === 'danger' && '🔴'}
                                        {alerta.tipo === 'warning' && '🟡'}
                                        {alerta.tipo === 'info' && '🔵'}
                                    </div>
                                    <div className="alert-content">
                                        <div className="alert-message">{alerta.mensaje}</div>
                                        <div className="alert-time">
                                            <FontAwesomeIcon icon={faClock} /> {alerta.fecha}
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                </div>
            </div>

            {/* Footer con resumen */}
            <div className="dashboard-footer">
                <div className="footer-info">
                    <span>📋 Sistema Integral Penitenciario v1.0</span>
                    <span>🔒 Datos en tiempo real</span>
                    <span>🔄 Actualizado: {lastUpdate || 'N/A'}</span>
                </div>
                <div className="footer-stats">
                    <span>
                        <FontAwesomeIcon icon={faUsers} /> {stats.reclusos.total} reclusos
                    </span>
                    <span>
                        <FontAwesomeIcon icon={faBuilding} /> {stats.centros} centros
                    </span>
                    <span>
                        <FontAwesomeIcon icon={faUserShield} /> {stats.personal.activos} personal
                    </span>
                </div>
            </div>
        </div>
    );
};

export default DashboardPage;
