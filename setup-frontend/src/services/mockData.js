/*
CREADO EL 27/07/2026 PARA PROPORCIONAR DATOS SIMULADOS PARA EL DASHBOARD Y PRUEBAS DE LA APLICACIÓN
AÑADIDO 03/08/26 PARA USAR EL CONTEXTO DE AUTENTICACIÓN Y PROPORCIONAR DATOS SIMULADOS DE USUARIOS  
*/

// Datos de usuarios para autenticación
export const mockUsers = [
  { id: 1, username: 'admin', password: 'admin123', name: 'Administrador', role: 'Administrador' },
  { id: 2, username: 'c.diaz', password: 'password', name: 'Carmen Díaz', role: 'Oficial de Campo' },
  { id: 3, username: 'j.doe', password: '1234', name: 'John Doe', role: 'Analista de Inteligencia' },
];

// Datos de reclusos para el listado
export const mockInmates = [
  { id: 'ID-0987', name: 'J. Doe', risk: 'Alto', status: 'Activo', block: 'Bloque C', sentence: 'Larga Duración', lastMovement: 'Bloque C → Bloque B', incident: 'Pelea' },
  { id: 'ID-0988', name: 'M. García', risk: 'Medio', status: 'Activo', block: 'Bloque B', sentence: 'Media Duración', lastMovement: 'Bloque A → Bloque B', incident: 'Intento de fuga' },
  { id: 'ID-0989', name: 'L. Pérez', risk: 'Bajo', status: 'Traslado', block: 'Bloque A', sentence: 'Corta Duración', lastMovement: 'Bloque C → Bloque A', incident: 'Ninguna' },
  { id: 'ID-0990', name: 'A. Sánchez', risk: 'Alto', status: 'Activo', block: 'Bloque D', sentence: 'Larga Duración', lastMovement: 'Bloque D → Bloque D', incident: 'Reincidente' },
  { id: 'ID-0991', name: 'R. Torres', risk: 'Medio', status: 'Libertad', block: 'Bloque E', sentence: 'Media Duración', lastMovement: 'Bloque E → Bloque C', incident: 'Ninguna' },
];

// Estadísticas para dashboard
export const dashboardStats = {
  totalInmates: 2145,
  capacity: 2200,
  occupancy: 97.5,
  securityStaff: 185,
  activeIncidents: 3,
  userStatus: { active: 120, inactive: 15, blocked: 5 },
  accessControls: [
    { name: 'Puerta 1', status: 'Acceso en curso' },
    { name: 'Puerta 2', status: 'Acceso en curso' },
    { name: 'Puerta 3', status: 'Cerrada' },
  ],
  criticalAlerts: ['Contraseña incorrecta repetida', 'Acceso fuera de horario'],
  accessRequests: { Guardia: 8, 'Oficial Senior': 4, 'Técnico IT': 2, Administrador: 1 },
  recentLogins: [
    { time: '14:42', user: 'Oficial García', location: 'Control de Acceso 1', status: 'Autenticado' },
    { time: '14:40', user: 'Intrusión Detectada', location: 'Bloque C', status: 'Intento Fallido' },
    { time: '14:38', user: 'Admin Póres', location: 'Estación 3', status: 'Sesión Cerrada' },
  ],
};

// Datos de solicitudes de traslado pendientes
export const transferRequests = [
  { id: 'ID-0987', name: 'J. Doe', origin: 'Origen A', destination: 'Bloque B', motive: 'Reincidente', status: 'Pendiente' },
  { id: 'ID-0988', name: 'M. García', origin: 'Origen B', destination: 'Bloque C', motive: 'Comportamiento', status: 'Aprobado' },
  { id: 'ID-0984', name: 'L. Pérez', origin: 'Origen D', destination: 'Bloque A', motive: 'Traslado', status: 'Denegado' },
];