-- ============================================================
-- DATOS DE PRUEBA CORREGIDOS - SISTEMA DE GESTIÓN PENITENCIARIA (SGP)
-- ============================================================

-- ============================================================
-- MÓDULO 4: GESTIÓN DE PERSONAL (RBAC)
-- ============================================================

INSERT INTO personal (nombres, apellidos, cedula, rol, estado_activo) VALUES
('Carlos', 'Mendoza Reyes', '12345678', 'Administrador', TRUE),
('Ana', 'González Pérez', '23456789', 'JefeSeguridad', TRUE),
('Luis', 'Ramírez Soto', '34567890', 'EncargadoAdmision', TRUE),
('Marta', 'Fernández López', '45678901', 'Custodio', TRUE),
('Pedro', 'Sánchez Ruiz', '56789012', 'Custodio', TRUE),
('Laura', 'Díaz Castro', '67890123', 'Medico', TRUE),
('Jorge', 'Morales Vega', '78901234', 'Custodio', TRUE),
('Carmen', 'Ortega Flores', '89012345', 'Custodio', TRUE),
('Ricardo', 'Jiménez Mora', '90123456', 'EncargadoAdmision', TRUE),
('Patricia', 'Rojas Sandoval', '01234567', 'Medico', TRUE);

-- ============================================================
-- MÓDULO 2: PABELLONES Y CELDAS
-- ============================================================

INSERT INTO pabellon (nombre_pabellon, tipo_riesgo_permitido, capacidad_total) VALUES
('Pabellón A - Máxima Seguridad', 'Alto', 50),
('Pabellón B - Seguridad Media', 'Medio', 80),
('Pabellón C - Baja Seguridad', 'Bajo', 100),
('Pabellón D - Aislamiento', 'Alto', 20),
('Pabellón E - Rehabilitación', 'Bajo', 60);

INSERT INTO celda (id_pabellon, codigo_celda, capacidad_maxima, cantidad_actual, activa) VALUES
(1, 'A-01', 2, 2, TRUE),
(1, 'A-02', 2, 1, TRUE),
(1, 'A-03', 1, 1, TRUE),
(2, 'B-01', 4, 3, TRUE),
(2, 'B-02', 4, 2, TRUE),
(2, 'B-03', 4, 4, TRUE),
(3, 'C-01', 6, 5, TRUE),
(3, 'C-02', 6, 4, TRUE),
(3, 'C-03', 6, 6, TRUE),
(4, 'D-01', 1, 1, TRUE),
(4, 'D-02', 1, 0, TRUE),
(5, 'E-01', 8, 7, TRUE),
(5, 'E-02', 8, 8, TRUE);

-- ============================================================
-- MÓDULO 1: RECLUSOS
-- ============================================================

INSERT INTO recluso (nombres, apellidos, cedula, fecha_nacimiento, sexo, estado_riesgo, estado_recluso, fecha_ingreso, id_celda_actual, observaciones) VALUES
('Juan Carlos', 'Pérez Martínez', '11111111', '1985-03-15', 'M', 'Alto', 'Activo', '2023-01-10', 1, 'Líder de banda delincuencial'),
('Miguel Ángel', 'Rodríguez Gómez', '22222222', '1990-07-22', 'M', 'Alto', 'Activo', '2023-01-10', 1, 'Miembro activo de banda rival'),
('Roberto', 'López Sánchez', '33333333', '1988-11-05', 'M', 'Medio', 'Activo', '2023-05-20', 4, 'Robo agravado, sin antecedentes previos'),
('José Luis', 'García Fernández', '44444444', '1995-02-18', 'M', 'Medio', 'Activo', '2023-08-15', 5, 'Tráfico de estupefacientes - dosis personales'),
('Carlos Andrés', 'Torres Ramírez', '55555555', '1982-09-30', 'M', 'Alto', 'Trasladado', '2022-11-01', 3, 'Homicidio intencional, trasladado por seguridad'),
('María Elena', 'Díaz González', '66666666', '1992-06-25', 'F', 'Bajo', 'Activo', '2024-01-10', 7, 'Fraude financiero, cooperó con la justicia'),
('Ana Patricia', 'Morales Castro', '77777777', '1987-04-12', 'F', 'Bajo', 'Activo', '2023-12-01', 8, 'Estafa - primera condena'),
('Luis Fernando', 'Herrera Soto', '88888888', '1998-09-08', 'M', 'Medio', 'Libertad', '2022-06-15', NULL, 'Liberado por cumplimiento de condena'),
('Fernando José', 'Vargas Luna', '99999999', '1979-12-20', 'M', 'Alto', 'Fallecido', '2021-03-10', 10, 'Fallecido por causas naturales'),
('Andrea Carolina', 'Castro Rojas', '10101010', '2000-08-14', 'F', 'Bajo', 'En Ingreso', '2024-12-01', NULL, 'En proceso de admisión');

-- ============================================================
-- MÓDULO 1: EXPEDIENTES JUDICIALES
-- ============================================================

INSERT INTO expediente_judicial (id_recluso, numero_causa, delito_principal, delitos_secundarios, fecha_ingreso, anios_condena, meses_condena, orden_judicial_url, juez, tribunal) VALUES
(1, 'CAUSA-2023-001', 'Homicidio calificado', 'Porte ilegal de armas, asociación ilícita', '2023-01-10 09:30:00', 25, 0, '/documentos/orden_001.pdf', 'Dra. Martínez', 'Tribunal Supremo de Justicia'),
(2, 'CAUSA-2023-002', 'Secuestro', 'Lesiones graves', '2023-01-10 10:15:00', 18, 6, '/documentos/orden_002.pdf', 'Dr. Fernández', 'Tribunal Supremo de Justicia'),
(3, 'CAUSA-2023-045', 'Robo agravado', 'Daños a la propiedad', '2023-05-20 14:20:00', 8, 0, '/documentos/orden_003.pdf', 'Dra. Rodríguez', 'Tribunal Regional'),
(4, 'CAUSA-2023-089', 'Tráfico de drogas', 'Posesión de sustancias ilícitas', '2023-08-15 11:00:00', 5, 6, '/documentos/orden_004.pdf', 'Dr. Sánchez', 'Tribunal Regional'),
(5, 'CAUSA-2022-120', 'Homicidio intencional', 'Violencia doméstica', '2022-11-01 08:45:00', 30, 0, '/documentos/orden_005.pdf', 'Dra. López', 'Tribunal Supremo de Justicia'),
(6, 'CAUSA-2024-010', 'Fraude bancario', 'Suplantación de identidad, falsificación de documentos', '2024-01-10 09:00:00', 3, 0, '/documentos/orden_006.pdf', 'Dr. Gómez', 'Tribunal Regional'),
(7, 'CAUSA-2023-200', 'Estafa', 'Uso de documento falso', '2023-12-01 15:30:00', 2, 6, '/documentos/orden_007.pdf', 'Dra. Castillo', 'Tribunal Regional'),
(8, 'CAUSA-2022-050', 'Robo simple', 'Sin delitos secundarios', '2022-06-15 10:00:00', 2, 0, '/documentos/orden_008.pdf', 'Dr. Mendoza', 'Tribunal Regional'),
(9, 'CAUSA-2021-300', 'Terrorismo', 'Actos de sabotaje, conspiración', '2021-03-10 07:30:00', 40, 0, '/documentos/orden_009.pdf', 'Dra. Rivas', 'Tribunal Supremo de Justicia'),
(10, 'CAUSA-2024-150', 'Hurto', 'Reincidencia menor', '2024-12-01 13:20:00', 1, 0, '/documentos/orden_010.pdf', 'Dr. Castro', 'Tribunal Menor');

-- ============================================================
-- MÓDULO 1: BIOMETRÍA
-- ============================================================

INSERT INTO biometria (id_recluso, huella_dactilar_raw, foto_perfil_url, fecha_captura, capturado_por) VALUES
(1, decode('4869656C6C61206469676974616C2064656C207265636C75736F2031', 'hex'), '/fotos/recluso_001.jpg', '2023-01-11 09:00:00', 3),
(2, decode('4869656C6C61206469676974616C2064656C207265636C75736F2032', 'hex'), '/fotos/recluso_002.jpg', '2023-01-11 10:30:00', 3),
(3, decode('4869656C6C61206469676974616C2064656C207265636C75736F2033', 'hex'), '/fotos/recluso_003.jpg', '2023-05-21 08:45:00', 3),
(4, decode('4869656C6C61206469676974616C2064656C207265636C75736F2034', 'hex'), '/fotos/recluso_004.jpg', '2023-08-16 14:20:00', 9),
(5, decode('4869656C6C61206469676974616C2064656C207265636C75736F2035', 'hex'), '/fotos/recluso_005.jpg', '2022-11-02 11:00:00', 9),
(6, decode('4869656C6C61206469676974616C2064656C207265636C75736F2036', 'hex'), '/fotos/recluso_006.jpg', '2024-01-11 09:30:00', 3),
(7, decode('4869656C6C61206469676974616C2064656C207265636C75736F2037', 'hex'), '/fotos/recluso_007.jpg', '2023-12-02 10:15:00', 3),
(8, decode('4869656C6C61206469676974616C2064656C207265636C75736F2038', 'hex'), '/fotos/recluso_008.jpg', '2022-06-16 08:00:00', 3),
(9, decode('4869656C6C61206469676974616C2064656C207265636C75736F2039', 'hex'), '/fotos/recluso_009.jpg', '2021-03-11 09:45:00', 3),
(10, decode('4869656C6C61206469676974616C2064656C207265636C75736F203130', 'hex'), '/fotos/recluso_010.jpg', '2024-12-01 14:30:00', 9);

-- ============================================================
-- MÓDULO 2: HISTORIAL DE UBICACIONES (CORREGIDO)
-- ============================================================
-- CORRECCIÓN: Se removió el registro con id_celda NULL
-- El recluso #10 (Andrea Carolina) aún no tiene celda asignada por estar "En Ingreso"

INSERT INTO historial_ubicacion (id_recluso, id_celda, fecha_asignacion, fecha_salida, motivo_cambio, registrado_por) VALUES
(1, 1, '2023-01-11 11:00:00', NULL, 'Ingreso inicial - asignación a máxima seguridad', 3),
(2, 1, '2023-01-11 11:30:00', NULL, 'Ingreso inicial - compañero de celda por vínculo delictivo', 3),
(3, 4, '2023-05-21 09:00:00', NULL, 'Ingreso inicial - seguridad media', 9),
(4, 5, '2023-08-16 15:00:00', NULL, 'Ingreso inicial - asignación por perfil medio', 9),
(5, 2, '2022-11-02 12:00:00', '2024-10-15 08:00:00', 'Trasladado por incompatibilidad con reclusos de banda rival', 2),
(5, 3, '2024-10-15 09:00:00', NULL, 'Reubicación a celda individual por alta peligrosidad', 2),
(6, 7, '2024-01-11 10:00:00', NULL, 'Ingreso inicial - baja seguridad por cooperación judicial', 3),
(7, 8, '2023-12-02 11:00:00', NULL, 'Ingreso inicial - perfil bajo riesgo', 9),
(8, 9, '2022-06-16 09:00:00', '2024-06-15 17:00:00', 'Liberación por cumplimiento de condena', 2),
(9, 10, '2021-03-11 10:00:00', '2024-08-20 05:30:00', 'Fallecimiento del recluso', 2);

-- NOTA: El recluso #10 (Andrea Carolina) con estado "En Ingreso" NO tiene registro en historial_ubicacion aún
-- Esto es correcto porque aún no se le ha asignado una celda física

-- ============================================================
-- MÓDULO 3: VISITANTES
-- ============================================================

INSERT INTO visitante (nombres, apellidos, cedula_visitante, telefono, direccion, antecedentes_verificados, fecha_verificacion) VALUES
('María Cristina', 'Pérez de Pérez', '12121212', '+582121234567', 'Av. Principal, Quinta María, Caracas', TRUE, '2023-01-15 09:00:00'),
('José Rafael', 'Rodríguez González', '13131313', '+58212345678', 'Calle 5, Edif. Centro, Maracay', TRUE, '2023-01-15 10:30:00'),
('Carmen Teresa', 'López de López', '14141414', '+58212567890', 'Urb. Las Mercedes, Valencia', TRUE, '2023-06-01 14:00:00'),
('Sofía Elena', 'García Fernández', '15151515', '+58212678901', 'Av. Bolívar, Barquisimeto', TRUE, '2023-09-10 11:15:00'),
('Ricardo José', 'Torres Ramírez', '16161616', '+58212789012', 'Calle 10, Edif. Torres, San Cristóbal', FALSE, NULL),
('Pedro Antonio', 'Díaz Pérez', '17171717', '+58212890123', 'Urb. Santa Rosa, Puerto Ordaz', TRUE, '2024-01-15 10:00:00'),
('Luz Marina', 'Morales de Herrera', '18181818', '+58212901234', 'Av. Libertador, Maturín', TRUE, '2024-01-20 09:30:00'),
('Fernando José', 'Herrera Mora', '19191919', '+58213123456', 'Calle 3, Quinta Luz, Barcelona', TRUE, '2023-12-10 15:45:00'),
('Andrea Gabriela', 'Castro Rangel', '20202020', '+58213234567', 'Urb. El Parque, Cumaná', FALSE, NULL),
('Jorge Luis', 'Vargas González', '21212121', '+58213345678', 'Av. Principal, Mérida', TRUE, '2024-01-25 08:00:00');

-- ============================================================
-- MÓDULO 3: CARTILLAS DE VISITA
-- ============================================================

INSERT INTO cartilla_visita (id_recluso, id_visitante, parentesco_rol, estado_autorizacion, fecha_autorizacion, registrado_por) VALUES
(1, 1, 'Madre', TRUE, '2023-01-20 09:00:00', 3),
(2, 2, 'Padre', TRUE, '2023-01-20 10:00:00', 3),
(3, 3, 'Cónyuge', TRUE, '2023-06-05 14:30:00', 9),
(4, 4, 'Hermana', TRUE, '2023-09-15 11:00:00', 9),
(5, 5, 'Abogado', TRUE, '2022-11-10 15:00:00', 3),
(6, 6, 'Madre', TRUE, '2024-01-20 09:30:00', 3),
(6, 7, 'Hija', TRUE, '2024-01-20 09:35:00', 3),
(7, 8, 'Cónyuge', TRUE, '2023-12-10 16:00:00', 9),
(8, 9, 'Hermano', FALSE, '2022-06-20 10:00:00', 3),
(10, 10, 'Abogado', TRUE, '2024-12-02 08:30:00', 9);

-- ============================================================
-- MÓDULO 3: REGISTRO DE VISITAS
-- ============================================================

INSERT INTO registro_visita (id_cartilla, fecha_hora_entrada, fecha_hora_salida, pertenencias_registradas, autorizado_por, observaciones_seguridad) VALUES
(1, '2023-01-25 10:00:00', '2023-01-25 12:30:00', 'Bolso, celular (dejado en taquilla)', 4, 'Visita sin incidentes'),
(1, '2023-02-15 10:15:00', '2023-02-15 12:45:00', 'Bolso, llaves', 5, 'Visitante cumplió protocolo'),
(1, '2023-03-10 09:45:00', '2023-03-10 11:30:00', 'Sin pertenencias', 7, 'Control normal'),
(2, '2023-01-25 14:00:00', '2023-01-25 16:30:00', 'Mochila pequeña', 4, 'Visitante registrado sin novedad'),
(3, '2023-06-10 09:00:00', '2023-06-10 11:00:00', 'Cartera, documentos', 5, 'Primera visita conyugal autorizada'),
(3, '2023-07-20 10:30:00', '2023-07-20 12:00:00', 'Sin pertenencias', 7, 'Visita familiar'),
(4, '2023-09-25 11:00:00', '2023-09-25 13:15:00', 'Mochila escolar', 8, 'Visita de hermana con documentos escolares'),
(6, '2024-02-05 09:00:00', '2024-02-05 10:45:00', 'Cartera, medicamentos recetados', 4, 'Madre entregó medicamentos autorizados'),
(7, '2024-02-05 09:15:00', '2024-02-05 10:45:00', 'Sin pertenencias', 4, 'Visita de menor de edad supervisada'),
(10, '2024-12-05 14:00:00', NULL, 'Maletín de documentos legales', 5, 'Visita de abogado - revisión de expediente');

-- ============================================================
-- MÓDULO 4 (CONTINUACIÓN): TURNOS DE GUARDIA (CORREGIDO)
-- ============================================================
-- CORRECCIÓN: Se cambiaron los horarios que tenían hora_fin = '00:00:00'
-- Ahora todos cumplen con hora_fin > hora_inicio

INSERT INTO turno_guardia (id_personal, id_pabellon, fecha_guardia, hora_inicio, hora_fin, asignado_por) VALUES
(4, 1, '2024-12-15', '08:00:00', '16:00:00', 2),
(5, 1, '2024-12-15', '16:00:00', '23:59:00', 2),  -- CORREGIDO: antes era 00:00:00
(7, 1, '2024-12-15', '00:00:01', '08:00:00', 2),   -- CORREGIDO: antes era 00:00:00
(4, 2, '2024-12-16', '08:00:00', '16:00:00', 2),
(8, 2, '2024-12-16', '16:00:00', '23:59:00', 2),  -- CORREGIDO: antes era 00:00:00
(5, 3, '2024-12-16', '08:00:00', '16:00:00', 2),
(7, 3, '2024-12-16', '16:00:00', '23:59:00', 2),  -- CORREGIDO: antes era 00:00:00
(4, 4, '2024-12-17', '08:00:00', '16:00:00', 2),
(8, 5, '2024-12-17', '08:00:00', '16:00:00', 2),
(5, 2, '2024-12-17', '16:00:00', '23:59:00', 2);  -- CORREGIDO: antes era 00:00:00

-- ============================================================
-- VERIFICACIÓN DE DATOS INSERTADOS
-- ============================================================

SELECT '=== PERSONAL ===' as Tabla, COUNT(*) as Registros FROM personal
UNION ALL
SELECT '=== RECLUSOS ===', COUNT(*) FROM recluso
UNION ALL
SELECT '=== EXPEDIENTES ===', COUNT(*) FROM expediente_judicial
UNION ALL
SELECT '=== BIOMETRÍA ===', COUNT(*) FROM biometria
UNION ALL
SELECT '=== PABELLONES ===', COUNT(*) FROM pabellon
UNION ALL
SELECT '=== CELDAS ===', COUNT(*) FROM celda
UNION ALL
SELECT '=== HISTORIAL UBICACIÓN ===', COUNT(*) FROM historial_ubicacion
UNION ALL
SELECT '=== VISITANTES ===', COUNT(*) FROM visitante
UNION ALL
SELECT '=== CARTILLAS VISITA ===', COUNT(*) FROM cartilla_visita
UNION ALL
SELECT '=== REGISTRO VISITAS ===', COUNT(*) FROM registro_visita
UNION ALL
SELECT '=== TURNOS GUARDIA ===', COUNT(*) FROM turno_guardia;

-- ============================================================
-- FIN DE DATOS DE PRUEBA CORREGIDOS
-- ============================================================
