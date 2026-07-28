--
-- PostgreSQL database dump
--

\restrict 1dsc1VdERXDMZEIEG6oxgjgMSuNJSwbWHKIkP9tej18mNbEig815DjfSSOy8ktV

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-07-27 21:02:41

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 259 (class 1259 OID 32946)
-- Name: boletas_excarcelacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.boletas_excarcelacion (
    id bigint NOT NULL,
    recluso_id bigint NOT NULL,
    numero_boleta character varying(50) NOT NULL,
    fecha_emision date NOT NULL,
    nombre_juez character varying(100) NOT NULL,
    hash_documento character varying(64),
    documento_pdf text,
    motivo_liberacion character varying(200) NOT NULL,
    observaciones text,
    activa boolean DEFAULT true NOT NULL,
    fecha_efectiva timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.boletas_excarcelacion OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 32945)
-- Name: boletas_excarcelacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.boletas_excarcelacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.boletas_excarcelacion_id_seq OWNER TO postgres;

--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 258
-- Name: boletas_excarcelacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.boletas_excarcelacion_id_seq OWNED BY public.boletas_excarcelacion.id;


--
-- TOC entry 225 (class 1259 OID 16785)
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16795)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 32769)
-- Name: causas_penales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.causas_penales (
    id bigint NOT NULL,
    numero_unico character varying(50) NOT NULL,
    delito_principal character varying(200) NOT NULL,
    estado_procesal character varying(255) NOT NULL,
    tribunal_origen character varying(100) NOT NULL,
    fecha_apertura date NOT NULL,
    dias_condena integer,
    observaciones text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT causas_penales_estado_procesal_check CHECK (((estado_procesal)::text = ANY ((ARRAY['En Juicio'::character varying, 'Sentenciado'::character varying, 'Apelación'::character varying, 'Unificada'::character varying])::text[])))
);


ALTER TABLE public.causas_penales OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 32768)
-- Name: causas_penales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.causas_penales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.causas_penales_id_seq OWNER TO postgres;

--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 244
-- Name: causas_penales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.causas_penales_id_seq OWNED BY public.causas_penales.id;


--
-- TOC entry 237 (class 1259 OID 16893)
-- Name: celdas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celdas (
    id bigint NOT NULL,
    pabellon_id bigint NOT NULL,
    codigo character varying(20) NOT NULL,
    capacidad_maxima integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.celdas OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16892)
-- Name: celdas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.celdas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.celdas_id_seq OWNER TO postgres;

--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 236
-- Name: celdas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.celdas_id_seq OWNED BY public.celdas.id;


--
-- TOC entry 233 (class 1259 OID 16855)
-- Name: centros_penales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.centros_penales (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    ubicacion text NOT NULL,
    capacidad_aforo integer NOT NULL,
    nivel_seguridad character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT centros_penales_nivel_seguridad_check CHECK (((nivel_seguridad)::text = ANY ((ARRAY['Mínima'::character varying, 'Media'::character varying, 'Máxima'::character varying])::text[])))
);


ALTER TABLE public.centros_penales OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16854)
-- Name: centros_penales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.centros_penales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.centros_penales_id_seq OWNER TO postgres;

--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 232
-- Name: centros_penales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.centros_penales_id_seq OWNED BY public.centros_penales.id;


--
-- TOC entry 241 (class 1259 OID 24581)
-- Name: defensores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defensores (
    id bigint NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    cedula_identidad character varying(20) NOT NULL,
    credencial_colegio character varying(50) NOT NULL,
    tipo character varying(255) NOT NULL,
    telefono character varying(20),
    email character varying(100),
    direccion text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT defensores_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['Público'::character varying, 'Privado'::character varying])::text[])))
);


ALTER TABLE public.defensores OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 24580)
-- Name: defensores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defensores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.defensores_id_seq OWNER TO postgres;

--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 240
-- Name: defensores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defensores_id_seq OWNED BY public.defensores.id;


--
-- TOC entry 249 (class 1259 OID 32814)
-- Name: expedientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expedientes (
    id bigint NOT NULL,
    recluso_id bigint NOT NULL,
    numero_expediente character varying(50) NOT NULL,
    fecha_creacion date NOT NULL,
    estado character varying(255) DEFAULT 'Activo'::character varying NOT NULL,
    observaciones text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT expedientes_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Cerrado'::character varying])::text[])))
);


ALTER TABLE public.expedientes OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 32813)
-- Name: expedientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expedientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.expedientes_id_seq OWNER TO postgres;

--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 248
-- Name: expedientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expedientes_id_seq OWNED BY public.expedientes.id;


--
-- TOC entry 231 (class 1259 OID 16836)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16835)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 257 (class 1259 OID 32921)
-- Name: faltas_disciplinarias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faltas_disciplinarias (
    id bigint NOT NULL,
    recluso_id bigint NOT NULL,
    descripcion character varying(255) NOT NULL,
    gravedad character varying(255) NOT NULL,
    fecha_falta date NOT NULL,
    sancion character varying(100),
    activa boolean DEFAULT true NOT NULL,
    observaciones text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT faltas_disciplinarias_gravedad_check CHECK (((gravedad)::text = ANY ((ARRAY['Leve'::character varying, 'Grave'::character varying])::text[])))
);


ALTER TABLE public.faltas_disciplinarias OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 32920)
-- Name: faltas_disciplinarias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faltas_disciplinarias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faltas_disciplinarias_id_seq OWNER TO postgres;

--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 256
-- Name: faltas_disciplinarias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faltas_disciplinarias_id_seq OWNED BY public.faltas_disciplinarias.id;


--
-- TOC entry 229 (class 1259 OID 16821)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16806)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16805)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 220 (class 1259 OID 16740)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16739)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 235 (class 1259 OID 16872)
-- Name: pabellones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pabellones (
    id bigint NOT NULL,
    centro_penal_id bigint NOT NULL,
    nombre character varying(50) NOT NULL,
    riesgo_permitido character varying(255) NOT NULL,
    capacidad_maxima integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT pabellones_riesgo_permitido_check CHECK (((riesgo_permitido)::text = ANY ((ARRAY['Bajo'::character varying, 'Medio'::character varying, 'Alto'::character varying])::text[])))
);


ALTER TABLE public.pabellones OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16871)
-- Name: pabellones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pabellones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pabellones_id_seq OWNER TO postgres;

--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 234
-- Name: pabellones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pabellones_id_seq OWNED BY public.pabellones.id;


--
-- TOC entry 223 (class 1259 OID 16764)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 32973)
-- Name: personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal (
    id bigint NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    cedula_identidad character varying(20) NOT NULL,
    rol character varying(255) NOT NULL,
    telefono character varying(20),
    email character varying(100),
    fecha_contratacion date NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT personal_rol_check CHECK (((rol)::text = ANY ((ARRAY['Administrador'::character varying, 'Custodio'::character varying, 'Médico'::character varying])::text[])))
);


ALTER TABLE public.personal OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 33026)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 33025)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 264
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 260 (class 1259 OID 32972)
-- Name: personal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_id_seq OWNER TO postgres;

--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 260
-- Name: personal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_id_seq OWNED BY public.personal.id;


--
-- TOC entry 247 (class 1259 OID 32790)
-- Name: recluso_causa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recluso_causa (
    id bigint NOT NULL,
    recluso_id bigint NOT NULL,
    causa_penal_id bigint NOT NULL,
    fecha_asignacion timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.recluso_causa OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 32789)
-- Name: recluso_causa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recluso_causa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recluso_causa_id_seq OWNER TO postgres;

--
-- TOC entry 5223 (class 0 OID 0)
-- Dependencies: 246
-- Name: recluso_causa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recluso_causa_id_seq OWNED BY public.recluso_causa.id;


--
-- TOC entry 243 (class 1259 OID 24604)
-- Name: recluso_defensor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recluso_defensor (
    id bigint NOT NULL,
    recluso_id bigint NOT NULL,
    defensor_id bigint NOT NULL,
    fecha_asignacion timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.recluso_defensor OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 24603)
-- Name: recluso_defensor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recluso_defensor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recluso_defensor_id_seq OWNER TO postgres;

--
-- TOC entry 5224 (class 0 OID 0)
-- Dependencies: 242
-- Name: recluso_defensor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recluso_defensor_id_seq OWNED BY public.recluso_defensor.id;


--
-- TOC entry 239 (class 1259 OID 16911)
-- Name: reclusos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reclusos (
    id bigint NOT NULL,
    celda_id bigint,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    cedula_identidad character varying(20) NOT NULL,
    nivel_riesgo character varying(255) NOT NULL,
    estado_operativo character varying(255) DEFAULT 'En Ingreso'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    fecha_nacimiento date,
    huella_dactilar text,
    foto_perfil character varying(255),
    fecha_ingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sexo character varying(1),
    CONSTRAINT reclusos_estado_operativo_check CHECK (((estado_operativo)::text = ANY ((ARRAY['En Ingreso'::character varying, 'Activo'::character varying, 'Traslado'::character varying, 'Libertad'::character varying])::text[]))),
    CONSTRAINT reclusos_nivel_riesgo_check CHECK (((nivel_riesgo)::text = ANY ((ARRAY['Bajo'::character varying, 'Medio'::character varying, 'Alto'::character varying])::text[]))),
    CONSTRAINT reclusos_sexo_check CHECK (((sexo)::text = ANY ((ARRAY['M'::character varying, 'F'::character varying])::text[])))
);


ALTER TABLE public.reclusos OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16910)
-- Name: reclusos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reclusos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reclusos_id_seq OWNER TO postgres;

--
-- TOC entry 5225 (class 0 OID 0)
-- Dependencies: 238
-- Name: reclusos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reclusos_id_seq OWNED BY public.reclusos.id;


--
-- TOC entry 255 (class 1259 OID 32883)
-- Name: redenciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redenciones (
    id bigint NOT NULL,
    recluso_id bigint NOT NULL,
    causa_penal_id bigint,
    tipo_actividad character varying(255) NOT NULL,
    horas_certificadas integer NOT NULL,
    factor_conversion numeric(5,2) DEFAULT '2'::numeric NOT NULL,
    dias_redimidos integer,
    fecha_registro date NOT NULL,
    numero_acta character varying(50) NOT NULL,
    juez_ejecucion character varying(100) NOT NULL,
    avalado boolean DEFAULT false NOT NULL,
    fecha_avali date,
    observaciones text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT redenciones_tipo_actividad_check CHECK (((tipo_actividad)::text = ANY ((ARRAY['Laboral'::character varying, 'Educativa'::character varying, 'Cultural'::character varying, 'Deportiva'::character varying])::text[])))
);


ALTER TABLE public.redenciones OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 32882)
-- Name: redenciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.redenciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.redenciones_id_seq OWNER TO postgres;

--
-- TOC entry 5226 (class 0 OID 0)
-- Dependencies: 254
-- Name: redenciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.redenciones_id_seq OWNED BY public.redenciones.id;


--
-- TOC entry 224 (class 1259 OID 16773)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 32996)
-- Name: turnos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.turnos (
    id bigint NOT NULL,
    personal_id bigint NOT NULL,
    pabellon_id bigint NOT NULL,
    fecha_turno date NOT NULL,
    hora_inicio time(0) without time zone NOT NULL,
    hora_fin time(0) without time zone NOT NULL,
    estado character varying(255) DEFAULT 'Programado'::character varying NOT NULL,
    observaciones text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT turnos_estado_check CHECK (((estado)::text = ANY ((ARRAY['Programado'::character varying, 'En Curso'::character varying, 'Completado'::character varying, 'Cancelado'::character varying])::text[])))
);


ALTER TABLE public.turnos OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 32995)
-- Name: turnos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.turnos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.turnos_id_seq OWNER TO postgres;

--
-- TOC entry 5227 (class 0 OID 0)
-- Dependencies: 262
-- Name: turnos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.turnos_id_seq OWNED BY public.turnos.id;


--
-- TOC entry 253 (class 1259 OID 32861)
-- Name: unificacion_causa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unificacion_causa (
    id bigint NOT NULL,
    unificacion_id bigint NOT NULL,
    causa_penal_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.unificacion_causa OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 32860)
-- Name: unificacion_causa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unificacion_causa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unificacion_causa_id_seq OWNER TO postgres;

--
-- TOC entry 5228 (class 0 OID 0)
-- Dependencies: 252
-- Name: unificacion_causa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unificacion_causa_id_seq OWNED BY public.unificacion_causa.id;


--
-- TOC entry 251 (class 1259 OID 32839)
-- Name: unificaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unificaciones (
    id bigint NOT NULL,
    expediente_id bigint NOT NULL,
    tipo_unificacion character varying(255) NOT NULL,
    orden_judicial character varying(100) NOT NULL,
    fecha_resolucion date NOT NULL,
    total_dias_condena integer,
    observaciones text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT unificaciones_tipo_unificacion_check CHECK (((tipo_unificacion)::text = ANY ((ARRAY['Acumulación'::character varying, 'Absorción'::character varying])::text[])))
);


ALTER TABLE public.unificaciones OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 32838)
-- Name: unificaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unificaciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unificaciones_id_seq OWNER TO postgres;

--
-- TOC entry 5229 (class 0 OID 0)
-- Dependencies: 250
-- Name: unificaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unificaciones_id_seq OWNED BY public.unificaciones.id;


--
-- TOC entry 222 (class 1259 OID 16750)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    rol character varying(255) DEFAULT 'Custodio'::character varying NOT NULL,
    CONSTRAINT users_rol_check CHECK (((rol)::text = ANY ((ARRAY['Administrador'::character varying, 'Custodio'::character varying, 'Médico'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16749)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5230 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4902 (class 2604 OID 32949)
-- Name: boletas_excarcelacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boletas_excarcelacion ALTER COLUMN id SET DEFAULT nextval('public.boletas_excarcelacion_id_seq'::regclass);


--
-- TOC entry 4890 (class 2604 OID 32772)
-- Name: causas_penales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.causas_penales ALTER COLUMN id SET DEFAULT nextval('public.causas_penales_id_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 16896)
-- Name: celdas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celdas ALTER COLUMN id SET DEFAULT nextval('public.celdas_id_seq'::regclass);


--
-- TOC entry 4881 (class 2604 OID 16858)
-- Name: centros_penales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.centros_penales ALTER COLUMN id SET DEFAULT nextval('public.centros_penales_id_seq'::regclass);


--
-- TOC entry 4887 (class 2604 OID 24584)
-- Name: defensores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defensores ALTER COLUMN id SET DEFAULT nextval('public.defensores_id_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 32817)
-- Name: expedientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expedientes ALTER COLUMN id SET DEFAULT nextval('public.expedientes_id_seq'::regclass);


--
-- TOC entry 4879 (class 2604 OID 16839)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4900 (class 2604 OID 32924)
-- Name: faltas_disciplinarias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faltas_disciplinarias ALTER COLUMN id SET DEFAULT nextval('public.faltas_disciplinarias_id_seq'::regclass);


--
-- TOC entry 4878 (class 2604 OID 16809)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4875 (class 2604 OID 16743)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4882 (class 2604 OID 16875)
-- Name: pabellones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pabellones ALTER COLUMN id SET DEFAULT nextval('public.pabellones_id_seq'::regclass);


--
-- TOC entry 4904 (class 2604 OID 32976)
-- Name: personal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal ALTER COLUMN id SET DEFAULT nextval('public.personal_id_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 33029)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 32793)
-- Name: recluso_causa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_causa ALTER COLUMN id SET DEFAULT nextval('public.recluso_causa_id_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 24607)
-- Name: recluso_defensor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_defensor ALTER COLUMN id SET DEFAULT nextval('public.recluso_defensor_id_seq'::regclass);


--
-- TOC entry 4884 (class 2604 OID 16914)
-- Name: reclusos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reclusos ALTER COLUMN id SET DEFAULT nextval('public.reclusos_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 32886)
-- Name: redenciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redenciones ALTER COLUMN id SET DEFAULT nextval('public.redenciones_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 32999)
-- Name: turnos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnos ALTER COLUMN id SET DEFAULT nextval('public.turnos_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 32864)
-- Name: unificacion_causa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unificacion_causa ALTER COLUMN id SET DEFAULT nextval('public.unificacion_causa_id_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 32842)
-- Name: unificaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unificaciones ALTER COLUMN id SET DEFAULT nextval('public.unificaciones_id_seq'::regclass);


--
-- TOC entry 4876 (class 2604 OID 16753)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5021 (class 2606 OID 32971)
-- Name: boletas_excarcelacion boletas_excarcelacion_numero_boleta_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boletas_excarcelacion
    ADD CONSTRAINT boletas_excarcelacion_numero_boleta_unique UNIQUE (numero_boleta);


--
-- TOC entry 5023 (class 2606 OID 32961)
-- Name: boletas_excarcelacion boletas_excarcelacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boletas_excarcelacion
    ADD CONSTRAINT boletas_excarcelacion_pkey PRIMARY KEY (id);


--
-- TOC entry 4938 (class 2606 OID 16804)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 4936 (class 2606 OID 16794)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 4981 (class 2606 OID 32788)
-- Name: causas_penales causas_penales_numero_unico_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.causas_penales
    ADD CONSTRAINT causas_penales_numero_unico_unique UNIQUE (numero_unico);


--
-- TOC entry 4983 (class 2606 OID 32783)
-- Name: causas_penales causas_penales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.causas_penales
    ADD CONSTRAINT causas_penales_pkey PRIMARY KEY (id);


--
-- TOC entry 4958 (class 2606 OID 16909)
-- Name: celdas celdas_pabellon_id_codigo_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celdas
    ADD CONSTRAINT celdas_pabellon_id_codigo_unique UNIQUE (pabellon_id, codigo);


--
-- TOC entry 4960 (class 2606 OID 16902)
-- Name: celdas celdas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celdas
    ADD CONSTRAINT celdas_pkey PRIMARY KEY (id);


--
-- TOC entry 4949 (class 2606 OID 16870)
-- Name: centros_penales centros_penales_nombre_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.centros_penales
    ADD CONSTRAINT centros_penales_nombre_unique UNIQUE (nombre);


--
-- TOC entry 4951 (class 2606 OID 16868)
-- Name: centros_penales centros_penales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.centros_penales
    ADD CONSTRAINT centros_penales_pkey PRIMARY KEY (id);


--
-- TOC entry 4967 (class 2606 OID 24600)
-- Name: defensores defensores_cedula_identidad_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defensores
    ADD CONSTRAINT defensores_cedula_identidad_unique UNIQUE (cedula_identidad);


--
-- TOC entry 4970 (class 2606 OID 24602)
-- Name: defensores defensores_credencial_colegio_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defensores
    ADD CONSTRAINT defensores_credencial_colegio_unique UNIQUE (credencial_colegio);


--
-- TOC entry 4972 (class 2606 OID 24595)
-- Name: defensores defensores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defensores
    ADD CONSTRAINT defensores_pkey PRIMARY KEY (id);


--
-- TOC entry 4992 (class 2606 OID 32837)
-- Name: expedientes expedientes_numero_expediente_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expedientes
    ADD CONSTRAINT expedientes_numero_expediente_unique UNIQUE (numero_expediente);


--
-- TOC entry 4994 (class 2606 OID 32828)
-- Name: expedientes expedientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expedientes
    ADD CONSTRAINT expedientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4945 (class 2606 OID 16851)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4947 (class 2606 OID 16853)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 5015 (class 2606 OID 32936)
-- Name: faltas_disciplinarias faltas_disciplinarias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faltas_disciplinarias
    ADD CONSTRAINT faltas_disciplinarias_pkey PRIMARY KEY (id);


--
-- TOC entry 4943 (class 2606 OID 16834)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 4940 (class 2606 OID 16819)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4924 (class 2606 OID 16748)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4953 (class 2606 OID 16890)
-- Name: pabellones pabellones_centro_penal_id_nombre_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pabellones
    ADD CONSTRAINT pabellones_centro_penal_id_nombre_unique UNIQUE (centro_penal_id, nombre);


--
-- TOC entry 4955 (class 2606 OID 16883)
-- Name: pabellones pabellones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pabellones
    ADD CONSTRAINT pabellones_pkey PRIMARY KEY (id);


--
-- TOC entry 4930 (class 2606 OID 16772)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 5037 (class 2606 OID 33038)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5039 (class 2606 OID 33041)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 5027 (class 2606 OID 32994)
-- Name: personal personal_cedula_identidad_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_cedula_identidad_unique UNIQUE (cedula_identidad);


--
-- TOC entry 5029 (class 2606 OID 32989)
-- Name: personal personal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY (id);


--
-- TOC entry 4986 (class 2606 OID 32800)
-- Name: recluso_causa recluso_causa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_causa
    ADD CONSTRAINT recluso_causa_pkey PRIMARY KEY (id);


--
-- TOC entry 4988 (class 2606 OID 32812)
-- Name: recluso_causa recluso_causa_recluso_id_causa_penal_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_causa
    ADD CONSTRAINT recluso_causa_recluso_id_causa_penal_id_unique UNIQUE (recluso_id, causa_penal_id);


--
-- TOC entry 4975 (class 2606 OID 24614)
-- Name: recluso_defensor recluso_defensor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_defensor
    ADD CONSTRAINT recluso_defensor_pkey PRIMARY KEY (id);


--
-- TOC entry 4977 (class 2606 OID 24626)
-- Name: recluso_defensor recluso_defensor_recluso_id_defensor_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_defensor
    ADD CONSTRAINT recluso_defensor_recluso_id_defensor_id_unique UNIQUE (recluso_id, defensor_id);


--
-- TOC entry 4962 (class 2606 OID 16934)
-- Name: reclusos reclusos_cedula_identidad_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reclusos
    ADD CONSTRAINT reclusos_cedula_identidad_unique UNIQUE (cedula_identidad);


--
-- TOC entry 4964 (class 2606 OID 16927)
-- Name: reclusos reclusos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reclusos
    ADD CONSTRAINT reclusos_pkey PRIMARY KEY (id);


--
-- TOC entry 5007 (class 2606 OID 32919)
-- Name: redenciones redenciones_numero_acta_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redenciones
    ADD CONSTRAINT redenciones_numero_acta_unique UNIQUE (numero_acta);


--
-- TOC entry 5009 (class 2606 OID 32902)
-- Name: redenciones redenciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redenciones
    ADD CONSTRAINT redenciones_pkey PRIMARY KEY (id);


--
-- TOC entry 4933 (class 2606 OID 16782)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 5034 (class 2606 OID 33012)
-- Name: turnos turnos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_pkey PRIMARY KEY (id);


--
-- TOC entry 5000 (class 2606 OID 32869)
-- Name: unificacion_causa unificacion_causa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unificacion_causa
    ADD CONSTRAINT unificacion_causa_pkey PRIMARY KEY (id);


--
-- TOC entry 5002 (class 2606 OID 32881)
-- Name: unificacion_causa unificacion_causa_unificacion_id_causa_penal_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unificacion_causa
    ADD CONSTRAINT unificacion_causa_unificacion_id_causa_penal_id_unique UNIQUE (unificacion_id, causa_penal_id);


--
-- TOC entry 4997 (class 2606 OID 32852)
-- Name: unificaciones unificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unificaciones
    ADD CONSTRAINT unificaciones_pkey PRIMARY KEY (id);


--
-- TOC entry 4926 (class 2606 OID 16763)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 4928 (class 2606 OID 16761)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5017 (class 1259 OID 32969)
-- Name: boletas_excarcelacion_activa_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX boletas_excarcelacion_activa_index ON public.boletas_excarcelacion USING btree (activa);


--
-- TOC entry 5018 (class 1259 OID 32968)
-- Name: boletas_excarcelacion_fecha_emision_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX boletas_excarcelacion_fecha_emision_index ON public.boletas_excarcelacion USING btree (fecha_emision);


--
-- TOC entry 5019 (class 1259 OID 32967)
-- Name: boletas_excarcelacion_numero_boleta_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX boletas_excarcelacion_numero_boleta_index ON public.boletas_excarcelacion USING btree (numero_boleta);


--
-- TOC entry 4978 (class 1259 OID 32785)
-- Name: causas_penales_estado_procesal_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX causas_penales_estado_procesal_index ON public.causas_penales USING btree (estado_procesal);


--
-- TOC entry 4979 (class 1259 OID 32784)
-- Name: causas_penales_numero_unico_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX causas_penales_numero_unico_index ON public.causas_penales USING btree (numero_unico);


--
-- TOC entry 4984 (class 1259 OID 32786)
-- Name: causas_penales_tribunal_origen_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX causas_penales_tribunal_origen_index ON public.causas_penales USING btree (tribunal_origen);


--
-- TOC entry 4965 (class 1259 OID 24596)
-- Name: defensores_cedula_identidad_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defensores_cedula_identidad_index ON public.defensores USING btree (cedula_identidad);


--
-- TOC entry 4968 (class 1259 OID 24597)
-- Name: defensores_credencial_colegio_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defensores_credencial_colegio_index ON public.defensores USING btree (credencial_colegio);


--
-- TOC entry 4973 (class 1259 OID 24598)
-- Name: defensores_tipo_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defensores_tipo_index ON public.defensores USING btree (tipo);


--
-- TOC entry 4989 (class 1259 OID 32835)
-- Name: expedientes_estado_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX expedientes_estado_index ON public.expedientes USING btree (estado);


--
-- TOC entry 4990 (class 1259 OID 32834)
-- Name: expedientes_numero_expediente_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX expedientes_numero_expediente_index ON public.expedientes USING btree (numero_expediente);


--
-- TOC entry 5012 (class 1259 OID 32944)
-- Name: faltas_disciplinarias_activa_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX faltas_disciplinarias_activa_index ON public.faltas_disciplinarias USING btree (activa);


--
-- TOC entry 5013 (class 1259 OID 32943)
-- Name: faltas_disciplinarias_gravedad_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX faltas_disciplinarias_gravedad_index ON public.faltas_disciplinarias USING btree (gravedad);


--
-- TOC entry 5016 (class 1259 OID 32942)
-- Name: faltas_disciplinarias_recluso_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX faltas_disciplinarias_recluso_id_index ON public.faltas_disciplinarias USING btree (recluso_id);


--
-- TOC entry 4941 (class 1259 OID 16820)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 4956 (class 1259 OID 16891)
-- Name: pabellones_riesgo_permitido_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pabellones_riesgo_permitido_index ON public.pabellones USING btree (riesgo_permitido);


--
-- TOC entry 5035 (class 1259 OID 33042)
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- TOC entry 5040 (class 1259 OID 33039)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- TOC entry 5024 (class 1259 OID 32992)
-- Name: personal_activo_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_activo_index ON public.personal USING btree (activo);


--
-- TOC entry 5025 (class 1259 OID 32990)
-- Name: personal_cedula_identidad_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_cedula_identidad_index ON public.personal USING btree (cedula_identidad);


--
-- TOC entry 5030 (class 1259 OID 32991)
-- Name: personal_rol_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_rol_index ON public.personal USING btree (rol);


--
-- TOC entry 5003 (class 1259 OID 32917)
-- Name: redenciones_avalado_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX redenciones_avalado_index ON public.redenciones USING btree (avalado);


--
-- TOC entry 5004 (class 1259 OID 32914)
-- Name: redenciones_causa_penal_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX redenciones_causa_penal_id_index ON public.redenciones USING btree (causa_penal_id);


--
-- TOC entry 5005 (class 1259 OID 32916)
-- Name: redenciones_fecha_registro_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX redenciones_fecha_registro_index ON public.redenciones USING btree (fecha_registro);


--
-- TOC entry 5010 (class 1259 OID 32913)
-- Name: redenciones_recluso_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX redenciones_recluso_id_index ON public.redenciones USING btree (recluso_id);


--
-- TOC entry 5011 (class 1259 OID 32915)
-- Name: redenciones_tipo_actividad_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX redenciones_tipo_actividad_index ON public.redenciones USING btree (tipo_actividad);


--
-- TOC entry 4931 (class 1259 OID 16784)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 4934 (class 1259 OID 16783)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 5031 (class 1259 OID 33024)
-- Name: turnos_estado_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX turnos_estado_index ON public.turnos USING btree (estado);


--
-- TOC entry 5032 (class 1259 OID 33023)
-- Name: turnos_fecha_turno_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX turnos_fecha_turno_index ON public.turnos USING btree (fecha_turno);


--
-- TOC entry 4995 (class 1259 OID 32859)
-- Name: unificaciones_orden_judicial_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX unificaciones_orden_judicial_index ON public.unificaciones USING btree (orden_judicial);


--
-- TOC entry 4998 (class 1259 OID 32858)
-- Name: unificaciones_tipo_unificacion_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX unificaciones_tipo_unificacion_index ON public.unificaciones USING btree (tipo_unificacion);


--
-- TOC entry 5055 (class 2606 OID 32962)
-- Name: boletas_excarcelacion boletas_excarcelacion_recluso_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boletas_excarcelacion
    ADD CONSTRAINT boletas_excarcelacion_recluso_id_foreign FOREIGN KEY (recluso_id) REFERENCES public.reclusos(id) ON DELETE CASCADE;


--
-- TOC entry 5042 (class 2606 OID 16903)
-- Name: celdas celdas_pabellon_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celdas
    ADD CONSTRAINT celdas_pabellon_id_foreign FOREIGN KEY (pabellon_id) REFERENCES public.pabellones(id) ON DELETE CASCADE;


--
-- TOC entry 5048 (class 2606 OID 32829)
-- Name: expedientes expedientes_recluso_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expedientes
    ADD CONSTRAINT expedientes_recluso_id_foreign FOREIGN KEY (recluso_id) REFERENCES public.reclusos(id) ON DELETE CASCADE;


--
-- TOC entry 5054 (class 2606 OID 32937)
-- Name: faltas_disciplinarias faltas_disciplinarias_recluso_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faltas_disciplinarias
    ADD CONSTRAINT faltas_disciplinarias_recluso_id_foreign FOREIGN KEY (recluso_id) REFERENCES public.reclusos(id) ON DELETE CASCADE;


--
-- TOC entry 5041 (class 2606 OID 16884)
-- Name: pabellones pabellones_centro_penal_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pabellones
    ADD CONSTRAINT pabellones_centro_penal_id_foreign FOREIGN KEY (centro_penal_id) REFERENCES public.centros_penales(id) ON DELETE CASCADE;


--
-- TOC entry 5046 (class 2606 OID 32806)
-- Name: recluso_causa recluso_causa_causa_penal_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_causa
    ADD CONSTRAINT recluso_causa_causa_penal_id_foreign FOREIGN KEY (causa_penal_id) REFERENCES public.causas_penales(id) ON DELETE CASCADE;


--
-- TOC entry 5047 (class 2606 OID 32801)
-- Name: recluso_causa recluso_causa_recluso_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_causa
    ADD CONSTRAINT recluso_causa_recluso_id_foreign FOREIGN KEY (recluso_id) REFERENCES public.reclusos(id) ON DELETE CASCADE;


--
-- TOC entry 5044 (class 2606 OID 24620)
-- Name: recluso_defensor recluso_defensor_defensor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_defensor
    ADD CONSTRAINT recluso_defensor_defensor_id_foreign FOREIGN KEY (defensor_id) REFERENCES public.defensores(id) ON DELETE CASCADE;


--
-- TOC entry 5045 (class 2606 OID 24615)
-- Name: recluso_defensor recluso_defensor_recluso_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recluso_defensor
    ADD CONSTRAINT recluso_defensor_recluso_id_foreign FOREIGN KEY (recluso_id) REFERENCES public.reclusos(id) ON DELETE CASCADE;


--
-- TOC entry 5043 (class 2606 OID 16928)
-- Name: reclusos reclusos_celda_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reclusos
    ADD CONSTRAINT reclusos_celda_id_foreign FOREIGN KEY (celda_id) REFERENCES public.celdas(id) ON DELETE SET NULL;


--
-- TOC entry 5052 (class 2606 OID 32908)
-- Name: redenciones redenciones_causa_penal_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redenciones
    ADD CONSTRAINT redenciones_causa_penal_id_foreign FOREIGN KEY (causa_penal_id) REFERENCES public.causas_penales(id) ON DELETE SET NULL;


--
-- TOC entry 5053 (class 2606 OID 32903)
-- Name: redenciones redenciones_recluso_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redenciones
    ADD CONSTRAINT redenciones_recluso_id_foreign FOREIGN KEY (recluso_id) REFERENCES public.reclusos(id) ON DELETE CASCADE;


--
-- TOC entry 5056 (class 2606 OID 33018)
-- Name: turnos turnos_pabellon_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_pabellon_id_foreign FOREIGN KEY (pabellon_id) REFERENCES public.pabellones(id) ON DELETE CASCADE;


--
-- TOC entry 5057 (class 2606 OID 33013)
-- Name: turnos turnos_personal_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_personal_id_foreign FOREIGN KEY (personal_id) REFERENCES public.personal(id) ON DELETE CASCADE;


--
-- TOC entry 5050 (class 2606 OID 32875)
-- Name: unificacion_causa unificacion_causa_causa_penal_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unificacion_causa
    ADD CONSTRAINT unificacion_causa_causa_penal_id_foreign FOREIGN KEY (causa_penal_id) REFERENCES public.causas_penales(id) ON DELETE CASCADE;


--
-- TOC entry 5051 (class 2606 OID 32870)
-- Name: unificacion_causa unificacion_causa_unificacion_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unificacion_causa
    ADD CONSTRAINT unificacion_causa_unificacion_id_foreign FOREIGN KEY (unificacion_id) REFERENCES public.unificaciones(id) ON DELETE CASCADE;


--
-- TOC entry 5049 (class 2606 OID 32853)
-- Name: unificaciones unificaciones_expediente_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unificaciones
    ADD CONSTRAINT unificaciones_expediente_id_foreign FOREIGN KEY (expediente_id) REFERENCES public.expedientes(id) ON DELETE CASCADE;


-- Completed on 2026-07-27 21:02:42

--
-- PostgreSQL database dump complete
--

\unrestrict 1dsc1VdERXDMZEIEG6oxgjgMSuNJSwbWHKIkP9tej18mNbEig815DjfSSOy8ktV

