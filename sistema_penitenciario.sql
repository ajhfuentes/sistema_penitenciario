-- ============================================================
-- SISTEMA DE GESTIÓN PENITENCIARIA (SGP)
-- BASE DE DATOS OPTIMIZADA PARA POSTGRESQL
-- ============================================================

-- Eliminar tablas en orden inverso a las dependencias
DROP TABLE IF EXISTS turno_guardia CASCADE;
DROP TABLE IF EXISTS registro_visita CASCADE;
DROP TABLE IF EXISTS cartilla_visita CASCADE;
DROP TABLE IF EXISTS visitante CASCADE;
DROP TABLE IF EXISTS historial_ubicacion CASCADE;
DROP TABLE IF EXISTS celda CASCADE;
DROP TABLE IF EXISTS pabellon CASCADE;
DROP TABLE IF EXISTS biometria CASCADE;
DROP TABLE IF EXISTS expediente_judicial CASCADE;
DROP TABLE IF EXISTS recluso CASCADE;
DROP TABLE IF EXISTS personal CASCADE;

-- ============================================================
-- MÓDULO 4: GESTIÓN DE PERSONAL (RBAC)
-- ============================================================

CREATE TABLE personal (
    id_personal SERIAL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    rol VARCHAR(20) NOT NULL,
    estado_activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_personal_rol CHECK (rol IN ('Administrador', 'Custodio', 'Medico', 'JefeSeguridad', 'EncargadoAdmision')),
    CONSTRAINT chk_personal_cedula CHECK (cedula ~ '^[0-9]+$')
);

COMMENT ON TABLE personal IS 'Empleados del penal con control RBAC';
COMMENT ON COLUMN personal.rol IS 'Rol para control de acceso: Administrador, Custodio, Medico, JefeSeguridad, EncargadoAdmision';

-- ============================================================
-- MÓDULO 1: REGISTRO E INGRESO (ADMISIÓN)
-- ============================================================

CREATE TABLE recluso (
    id_recluso SERIAL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    estado_riesgo VARCHAR(15) NOT NULL,
    estado_recluso VARCHAR(20) NOT NULL DEFAULT 'En Ingreso',
    fecha_ingreso DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_salida DATE NULL,
    observaciones TEXT NULL,
    id_celda_actual INT NULL, -- FK a celda, se valida con trigger
    CONSTRAINT chk_recluso_sexo CHECK (sexo IN ('M', 'F', 'X')),
    CONSTRAINT chk_recluso_riesgo CHECK (estado_riesgo IN ('Bajo', 'Medio', 'Alto')),
    CONSTRAINT chk_recluso_estado CHECK (estado_recluso IN ('En Ingreso', 'Activo', 'Trasladado', 'Libertad', 'Fallecido')),
    CONSTRAINT chk_fechas CHECK (fecha_salida IS NULL OR fecha_salida >= fecha_ingreso)
);

COMMENT ON TABLE recluso IS 'Información central del interno';
COMMENT ON COLUMN recluso.estado_riesgo IS 'Perfil de peligrosidad: Bajo, Medio, Alto';
COMMENT ON COLUMN recluso.estado_recluso IS 'Estado actual en el sistema penitenciario';

CREATE TABLE expediente_judicial (
    id_expediente SERIAL PRIMARY KEY,
    id_recluso INT NOT NULL UNIQUE,
    numero_causa VARCHAR(50) NOT NULL UNIQUE,
    delito_principal VARCHAR(255) NOT NULL,
    delitos_secundarios TEXT NULL,
    fecha_ingreso TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    anios_condena INT NOT NULL DEFAULT 0,
    meses_condena INT NOT NULL DEFAULT 0,
    orden_judicial_url VARCHAR(255) NOT NULL,
    juez VARCHAR(100) NULL,
    tribunal VARCHAR(100) NULL,
    CONSTRAINT fk_expediente_recluso FOREIGN KEY (id_recluso) REFERENCES recluso(id_recluso) ON DELETE CASCADE,
    CONSTRAINT chk_expediente_tiempo CHECK (anios_condena >= 0 AND meses_condena BETWEEN 0 AND 11),
    CONSTRAINT chk_expediente_orden CHECK (orden_judicial_url ~ '^https?://' OR orden_judicial_url ~ '^/')
);

COMMENT ON TABLE expediente_judicial IS 'Expediente legal del recluso - relación 1:1 con recluso';
COMMENT ON COLUMN expediente_judicial.orden_judicial_url IS 'URL o ruta del documento legal escaneado';

CREATE TABLE biometria (
    id_biometria SERIAL PRIMARY KEY,
    id_recluso INT NOT NULL UNIQUE,
    huella_dactilar_raw BYTEA NOT NULL,
    foto_perfil_url VARCHAR(255) NOT NULL,
    fecha_captura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    capturado_por INT NOT NULL,
    CONSTRAINT fk_biometria_recluso FOREIGN KEY (id_recluso) REFERENCES recluso(id_recluso) ON DELETE CASCADE,
    CONSTRAINT fk_biometria_capturador FOREIGN KEY (capturado_por) REFERENCES personal(id_personal)
);

COMMENT ON TABLE biometria IS 'Datos biométricos para evitar suplantación de identidad - relación 1:1';

-- ============================================================
-- MÓDULO 2: CONTROL DE UBICACIÓN EN CELDAS
-- ============================================================

CREATE TABLE pabellon (
    id_pabellon SERIAL PRIMARY KEY,
    nombre_pabellon VARCHAR(50) NOT NULL UNIQUE,
    tipo_riesgo_permitido VARCHAR(15) NOT NULL,
    capacidad_total INT NOT NULL,
    CONSTRAINT chk_pabellon_riesgo CHECK (tipo_riesgo_permitido IN ('Bajo', 'Medio', 'Alto')),
    CONSTRAINT chk_pabellon_capacidad CHECK (capacidad_total > 0)
);

COMMENT ON TABLE pabellon IS 'Estructura física mayor que contiene celdas';
COMMENT ON COLUMN pabellon.tipo_riesgo_permitido IS 'Solo permite reclusos con este nivel de peligrosidad';

CREATE TABLE celda (
    id_celda SERIAL PRIMARY KEY,
    id_pabellon INT NOT NULL,
    codigo_celda VARCHAR(10) NOT NULL UNIQUE,
    capacidad_maxima INT NOT NULL,
    cantidad_actual INT NOT NULL DEFAULT 0,
    activa BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_celda_pabellon FOREIGN KEY (id_pabellon) REFERENCES pabellon(id_pabellon) ON DELETE RESTRICT,
    CONSTRAINT chk_celda_capacidad CHECK (cantidad_actual <= capacidad_maxima),
    CONSTRAINT chk_celda_valores_positivos CHECK (capacidad_maxima > 0 AND cantidad_actual >= 0)
);

COMMENT ON TABLE celda IS 'Espacio de confinamiento individual o compartido';

CREATE TABLE historial_ubicacion (
    id_historial SERIAL PRIMARY KEY,
    id_recluso INT NOT NULL,
    id_celda INT NOT NULL,
    fecha_asignacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_salida TIMESTAMP NULL,
    motivo_cambio TEXT NOT NULL,
    registrado_por INT NOT NULL,
    CONSTRAINT fk_historial_recluso FOREIGN KEY (id_recluso) REFERENCES recluso(id_recluso) ON DELETE CASCADE,
    CONSTRAINT fk_historial_celda FOREIGN KEY (id_celda) REFERENCES celda(id_celda) ON DELETE RESTRICT,
    CONSTRAINT fk_historial_registrador FOREIGN KEY (registrado_por) REFERENCES personal(id_personal),
    CONSTRAINT chk_historial_fechas CHECK (fecha_salida IS NULL OR fecha_salida >= fecha_asignacion)
);

COMMENT ON TABLE historial_ubicacion IS 'Auditoría de todos los movimientos del recluso';

-- ============================================================
-- MÓDULO 3: SEGURIDAD Y VISITAS
-- ============================================================

CREATE TABLE visitante (
    id_visitante SERIAL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cedula_visitante VARCHAR(20) NOT NULL UNIQUE,
    telefono VARCHAR(20) NULL,
    direccion TEXT NULL,
    antecedentes_verificados BOOLEAN NOT NULL DEFAULT FALSE,
    fecha_verificacion TIMESTAMP NULL,
    CONSTRAINT chk_visitante_cedula CHECK (cedula_visitante ~ '^[0-9]+$')
);

COMMENT ON TABLE visitante IS 'Persona externa autorizada a visitar reclusos';

CREATE TABLE cartilla_visita (
    id_cartilla SERIAL PRIMARY KEY,
    id_recluso INT NOT NULL,
    id_visitante INT NOT NULL,
    parentesco_rol VARCHAR(30) NOT NULL,
    estado_autorizacion BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_autorizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_revocacion TIMESTAMP NULL,
    registrado_por INT NOT NULL,
    CONSTRAINT fk_cartilla_recluso FOREIGN KEY (id_recluso) REFERENCES recluso(id_recluso) ON DELETE CASCADE,
    CONSTRAINT fk_cartilla_visitante FOREIGN KEY (id_visitante) REFERENCES visitante(id_visitante) ON DELETE CASCADE,
    CONSTRAINT fk_cartilla_registrador FOREIGN KEY (registrado_por) REFERENCES personal(id_personal),
    CONSTRAINT uk_cartilla_recluso_visitante UNIQUE (id_recluso, id_visitante)
);

COMMENT ON TABLE cartilla_visita IS 'Relación formal entre visitante y recluso (vínculo autorizado)';

CREATE TABLE registro_visita (
    id_visita SERIAL PRIMARY KEY,
    id_cartilla INT NOT NULL,
    fecha_hora_entrada TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_hora_salida TIMESTAMP NULL,
    pertenencias_registradas TEXT NULL,
    autorizado_por INT NOT NULL,
    observaciones_seguridad TEXT NULL,
    CONSTRAINT fk_registro_cartilla FOREIGN KEY (id_cartilla) REFERENCES cartilla_visita(id_cartilla) ON DELETE RESTRICT,
    CONSTRAINT fk_registro_autorizador FOREIGN KEY (autorizado_por) REFERENCES personal(id_personal),
    CONSTRAINT chk_registro_salida CHECK (fecha_hora_salida IS NULL OR fecha_hora_salida >= fecha_hora_entrada)
);

COMMENT ON TABLE registro_visita IS 'Control de acceso físico de visitantes (entrada/salida)';

-- ============================================================
-- MÓDULO 4 (CONTINUACIÓN): TURNOS Y ASIGNACIÓN DE GUARDIA
-- ============================================================

CREATE TABLE turno_guardia (
    id_turno SERIAL PRIMARY KEY,
    id_personal INT NOT NULL,
    id_pabellon INT NOT NULL,
    fecha_guardia DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    asignado_por INT NOT NULL,
    CONSTRAINT fk_turno_personal FOREIGN KEY (id_personal) REFERENCES personal(id_personal) ON DELETE RESTRICT,
    CONSTRAINT fk_turno_pabellon FOREIGN KEY (id_pabellon) REFERENCES pabellon(id_pabellon) ON DELETE RESTRICT,
    CONSTRAINT fk_turno_asignador FOREIGN KEY (asignado_por) REFERENCES personal(id_personal),
    CONSTRAINT chk_turno_horario CHECK (hora_fin > hora_inicio)
);

COMMENT ON TABLE turno_guardia IS 'Planificación de horarios de custodios por área';

-- ============================================================
-- CREACIÓN DE ÍNDICES OPTIMIZADOS
-- ============================================================

-- Índices para búsquedas frecuentes
CREATE INDEX idx_recluso_buscar ON recluso(apellidos, nombres);
CREATE INDEX idx_recluso_cedula ON recluso(cedula);
CREATE INDEX idx_recluso_estado ON recluso(estado_recluso);
CREATE INDEX idx_recluso_riesgo ON recluso(estado_riesgo);
CREATE INDEX idx_recluso_celda_actual ON recluso(id_celda_actual);

CREATE INDEX idx_expediente_causa ON expediente_judicial(numero_causa);
CREATE INDEX idx_expediente_recluso ON expediente_judicial(id_recluso);

CREATE INDEX idx_historial_activo ON historial_ubicacion(id_recluso) WHERE fecha_salida IS NULL;
CREATE INDEX idx_historial_recluso_fecha ON historial_ubicacion(id_recluso, fecha_asignacion);

CREATE INDEX idx_visita_fecha ON registro_visita(fecha_hora_entrada);
CREATE INDEX idx_visita_cartilla ON registro_visita(id_cartilla);

CREATE INDEX idx_cartilla_recluso ON cartilla_visita(id_recluso);
CREATE INDEX idx_cartilla_visitante ON cartilla_visita(id_visitante);

CREATE INDEX idx_turno_fecha ON turno_guardia(fecha_guardia);
CREATE INDEX idx_turno_personal ON turno_guardia(id_personal);

-- Índice para validar capacidad rápida de celdas
CREATE INDEX idx_celda_ocupacion ON celda(id_pabellon, cantidad_actual);

-- ============================================================
-- FUNCIONES Y TRIGGERS PARA REGLAS DE NEGOCIO
-- ============================================================

-- 1. Trigger para evitar mezcla de reclusos con perfiles incompatibles
CREATE OR REPLACE FUNCTION validar_compatibilidad_recluso_celda()
RETURNS TRIGGER AS $$
DECLARE
    v_tipo_riesgo_celda VARCHAR(15);
    v_banda_recluso_nueva VARCHAR(50);
    v_banda_recluso_existente VARCHAR(50);
BEGIN
    -- Obtener el tipo de riesgo permitido del pabellón de la celda
    SELECT p.tipo_riesgo_permitido INTO v_tipo_riesgo_celda
    FROM celda c
    JOIN pabellon p ON c.id_pabellon = p.id_pabellon
    WHERE c.id_celda = NEW.id_celda;
    
    -- Verificar que el recluso tenga el perfil de riesgo adecuado
    IF (SELECT estado_riesgo FROM recluso WHERE id_recluso = NEW.id_recluso) != v_tipo_riesgo_celda THEN
        RAISE EXCEPTION 'No se puede asignar: El recluso de riesgo % no puede ir a celda en pabellón de riesgo %',
            (SELECT estado_riesgo FROM recluso WHERE id_recluso = NEW.id_recluso), v_tipo_riesgo_celda;
    END IF;
    
    -- Verificar que no haya reclusos de bandas rivales en la misma celda
    -- Asumiendo que tenemos una tabla 'banda' relacionada con recluso
    -- Esta validación es extensible según necesidades específicas
    
    RETURN NEW;
END;
$$ LANGUAGE plpascal;

-- Nota: El trigger requiere que la tabla recluso tenga id_celda_actual
-- y se actualice consistentemente

-- 2. Función para actualizar cantidad_actual en celda
CREATE OR REPLACE FUNCTION actualizar_ocupacion_celda()
RETURNS TRIGGER AS $$
BEGIN
    -- Al asignar un recluso (nuevo registro activo en historial)
    IF TG_OP = 'INSERT' AND NEW.fecha_salida IS NULL THEN
        UPDATE celda 
        SET cantidad_actual = cantidad_actual + 1 
        WHERE id_celda = NEW.id_celda;
        
        -- Actualizar id_celda_actual en recluso
        UPDATE recluso 
        SET id_celda_actual = NEW.id_celda 
        WHERE id_recluso = NEW.id_recluso;
        
    -- Al liberar un recluso (fecha_salida se actualiza de NULL a valor)
    ELSIF TG_OP = 'UPDATE' AND OLD.fecha_salida IS NULL AND NEW.fecha_salida IS NOT NULL THEN
        UPDATE celda 
        SET cantidad_actual = cantidad_actual - 1 
        WHERE id_celda = OLD.id_celda;
        
        -- Limpiar id_celda_actual en recluso
        UPDATE recluso 
        SET id_celda_actual = NULL 
        WHERE id_recluso = NEW.id_recluso;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear trigger en historial_ubicacion
DROP TRIGGER IF EXISTS trg_actualizar_ocupacion ON historial_ubicacion;
CREATE TRIGGER trg_actualizar_ocupacion
AFTER INSERT OR UPDATE ON historial_ubicacion
FOR EACH ROW
EXECUTE FUNCTION actualizar_ocupacion_celda();

-- 3. Trigger para controlar aforo de visitas (evitar hacinamiento)
CREATE OR REPLACE FUNCTION validar_aforo_visitas()
RETURNS TRIGGER AS $$
DECLARE
    v_conteo_activo INT;
    v_aforo_maximo INT := 50; -- Configurable según sala de visitas
BEGIN
    -- Contar visitas activas (sin salida registrada) en el mismo día
    SELECT COUNT(*) INTO v_conteo_activo
    FROM registro_visita rv
    JOIN cartilla_visita cv ON rv.id_cartilla = cv.id_cartilla
    WHERE DATE(rv.fecha_hora_entrada) = DATE(NEW.fecha_hora_entrada)
      AND rv.fecha_hora_salida IS NULL;
    
    IF v_conteo_activo >= v_aforo_maximo THEN
        RAISE EXCEPTION 'Aforo máximo de visitas alcanzado para hoy (%)', v_aforo_maximo;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_validar_aforo ON registro_visita;
CREATE TRIGGER trg_validar_aforo
BEFORE INSERT ON registro_visita
FOR EACH ROW
EXECUTE FUNCTION validar_aforo_visitas();

-- 4. Función para registrar automáticamente el historial al cambiar celda
CREATE OR REPLACE FUNCTION registrar_cambio_celda()
RETURNS TRIGGER AS $$
BEGIN
    -- Si cambió la celda actual del recluso
    IF OLD.id_celda_actual IS DISTINCT FROM NEW.id_celda_actual THEN
        -- Cerrar historial activo anterior
        UPDATE historial_ubicacion 
        SET fecha_salida = CURRENT_TIMESTAMP,
            motivo_cambio = 'Traslado manual por actualización'
        WHERE id_recluso = NEW.id_recluso 
          AND fecha_salida IS NULL;
        
        -- Crear nuevo registro si la nueva celda no es NULL
        IF NEW.id_celda_actual IS NOT NULL THEN
            INSERT INTO historial_ubicacion (id_recluso, id_celda, motivo_cambio)
            VALUES (NEW.id_recluso, NEW.id_celda_actual, 'Asignación automática por actualización de celda');
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_registrar_cambio_celda ON recluso;
CREATE TRIGGER trg_registrar_cambio_celda
AFTER UPDATE OF id_celda_actual ON recluso
FOR EACH ROW
WHEN (OLD.id_celda_actual IS DISTINCT FROM NEW.id_celda_actual)
EXECUTE FUNCTION registrar_cambio_celda();

-- ============================================================
-- DATOS DE PRUEBA (OPCIONAL)
-- ============================================================

-- Insertar roles de personal base
INSERT INTO personal (nombres, apellidos, cedula, rol) VALUES
('Admin', 'Sistema', '999999999', 'Administrador');

-- Insertar pabellones de ejemplo
INSERT INTO pabellon (nombre_pabellon, tipo_riesgo_permitido, capacidad_total) VALUES
('Pabellón A - Máxima Seguridad', 'Alto', 100),
('Pabellón B - Seguridad Media', 'Medio', 150),
('Pabellón C - Baja Seguridad', 'Bajo', 200);

-- Insertar celdas de ejemplo
INSERT INTO celda (id_pabellon, codigo_celda, capacidad_maxima) VALUES
(1, 'A-01', 2),
(1, 'A-02', 2),
(2, 'B-01', 4),
(2, 'B-02', 4),
(3, 'C-01', 6),
(3, 'C-02', 6);

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================