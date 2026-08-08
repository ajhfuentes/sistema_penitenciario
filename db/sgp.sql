--
-- PostgreSQL database dump
--

\restrict auzw5fruAcCy6EJEHjJouWZ92iU3id76Ok7uH2ks3rypgw8yPVRwbKgQ9XpXQaK

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-07-21 09:27:47

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
-- TOC entry 5257 (class 0 OID 0)
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
-- TOC entry 5258 (class 0 OID 0)
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
-- TOC entry 5259 (class 0 OID 0)
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
-- TOC entry 5260 (class 0 OID 0)
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
-- TOC entry 5261 (class 0 OID 0)
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
-- TOC entry 5262 (class 0 OID 0)
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
-- TOC entry 5263 (class 0 OID 0)
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
-- TOC entry 5264 (class 0 OID 0)
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
-- TOC entry 5265 (class 0 OID 0)
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
-- TOC entry 5266 (class 0 OID 0)
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
-- TOC entry 5267 (class 0 OID 0)
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
-- TOC entry 5268 (class 0 OID 0)
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
-- TOC entry 5269 (class 0 OID 0)
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
-- TOC entry 5270 (class 0 OID 0)
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
-- TOC entry 5271 (class 0 OID 0)
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
-- TOC entry 5272 (class 0 OID 0)
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
-- TOC entry 5273 (class 0 OID 0)
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
-- TOC entry 5274 (class 0 OID 0)
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
-- TOC entry 5275 (class 0 OID 0)
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
-- TOC entry 5276 (class 0 OID 0)
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
-- TOC entry 5277 (class 0 OID 0)
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
-- TOC entry 5245 (class 0 OID 32946)
-- Dependencies: 259
-- Data for Name: boletas_excarcelacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.boletas_excarcelacion (id, recluso_id, numero_boleta, fecha_emision, nombre_juez, hash_documento, documento_pdf, motivo_liberacion, observaciones, activa, fecha_efectiva, created_at, updated_at) FROM stdin;
1	16	BOL-202607-0001	2026-07-10	Dra. María González	2982bf2cabdf9afcf46ed57e8e5cf30ac780f37dd8e9a5116b06db9ecc7ddc4b	\N	Cumplimiento de condena	\N	t	2026-07-10 15:06:01	2026-07-10 15:06:01	2026-07-10 15:06:01
2	22	BOL-202607-0002	2026-07-10	Dra. Ana Martínez	4a433abbbeacdc61774418534552ac887465cf4b83c7d2c00a76468bde18009b	\N	Redención de pena	\N	t	2026-07-10 15:06:01	2026-07-10 15:06:01	2026-07-10 15:06:01
3	25	BOL-202607-0003	2026-07-10	Dr. Carlos Rodríguez	9922fbde2b3668e465e9dfaf87172170f10488709400d39247df85f7b29b7e2c	\N	Libertad condicional	\N	t	2026-07-10 15:06:01	2026-07-10 15:06:01	2026-07-10 15:06:01
4	29	BOL-202607-0004	2026-07-10	Dr. Juan Pérez	21b72a2e033256a60aaa86fd50ee84540949ab267c7ad3f8bd70777dd41b0bca	\N	Cumplimiento de condena	\N	t	2026-07-10 15:06:01	2026-07-10 15:06:01	2026-07-10 15:06:01
5	31	BOL-202607-0005	2026-07-10	Dr. Juan Pérez	beaee459d3a1ac744e9bc5e24a3704898c4e543c52f42a651e7c7bcd678c8691	\N	Redención de pena	\N	t	2026-07-10 15:06:01	2026-07-10 15:06:01	2026-07-10 15:06:01
6	8	BOL-202607-0006	2026-07-10	Dra. Ana Martínez	eebb8131f5f033a355f7bd9443c1bc32ea324334b3590a10ef167118055131f3	\N	Beneficio judicial	\N	t	2026-07-10 15:12:13	2026-07-10 15:12:13	2026-07-10 15:12:13
7	12	BOL-202607-0007	2026-07-10	Dr. Juan Pérez	390c62e0cd3dfd8615dcb8e6c96129d22bfa9a89f6f0a61b3a851eedff22702f	\N	Cumplimiento de condena	\N	t	2026-07-10 15:12:13	2026-07-10 15:12:13	2026-07-10 15:12:13
8	17	BOL-202607-0008	2026-07-10	Dr. Juan Pérez	80075ce48a18f07a2bec6f43c470163445e0c9bb621e36530595718d0772dd16	\N	Redención de pena	\N	t	2026-07-10 15:12:13	2026-07-10 15:12:13	2026-07-10 15:12:13
9	26	BOL-202607-0009	2026-07-10	Dra. María González	3fb2861a81b4f4ac5c7bda76375fd899ab873afb196fee3c0ad6843632de2456	\N	Beneficio judicial	\N	t	2026-07-10 15:12:13	2026-07-10 15:12:13	2026-07-10 15:12:13
10	42	BOL-202607-0010	2026-07-10	Dr. Juan Pérez	8ac8a502c4ae26da1c6588e95bcb1c94f1358959e71ba4bf801f890350943d6a	\N	Beneficio judicial	\N	t	2026-07-10 15:12:13	2026-07-10 15:12:13	2026-07-10 15:12:13
11	1	BOL-TEST-0001	2026-07-10	Dr. Prueba	\N	\N	Prueba	\N	t	\N	2026-07-10 15:09:23	2026-07-10 15:09:23
12	52	BOL-202607-0012	2026-07-15	Fulano	43f17e168923ba57d6207276ab915c384b96efb7cd53604972b852a43cfc3aa5	\N	Redención de pena	\N	t	2026-07-15 15:55:21	2026-07-15 15:55:21	2026-07-15 15:55:21
13	56	BOL-202607-0013	2026-07-20	Fulano	b2dc197a10d059149b3db593e03ea17bb154fd099af6ba90e967dbb9cb4768d6	\N	Cumplimiento de condena	\N	t	2026-07-20 16:13:55	2026-07-20 16:13:55	2026-07-20 16:13:55
\.


--
-- TOC entry 5211 (class 0 OID 16785)
-- Dependencies: 225
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- TOC entry 5212 (class 0 OID 16795)
-- Dependencies: 226
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 5231 (class 0 OID 32769)
-- Dependencies: 245
-- Data for Name: causas_penales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.causas_penales (id, numero_unico, delito_principal, estado_procesal, tribunal_origen, fecha_apertura, dias_condena, observaciones, created_at, updated_at) FROM stdin;
5	EXP-2026-716	Violencia Doméstica	Apelación	Tribunal Penal 3	2026-06-30	\N	Causa de prueba generada automáticamente	2026-07-08 15:36:44	2026-07-08 15:36:44
6	EXP-2026-203	Corrupción	En Juicio	Tribunal Penal 3	2025-08-10	\N	Causa de prueba generada automáticamente	2026-07-08 15:36:44	2026-07-08 15:36:44
7	EXP-2026-118	Estafa	En Juicio	Tribunal Penal 1	2026-02-04	\N	Causa de prueba generada automáticamente	2026-07-08 15:36:44	2026-07-08 15:36:44
8	EXP-2026-650	Estafa	Apelación	Tribunal Penal 2	2026-03-02	\N	Causa de prueba generada automáticamente	2026-07-08 15:36:44	2026-07-08 15:36:44
9	EXP-2026-110	Violación	Apelación	Tribunal Penal 3	2025-09-19	\N	Causa de prueba generada automáticamente	2026-07-08 15:00:38	2026-07-08 15:00:38
10	EXP-2026-148	Tráfico de Drogas	Sentenciado	Tribunal Penal 2	2025-10-24	1013	Causa de prueba generada automáticamente	2026-07-08 15:00:38	2026-07-08 15:00:38
12	EXP-2026-195	Corrupción	En Juicio	Tribunal Penal 1	2025-09-20	\N	Causa de prueba generada automáticamente	2026-07-08 15:00:38	2026-07-08 15:00:38
13	EXP-2026-374	Robo Agravado	En Juicio	Tribunal Penal 4	2025-09-16	\N	Causa de prueba generada automáticamente	2026-07-08 15:00:38	2026-07-08 15:00:38
14	EXP-2026-211	Violencia Doméstica	En Juicio	Tribunal Penal 1	2025-08-27	\N	Causa de prueba generada automáticamente	2026-07-08 15:00:38	2026-07-08 15:00:38
15	EXP-2026-885	Violencia Doméstica	Sentenciado	Tribunal Penal 2	2026-01-15	2782	Causa de prueba generada automáticamente	2026-07-08 15:00:38	2026-07-08 15:00:38
16	EXP-2026-169	Fraude	En Juicio	Tribunal Penal 2	2026-02-21	\N	Causa de prueba generada automáticamente	2026-07-08 15:00:38	2026-07-08 15:00:38
1	EXP-2026-125	Fraude	Unificada	Tribunal Penal 5	2025-12-06	1806	Causa de prueba generada automáticamente	2026-07-08 15:36:44	2026-07-08 15:17:28
3	EXP-2026-884	Corrupción	Unificada	Tribunal Penal 2	2025-07-19	3510	Causa de prueba generada automáticamente	2026-07-08 15:36:44	2026-07-08 15:17:28
2	EXP-2026-651	Robo Agravado	Unificada	Tribunal Penal 5	2025-10-07	725	Causa de prueba generada automáticamente	2026-07-08 15:36:44	2026-07-14 13:15:39
11	EXP-2026-088	Estafa	Unificada	Tribunal Penal 5	2026-03-23	3143	Causa de prueba generada automáticamente	2026-07-08 15:00:38	2026-07-14 13:15:39
18	CP-002	Hurto de Vehiculo	Sentenciado	Tribunal Penal 55	2026-07-14	197	\N	2026-07-14 14:19:57	2026-07-14 14:20:42
19	EXP-2026-007	Hurto	En Juicio	Tribunal Penal 55	2025-02-11	\N	\N	2026-07-15 01:23:51	2026-07-15 01:23:51
4	EXP-2026-776	Hurto	Unificada	Tribunal Penal 5	2026-07-14	200	Causa de prueba generada automáticamente	2026-07-08 15:36:44	2026-07-15 02:51:06
17	CP-001	Hurto de Vehiculo	Unificada	Tribunal Penal 3	2026-07-14	200	\N	2026-07-14 14:13:16	2026-07-15 02:51:06
20	CP-010	Estafa	Sentenciado	Tribunal Penal 3	2025-07-01	700	\N	2026-07-15 04:17:01	2026-07-15 04:17:01
21	CAUSA-PENAL-PRUEBA	Hurto	Sentenciado	TRIBUNAL DE PRUEBA	2026-03-02	60	\N	2026-07-20 14:56:06	2026-07-20 14:56:06
22	Causa-Cumplimiento	Estafa	Sentenciado	TRIBUNAL DE PRUEBA	2024-01-01	730	\N	2026-07-20 16:09:51	2026-07-20 16:09:51
\.


--
-- TOC entry 5223 (class 0 OID 16893)
-- Dependencies: 237
-- Data for Name: celdas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celdas (id, pabellon_id, codigo, capacidad_maxima, created_at, updated_at) FROM stdin;
1	1	Pabellón A-C1	20	2026-07-01 05:40:10	2026-07-01 05:40:10
2	1	Pabellón A-C2	20	2026-07-01 05:40:10	2026-07-01 05:40:10
3	2	Pabellón B-C1	25	2026-07-01 05:40:10	2026-07-01 05:40:10
4	2	Pabellón B-C2	22	2026-07-01 05:40:10	2026-07-01 05:40:10
5	3	Pabellón A-C1	20	2026-07-01 05:40:10	2026-07-01 05:40:10
6	3	Pabellón A-C2	20	2026-07-01 05:40:10	2026-07-01 05:40:10
7	4	Pabellón B-C1	19	2026-07-01 05:40:10	2026-07-01 05:40:10
8	4	Pabellón B-C2	18	2026-07-01 05:40:10	2026-07-01 05:40:10
9	5	Pabellón A-C1	22	2026-07-01 05:40:10	2026-07-01 05:40:10
10	5	Pabellón A-C2	25	2026-07-01 05:40:10	2026-07-01 05:40:10
11	6	Pabellón B-C1	20	2026-07-01 05:40:10	2026-07-01 05:40:10
12	6	Pabellón B-C2	20	2026-07-01 05:40:10	2026-07-01 05:40:10
13	7	Pabellon A-C1	5	2026-07-12 17:19:15	2026-07-12 17:19:15
14	7	Pabellon A-C2	25	2026-07-12 17:20:23	2026-07-12 17:20:23
15	9	PABELLON 1-CELDA1	10	2026-07-15 23:17:20	2026-07-15 23:17:20
\.


--
-- TOC entry 5219 (class 0 OID 16855)
-- Dependencies: 233
-- Data for Name: centros_penales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.centros_penales (id, nombre, ubicacion, capacidad_aforo, nivel_seguridad, created_at, updated_at) FROM stdin;
1	Centro Penitenciario La Planta	La Planta, Caracas	1200	Media	2026-06-30 20:51:07	2026-06-30 20:51:07
2	Centro Penitenciario Maracaibo	Maracaibo, Zulia	1500	Media	2026-06-30 20:51:08	2026-06-30 20:51:08
3	Centro Penitenciario Barquisimeto	Barquisimeto, Estado Lara	900	Media	2026-06-30 21:25:28	2026-06-30 21:25:28
4	Centro Penitenciario de Cumaná	Cumaná, Estado Sucre	1500	Media	2026-07-12 15:45:13	2026-07-12 15:45:13
5	CENTRO PENAL DE PRUEBA	UPTOS	800	Mínima	2026-07-15 23:13:07	2026-07-15 23:13:07
\.


--
-- TOC entry 5227 (class 0 OID 24581)
-- Dependencies: 241
-- Data for Name: defensores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defensores (id, nombres, apellidos, cedula_identidad, credencial_colegio, tipo, telefono, email, direccion, created_at, updated_at) FROM stdin;
1	José	Díaz	V-4647143	CRED-986B79	Público	0412-3078702	josé.díaz@abogado.com	Calle 49, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
2	José	Pérez	V-4320547	CRED-9D3541	Público	0412-3972364	josé.pérez@abogado.com	Calle 26, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
3	Ana	Martínez	V-1889727	CRED-9D3C91	Público	0412-2276973	ana.martínez@abogado.com	Calle 99, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
4	Patricia	López	V-5115953	CRED-9D43CB	Privado	0412-4095489	patricia.lópez@abogado.com	Calle 49, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
5	Laura	Martínez	V-9872853	CRED-9D48E0	Público	0412-3233154	laura.martínez@abogado.com	Calle 73, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
6	Ana	Fernández	V-8958190	CRED-9D4D93	Público	0412-2913076	ana.fernández@abogado.com	Calle 6, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
7	Miguel	García	V-9991292	CRED-9D526C	Privado	0412-2215938	miguel.garcía@abogado.com	Calle 47, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
8	Ana	Martínez	V-5593813	CRED-9D5709	Privado	0412-2138520	ana.martínez@abogado.com	Calle 61, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
9	María	Martínez	V-5684281	CRED-9D5BFF	Privado	0412-4670579	maría.martínez@abogado.com	Calle 47, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
10	Laura	López	V-3176419	CRED-9D6107	Privado	0412-6540364	laura.lópez@abogado.com	Calle 31, Ciudad	2026-07-06 17:27:21	2026-07-06 17:27:21
11	JACK	REACHER	100	CRD-1	Privado	04147842589	jack@gmail.com	USA	2026-07-15 23:20:02	2026-07-15 23:20:02
\.


--
-- TOC entry 5235 (class 0 OID 32814)
-- Dependencies: 249
-- Data for Name: expedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expedientes (id, recluso_id, numero_expediente, fecha_creacion, estado, observaciones, created_at, updated_at) FROM stdin;
1	1	EXP-2026-0001	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
2	2	EXP-2026-0002	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
3	3	EXP-2026-0003	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
4	4	EXP-2026-0004	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
5	5	EXP-2026-0005	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
6	6	EXP-2026-0006	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
7	7	EXP-2026-0007	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
8	8	EXP-2026-0008	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
9	9	EXP-2026-0009	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
10	10	EXP-2026-0010	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
11	11	EXP-2026-0011	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
12	12	EXP-2026-0012	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
13	13	EXP-2026-0013	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
14	14	EXP-2026-0014	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
15	15	EXP-2026-0015	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
16	16	EXP-2026-0016	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
17	17	EXP-2026-0017	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
18	18	EXP-2026-0018	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
19	19	EXP-2026-0019	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
20	20	EXP-2026-0020	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
21	21	EXP-2026-0021	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
22	22	EXP-2026-0022	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
23	23	EXP-2026-0023	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
24	24	EXP-2026-0024	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
25	25	EXP-2026-0025	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
26	26	EXP-2026-0026	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
27	27	EXP-2026-0027	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
28	28	EXP-2026-0028	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
29	29	EXP-2026-0029	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
30	30	EXP-2026-0030	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
31	31	EXP-2026-0031	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
32	32	EXP-2026-0032	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
33	33	EXP-2026-0033	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
34	34	EXP-2026-0034	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
35	35	EXP-2026-0035	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
36	36	EXP-2026-0036	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
37	37	EXP-2026-0037	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
38	38	EXP-2026-0038	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
39	39	EXP-2026-0039	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
40	40	EXP-2026-0040	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
41	41	EXP-2026-0041	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
42	42	EXP-2026-0042	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
43	43	EXP-2026-0043	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
44	44	EXP-2026-0044	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
45	45	EXP-2026-0045	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
46	46	EXP-2026-0046	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:18	2026-07-08 15:17:18
47	47	EXP-2026-0047	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:19	2026-07-08 15:17:19
48	48	EXP-2026-0048	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:19	2026-07-08 15:17:19
49	49	EXP-2026-0049	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:19	2026-07-08 15:17:19
50	50	EXP-2026-0050	2026-07-08	Activo	Expediente creado automáticamente	2026-07-08 15:17:19	2026-07-08 15:17:19
51	31	EXP-2026-0051	2026-07-14	Activo	Expediente creado automáticamente durante la unificación de condenas	2026-07-14 13:15:38	2026-07-14 13:15:38
52	51	EXP-2026-0052	2026-07-15	Activo	Expediente creado automáticamente durante la unificación de condenas	2026-07-15 02:51:05	2026-07-15 02:51:05
\.


--
-- TOC entry 5217 (class 0 OID 16836)
-- Dependencies: 231
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 5243 (class 0 OID 32921)
-- Dependencies: 257
-- Data for Name: faltas_disciplinarias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faltas_disciplinarias (id, recluso_id, descripcion, gravedad, fecha_falta, sancion, activa, observaciones, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5215 (class 0 OID 16821)
-- Dependencies: 229
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 5214 (class 0 OID 16806)
-- Dependencies: 228
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 5206 (class 0 OID 16740)
-- Dependencies: 220
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2026_06_30_173104_create_centros_penales_table	1
5	2026_06_30_194621_create_pabellones_table	1
6	2026_06_30_194938_create_celdas_table	1
7	2026_06_30_195058_create_reclusos_table	1
8	2026_07_05_235513_create_reclusos_table	2
9	2026_07_06_171601_create_defensores_table	3
10	2026_07_06_171732_create_recluso_defensor_table	4
11	2026_07_08_152556_create_causas_penales_table	5
12	2026_07_08_152746_create_recluso_causa_table	6
13	2026_07_08_150521_create_expedientes_table	7
14	2026_07_08_150728_create_unificaciones_table	8
15	2026_07_08_150820_create_unificacion_causa_table	9
16	2026_07_09_141743_create_redenciones_table	10
17	2026_07_09_142231_create_faltas_disciplinarias_table	11
18	2026_07_10_145517_create_boletas_excarcelacion_table	12
19	2026_07_10_153659_create_personal_table	13
20	2026_07_10_144558_create_turnos_table	14
21	2026_07_10_151346_create_personal_access_tokens_table	15
22	2026_07_10_151850_add_rol_to_users_table	16
\.


--
-- TOC entry 5221 (class 0 OID 16872)
-- Dependencies: 235
-- Data for Name: pabellones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pabellones (id, centro_penal_id, nombre, riesgo_permitido, capacidad_maxima, created_at, updated_at) FROM stdin;
1	1	Pabellón A	Medio	44	2026-07-01 01:53:51	2026-07-01 01:53:51
2	1	Pabellón B	Bajo	50	2026-07-01 01:53:51	2026-07-01 01:53:51
3	2	Pabellón A	Medio	52	2026-07-01 01:53:51	2026-07-01 01:53:51
4	2	Pabellón B	Bajo	34	2026-07-01 01:53:51	2026-07-01 01:53:51
5	3	Pabellón A	Medio	56	2026-07-01 01:53:51	2026-07-01 01:53:51
6	3	Pabellón B	Bajo	32	2026-07-01 01:53:51	2026-07-01 01:53:51
8	4	Pabellon B	Medio	500	2026-07-12 16:57:28	2026-07-12 16:57:28
7	4	Pabellon A	Bajo	900	2026-07-12 16:56:53	2026-07-12 16:58:32
9	5	PABELLON 1	Bajo	400	2026-07-15 23:13:45	2026-07-15 23:13:45
10	5	PABELLON 2	Bajo	400	2026-07-15 23:14:03	2026-07-15 23:14:03
\.


--
-- TOC entry 5209 (class 0 OID 16764)
-- Dependencies: 223
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 5247 (class 0 OID 32973)
-- Dependencies: 261
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal (id, nombres, apellidos, cedula_identidad, rol, telefono, email, fecha_contratacion, activo, created_at, updated_at) FROM stdin;
1	Miguel	Fernández	V-5595863	Médico	0412-1801455	miguel.fernández@sgp.gob.ve	2017-07-10	f	2026-07-10 15:00:00	2026-07-10 15:00:00
2	Miguel	López	V-6612215	Médico	0412-7969914	miguel.lópez@sgp.gob.ve	2017-07-10	t	2026-07-10 15:00:00	2026-07-10 15:00:00
3	José	López	V-8389981	Médico	0412-9714503	josé.lópez@sgp.gob.ve	2016-07-10	t	2026-07-10 15:00:00	2026-07-10 15:00:00
4	Patricia	López	V-7359331	Médico	0412-2338154	patricia.lópez@sgp.gob.ve	2018-07-10	f	2026-07-10 15:00:00	2026-07-10 15:00:00
5	Carlos	Martínez	V-3420048	Médico	0412-8305113	carlos.martínez@sgp.gob.ve	2018-07-10	f	2026-07-10 15:00:00	2026-07-10 15:00:00
6	Patricia	López	V-1623179	Administrador	0412-2931031	patricia.lópez@sgp.gob.ve	2019-07-10	t	2026-07-10 15:00:00	2026-07-10 15:00:00
7	Miguel	Díaz	V-4923638	Custodio	0412-8459590	miguel.díaz@sgp.gob.ve	2016-07-10	t	2026-07-10 15:00:00	2026-07-10 15:00:00
8	José	Díaz	V-3444811	Administrador	0412-4206381	josé.díaz@sgp.gob.ve	2025-07-10	t	2026-07-10 15:00:00	2026-07-10 15:00:00
9	Ana	González	V-3762363	Médico	0412-5306095	ana.gonzález@sgp.gob.ve	2017-07-10	f	2026-07-10 15:00:00	2026-07-10 15:00:00
10	Luis	García	V-8044471	Administrador	0412-5112521	luis.garcía@sgp.gob.ve	2025-07-10	t	2026-07-10 15:00:00	2026-07-10 15:00:00
\.


--
-- TOC entry 5251 (class 0 OID 33026)
-- Dependencies: 265
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
1	App\\Models\\User	1	auth_token	a6a68bd379bdd4019093a848d9e75d40de749c14ed823c26c229fd08059ea999	["*"]	\N	\N	2026-07-11 17:17:19	2026-07-11 17:17:19
2	App\\Models\\User	1	auth_token	bcc33507c22dfa8c04343cad25deea52786f13c6174a425510ab53b1b6c94c03	["*"]	\N	\N	2026-07-11 17:18:48	2026-07-11 17:18:48
3	App\\Models\\User	1	auth_token	29dfc858077f5b224063710c4e62da47eeddc5df2f852b7592761036a3e48d6e	["*"]	\N	\N	2026-07-12 05:14:30	2026-07-12 05:14:30
4	App\\Models\\User	1	auth_token	f72380e7cee23b7465756e882c476cb208c5e18bca5851524a2674ed5d60fb3a	["*"]	\N	\N	2026-07-12 05:15:09	2026-07-12 05:15:09
5	App\\Models\\User	1	auth_token	2469ab0999a17da8be3b8066b5b70ff46061c83657f4c490e5c2827d81329de3	["*"]	\N	\N	2026-07-12 05:17:38	2026-07-12 05:17:38
6	App\\Models\\User	1	auth_token	092c10fc52cdbd03a3b24b4f26df2be815217117b3f1fcc2c636aef5f5a34db0	["*"]	\N	\N	2026-07-12 05:30:13	2026-07-12 05:30:13
7	App\\Models\\User	1	auth_token	9473a81488e0e0a014995920b25a1a6db786923e21dd7630280725d9c34eeb3e	["*"]	\N	\N	2026-07-12 15:41:25	2026-07-12 15:41:25
8	App\\Models\\User	1	auth_token	ab6e7e9816def57631f27dd0d578b6ca4f7ac70f6e8f21faf68e8e3fd925c999	["*"]	\N	\N	2026-07-12 15:43:52	2026-07-12 15:43:52
9	App\\Models\\User	1	auth_token	05273aa5272cf2d98c97b6ae807688f3a4c76b2f7fca3d6797579f0a876aa631	["*"]	\N	\N	2026-07-12 16:01:10	2026-07-12 16:01:10
10	App\\Models\\User	1	auth_token	3296b5260cecc30d80d68d12a96121e431be12f7da008702e9e490692716157f	["*"]	\N	\N	2026-07-12 16:10:36	2026-07-12 16:10:36
11	App\\Models\\User	1	auth_token	b1228bfe0217f9889aaf251c0d34ac3735b11b4f48fbb93ed367353a664f3a42	["*"]	\N	\N	2026-07-12 16:55:35	2026-07-12 16:55:35
12	App\\Models\\User	1	auth_token	6b501b97211d1de1712c5970083c4d1f14939b174e5779822e3b817552ff86eb	["*"]	\N	\N	2026-07-12 17:05:15	2026-07-12 17:05:15
13	App\\Models\\User	1	auth_token	44f1253f4fe642e0b1d39cd79025cfd89147e3eae09adb4b27d05a80fd9c7a13	["*"]	\N	\N	2026-07-12 16:31:57	2026-07-12 16:31:57
14	App\\Models\\User	1	auth_token	34dd650e2e1f2fc92005131bb6e9378c3f71f2ac122ee0270e62e3154fc671ce	["*"]	\N	\N	2026-07-12 22:24:48	2026-07-12 22:24:48
15	App\\Models\\User	1	auth_token	eb37b5e9b32e9e42c71b54d6bcd857eba3644a6b569d728ad38e799bdb6700ec	["*"]	\N	\N	2026-07-12 22:37:22	2026-07-12 22:37:22
16	App\\Models\\User	1	auth_token	6df38e8c5e2edd0e28054ab2f6cca3c61929f0784cd982a89cb1af203faf8782	["*"]	\N	\N	2026-07-14 12:56:48	2026-07-14 12:56:48
17	App\\Models\\User	1	auth_token	8d1951091b7c432a5e3711d94acf0ef2d7144ae1a9558e6c39516206c4703a73	["*"]	\N	\N	2026-07-15 01:02:53	2026-07-15 01:02:53
18	App\\Models\\User	1	auth_token	c237311163653254c7bf723d14ec403719d07042aa7d1df5fb0ee16cb511f4cb	["*"]	\N	\N	2026-07-15 02:13:52	2026-07-15 02:13:52
29	App\\Models\\User	3	auth_token	ed90da8aeefb02209d6dfd5e2743fda41eda7fd0b5a6c549f6d315fe82872e58	["*"]	\N	\N	2026-07-16 02:31:06	2026-07-16 02:31:06
19	App\\Models\\User	1	auth_token	4f5dd96baee3a082b068f5edd89006df83173093a0c410d8541522c881278088	["*"]	2026-07-15 22:43:23	\N	2026-07-15 13:43:08	2026-07-15 22:43:23
20	App\\Models\\User	1	auth_token	512fe83ce0e816034533b2142d12de1121d6a5a2fd2da61c32e2ca037c851517	["*"]	\N	\N	2026-07-15 22:44:07	2026-07-15 22:44:07
28	App\\Models\\User	1	auth_token	546a83489f8af0ebab6f88fc84705cb619b6619767a519afb817c8e59091b83a	["*"]	2026-07-16 02:31:06	\N	2026-07-16 02:29:49	2026-07-16 02:31:06
21	App\\Models\\User	1	auth_token	bdc3785ddf314730ee21382bf50863e2092fa2cbb07e7c0ef20a56af62398702	["*"]	2026-07-15 22:45:05	\N	2026-07-15 22:44:59	2026-07-15 22:45:05
22	App\\Models\\User	1	auth_token	58ea9b1fcf07448db9c95ae8058e7c24967e6070e7d983d0e08c6b13309ab46d	["*"]	\N	\N	2026-07-15 22:47:12	2026-07-15 22:47:12
30	App\\Models\\User	3	auth_token	51bbd9c622527ad18ac9ce6aee8821209d6b404086d1e86d13d31502dbcf6837	["*"]	\N	\N	2026-07-16 02:31:24	2026-07-16 02:31:24
31	App\\Models\\User	1	auth_token	ef4b8c96e6f1965e86b4c02217437eb603e41607493774d50ffe746f7aaad104	["*"]	\N	\N	2026-07-16 02:32:29	2026-07-16 02:32:29
35	App\\Models\\User	2	auth_token	b65cb5bfe80e805e2aa0d6e6c93ce38834281ec40b6d2f1fa88257697509a51d	["*"]	2026-07-16 02:59:43	\N	2026-07-16 02:53:46	2026-07-16 02:59:43
24	App\\Models\\User	2	auth_token	506401e5f2c1a67f59e3646f922b83ea1806a869802bb6f4600084d979b296ee	["*"]	\N	\N	2026-07-15 23:09:16	2026-07-15 23:09:16
23	App\\Models\\User	1	auth_token	068d728eb511d158ab53241804b4f2b7d35f838fd3b66d43e6a2d0758274920d	["*"]	2026-07-15 23:09:17	\N	2026-07-15 22:54:22	2026-07-15 23:09:17
32	App\\Models\\User	2	auth_token	6c10ded09a65863903d14ed548b2dba9892b5631682f57aa6a7957f5ee064e0b	["*"]	2026-07-16 02:34:44	\N	2026-07-16 02:34:03	2026-07-16 02:34:44
25	App\\Models\\User	2	auth_token	723a51b85607af6b883babb0a4c430414133963bb1ed07a98b6b99b14eb19424	["*"]	2026-07-15 23:20:53	\N	2026-07-15 23:09:49	2026-07-15 23:20:53
26	App\\Models\\User	2	auth_token	5a701a3fd5450b506ddf54d0d8007d09a35beb5bedd91ef0f0597044ee258979	["*"]	2026-07-16 02:10:38	\N	2026-07-16 02:07:31	2026-07-16 02:10:38
33	App\\Models\\User	3	auth_token	b49f36b1aca2b8a4a7f460854a75fc04e1b642e578776322f441d21e2d1ad7d6	["*"]	\N	\N	2026-07-16 02:42:36	2026-07-16 02:42:36
27	App\\Models\\User	2	auth_token	7932237146388aa0282e537bde9eba66208bc458935092daf36b7f44a9df3cc3	["*"]	2026-07-16 02:27:32	\N	2026-07-16 02:17:12	2026-07-16 02:27:32
34	App\\Models\\User	3	auth_token	f34ffbaa2240a79ad9fedc149c9959377d8cc6cbdf820cd1b36cf515be13982a	["*"]	\N	\N	2026-07-16 02:53:26	2026-07-16 02:53:26
37	App\\Models\\User	1	auth_token	eb7ce40030764887f85b57497320a55b984f012efa051f7fb19d5c0084f48cbc	["*"]	2026-07-20 14:42:25	\N	2026-07-20 13:53:25	2026-07-20 14:42:25
38	App\\Models\\User	1	auth_token	71ad02c55e273a9e6f3c96373ff2e33d3ada872174045ea50a18b301687ca0f8	["*"]	2026-07-20 16:14:04	\N	2026-07-20 14:45:35	2026-07-20 16:14:04
36	App\\Models\\User	1	auth_token	7237f043892250362c9a387f18a8fda023ef0e77891ce9dfdcb11c2abf9d8c40	["*"]	2026-07-16 06:28:06	\N	2026-07-16 03:33:58	2026-07-16 06:28:06
\.


--
-- TOC entry 5233 (class 0 OID 32790)
-- Dependencies: 247
-- Data for Name: recluso_causa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recluso_causa (id, recluso_id, causa_penal_id, fecha_asignacion, created_at, updated_at) FROM stdin;
1	1	3	2026-07-08 15:36:59	2026-07-08 15:36:59	2026-07-08 15:36:59
2	1	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
3	2	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
4	2	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
5	3	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
6	3	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
7	4	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
8	5	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
9	6	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
10	7	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
11	8	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
12	9	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
13	10	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
14	10	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
15	11	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
16	12	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
17	13	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
18	14	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
19	15	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
20	16	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
21	16	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
22	17	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
23	17	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
24	18	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
25	18	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
26	19	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
27	19	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
28	20	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
29	20	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
30	21	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
31	22	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
32	23	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
33	23	5	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
34	24	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
35	24	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
36	25	1	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
37	25	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
38	26	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
39	26	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
40	27	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
41	27	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
42	28	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
43	29	5	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
44	30	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
45	30	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
46	31	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
47	31	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
48	32	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
49	33	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
50	34	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
51	35	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
52	36	1	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
53	36	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
54	37	2	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
55	38	5	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
56	38	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
57	39	1	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
58	39	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
59	40	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
60	40	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
61	41	5	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
62	41	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
63	42	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
64	42	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
65	43	1	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
66	43	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
67	44	4	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
68	44	6	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
69	45	5	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
70	46	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
71	46	7	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
72	47	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
73	48	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
74	49	5	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
75	50	3	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
76	50	8	2026-07-08 15:37:00	2026-07-08 15:37:00	2026-07-08 15:37:00
77	1	7	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
78	2	9	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
79	3	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
80	3	15	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
81	4	2	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
82	4	10	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
83	5	10	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
84	5	11	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
85	6	8	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
86	6	10	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
87	7	5	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
88	7	14	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
89	8	10	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
90	9	6	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
91	9	16	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
92	10	14	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
93	11	10	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
94	12	9	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
95	13	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
96	13	3	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
97	14	12	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
98	15	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
99	15	2	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
100	16	3	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
101	17	5	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
102	17	16	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
103	18	9	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
104	19	5	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
105	20	9	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
106	20	12	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
107	21	3	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
108	21	14	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
109	22	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
110	22	8	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
111	23	6	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
112	23	16	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
113	26	3	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
114	26	13	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
115	27	11	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
116	28	14	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
117	29	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
118	30	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
119	31	9	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
120	31	11	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
121	32	9	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
122	33	8	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
123	33	10	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
124	34	10	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
125	34	13	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
126	35	11	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
127	36	11	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
128	37	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
129	37	12	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
130	38	8	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
131	39	2	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
132	39	3	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
133	40	3	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
134	41	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
135	42	5	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
136	43	13	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
137	44	9	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
138	45	13	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
139	46	4	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
140	47	11	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
141	48	1	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
142	50	2	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
143	50	4	2026-07-08 15:00:41	2026-07-08 15:00:41	2026-07-08 15:00:41
144	51	4	2026-07-12 22:55:13	2026-07-12 22:55:13	2026-07-12 22:55:13
145	51	14	2026-07-12 22:58:50	2026-07-12 22:58:50	2026-07-12 22:58:50
146	51	17	2026-07-14 14:13:36	2026-07-14 14:13:36	2026-07-14 14:13:36
147	51	18	2026-07-14 14:20:14	2026-07-14 14:20:14	2026-07-14 14:20:14
148	52	20	2026-07-15 04:18:57	2026-07-15 04:18:57	2026-07-15 04:18:57
149	54	21	2026-07-20 14:59:23	2026-07-20 14:59:23	2026-07-20 14:59:23
150	56	22	2026-07-20 16:10:06	2026-07-20 16:10:06	2026-07-20 16:10:06
\.


--
-- TOC entry 5229 (class 0 OID 24604)
-- Dependencies: 243
-- Data for Name: recluso_defensor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recluso_defensor (id, recluso_id, defensor_id, fecha_asignacion, created_at, updated_at) FROM stdin;
1	51	1	2026-07-12 22:47:02	2026-07-12 22:47:02	2026-07-12 22:47:02
2	51	6	2026-07-12 22:58:50	2026-07-12 22:58:50	2026-07-12 22:58:50
3	52	7	2026-07-15 04:15:17	2026-07-15 04:15:17	2026-07-15 04:15:17
4	54	11	2026-07-20 14:57:29	2026-07-20 14:57:29	2026-07-20 14:57:29
\.


--
-- TOC entry 5225 (class 0 OID 16911)
-- Dependencies: 239
-- Data for Name: reclusos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reclusos (id, celda_id, nombres, apellidos, cedula_identidad, nivel_riesgo, estado_operativo, created_at, updated_at, fecha_nacimiento, huella_dactilar, foto_perfil, fecha_ingreso, sexo) FROM stdin;
1	1	Carlos	Martínez	V-4801337	Medio	En Ingreso	2026-07-06 00:11:58	2026-07-06 00:11:58	1982-07-06	\N	\N	2026-07-06 00:11:58	M
2	1	María	López	V-5804153	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	2007-07-06	\N	\N	2026-07-06 00:11:59	M
3	1	Luis	García	V-2018386	Bajo	En Ingreso	2026-07-06 00:11:59	2026-07-06 00:11:59	1987-07-06	\N	\N	2026-07-06 00:11:59	F
4	2	Juan	González	V-5798492	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	2004-07-06	\N	\N	2026-07-06 00:11:59	M
5	3	Pedro	Martínez	V-3313996	Bajo	En Ingreso	2026-07-06 00:11:59	2026-07-06 00:11:59	1992-07-06	\N	\N	2026-07-06 00:11:59	F
6	3	Lucía	Rodríguez	V-3761353	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	1986-07-06	\N	\N	2026-07-06 00:11:59	F
7	4	Martha	García	V-2416922	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	1983-07-06	\N	\N	2026-07-06 00:11:59	F
9	5	Juan	López	V-5085769	Bajo	En Ingreso	2026-07-06 00:11:59	2026-07-06 00:11:59	1969-07-06	\N	\N	2026-07-06 00:11:59	M
10	5	Luis	Sánchez	V-8154373	Medio	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	2004-07-06	\N	\N	2026-07-06 00:11:59	F
11	5	Ana	Rodríguez	V-4802429	Medio	En Ingreso	2026-07-06 00:11:59	2026-07-06 00:11:59	2006-07-06	\N	\N	2026-07-06 00:11:59	F
13	7	Carmen	González	V-4230632	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	1969-07-06	\N	\N	2026-07-06 00:11:59	M
14	7	Ana	García	V-7912817	Bajo	En Ingreso	2026-07-06 00:11:59	2026-07-06 00:11:59	1986-07-06	\N	\N	2026-07-06 00:11:59	F
15	7	Miguel	González	V-5380924	Bajo	En Ingreso	2026-07-06 00:11:59	2026-07-06 00:11:59	1979-07-06	\N	\N	2026-07-06 00:11:59	F
18	9	Juan	Rodríguez	V-6047046	Bajo	En Ingreso	2026-07-06 00:11:59	2026-07-06 00:11:59	1983-07-06	\N	\N	2026-07-06 00:11:59	M
19	9	Juan	Fernández	V-9986686	Medio	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	1972-07-06	\N	\N	2026-07-06 00:11:59	F
20	9	Luis	Pérez	V-7364552	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	1977-07-06	\N	\N	2026-07-06 00:11:59	F
21	10	Ana	González	V-7880433	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	1985-07-06	\N	\N	2026-07-06 00:11:59	F
23	12	Juan	González	V-1595277	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	2004-07-06	\N	\N	2026-07-06 00:11:59	M
24	12	Pedro	López	V-8674551	Bajo	Activo	2026-07-06 00:11:59	2026-07-06 00:11:59	1976-07-06	\N	\N	2026-07-06 00:11:59	F
27	1	Juan	Rodríguez	V-1890204	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	2000-07-06	\N	\N	2026-07-06 00:13:33	F
28	1	Carmen	Sánchez	V-9751554	Medio	En Ingreso	2026-07-06 00:13:33	2026-07-06 00:13:33	1990-07-06	\N	\N	2026-07-06 00:13:33	F
30	2	Martha	López	V-8271966	Medio	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	1995-07-06	\N	\N	2026-07-06 00:13:33	F
32	3	Ana	Rodríguez	V-9259627	Bajo	En Ingreso	2026-07-06 00:13:33	2026-07-06 00:13:33	2000-07-06	\N	\N	2026-07-06 00:13:33	F
33	4	María	González	V-4394205	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	2004-07-06	\N	\N	2026-07-06 00:13:33	M
34	5	Carmen	Pérez	V-9662384	Medio	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	1994-07-06	\N	\N	2026-07-06 00:13:33	F
35	5	María	Sánchez	V-3968768	Medio	En Ingreso	2026-07-06 00:13:33	2026-07-06 00:13:33	1998-07-06	\N	\N	2026-07-06 00:13:33	M
36	6	Martha	Sánchez	V-3417456	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	1993-07-06	\N	\N	2026-07-06 00:13:33	M
37	6	Martha	Pérez	V-7144020	Medio	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	2004-07-06	\N	\N	2026-07-06 00:13:33	F
38	7	María	Fernández	V-9212985	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	2005-07-06	\N	\N	2026-07-06 00:13:33	M
39	7	Lucía	Sánchez	V-5529361	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	1988-07-06	\N	\N	2026-07-06 00:13:33	F
40	8	Pedro	González	V-2409129	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	2006-07-06	\N	\N	2026-07-06 00:13:33	F
41	9	Martha	Martínez	V-8203303	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	2004-07-06	\N	\N	2026-07-06 00:13:33	M
43	9	Luis	Martínez	V-6302465	Bajo	En Ingreso	2026-07-06 00:13:33	2026-07-06 00:13:33	1989-07-06	\N	\N	2026-07-06 00:13:33	F
44	10	Pedro	Sánchez	V-3174802	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	1994-07-06	\N	\N	2026-07-06 00:13:33	F
45	10	Miguel	García	V-8333236	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	2008-07-06	\N	\N	2026-07-06 00:13:33	M
46	10	Juan	Rodríguez	V-4215002	Medio	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	1975-07-06	\N	\N	2026-07-06 00:13:33	M
47	11	Carmen	Fernández	V-6700517	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	2005-07-06	\N	\N	2026-07-06 00:13:33	F
48	12	Juan	Fernández	V-7557497	Bajo	En Ingreso	2026-07-06 00:13:33	2026-07-06 00:13:33	1975-07-06	\N	\N	2026-07-06 00:13:33	F
49	12	Pedro	Fernández	V-6890083	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	1969-07-06	\N	\N	2026-07-06 00:13:33	M
50	12	Juan	López	V-4202135	Bajo	Activo	2026-07-06 00:13:33	2026-07-06 00:13:33	1989-07-06	\N	\N	2026-07-06 00:13:33	F
16	8	Ana	Martínez	V-1642117	Bajo	Libertad	2026-07-06 00:11:59	2026-07-10 15:06:01	1993-07-06	\N	\N	2026-07-06 00:11:59	M
22	11	Juan	González	V-9389983	Bajo	Libertad	2026-07-06 00:11:59	2026-07-10 15:06:01	1981-07-06	\N	\N	2026-07-06 00:11:59	M
25	12	Miguel	Martínez	V-8883720	Bajo	Libertad	2026-07-06 00:11:59	2026-07-10 15:06:01	1994-07-06	\N	\N	2026-07-06 00:11:59	F
29	2	Ana	Martínez	V-5282509	Bajo	Libertad	2026-07-06 00:13:33	2026-07-10 15:06:01	1987-07-06	\N	\N	2026-07-06 00:13:33	M
31	2	María	González	V-4126518	Bajo	Libertad	2026-07-06 00:13:33	2026-07-10 15:06:01	1979-07-06	\N	\N	2026-07-06 00:13:33	F
8	4	Carlos	González	V-9784971	Bajo	Libertad	2026-07-06 00:11:59	2026-07-10 15:12:13	1980-07-06	\N	\N	2026-07-06 00:11:59	F
12	6	Luis	López	V-2542324	Bajo	Libertad	2026-07-06 00:11:59	2026-07-10 15:12:13	1993-07-06	\N	\N	2026-07-06 00:11:59	F
17	8	Juan	González	V-6218408	Bajo	Libertad	2026-07-06 00:11:59	2026-07-10 15:12:13	2001-07-06	\N	\N	2026-07-06 00:11:59	M
26	1	Miguel	Martínez	V-9835334	Medio	Libertad	2026-07-06 00:13:33	2026-07-10 15:12:13	2005-07-06	\N	\N	2026-07-06 00:13:33	F
42	9	María	Pérez	V-6142636	Bajo	Libertad	2026-07-06 00:13:33	2026-07-10 15:12:13	1970-07-06	\N	\N	2026-07-06 00:13:33	F
51	13	Juan	Bimba	1236789	Bajo	Activo	2026-07-12 22:29:09	2026-07-15 03:15:19	1965-12-24	\N	\N	2026-07-12 22:29:09	M
53	15	PEDRO	PICAPIEDRA	21457874	Bajo	En Ingreso	2026-07-15 23:18:31	2026-07-15 23:18:31	2000-01-01	\N	\N	2026-07-15 23:18:31	M
52	13	PEDRO	PARAMO	20145785	Bajo	Libertad	2026-07-15 04:14:43	2026-07-15 15:55:21	2000-04-06	\N	\N	2026-07-15 04:14:43	M
54	15	RECLUSO	PRUEBA	100	Bajo	Activo	2026-07-20 14:54:04	2026-07-20 14:56:35	2000-11-21	\N	\N	2026-07-20 14:54:04	M
55	15	AL	CAPONE	200	Bajo	Activo	2026-07-20 15:27:36	2026-07-20 15:27:57	1990-02-20	\N	\N	2026-07-20 15:27:36	M
56	15	Prueba	Cumplimiento	V-99999999	Bajo	Libertad	2026-07-20 16:06:47	2026-07-20 16:13:55	1999-01-01	\N	\N	2024-01-01 00:00:00	M
\.


--
-- TOC entry 5241 (class 0 OID 32883)
-- Dependencies: 255
-- Data for Name: redenciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redenciones (id, recluso_id, causa_penal_id, tipo_actividad, horas_certificadas, factor_conversion, dias_redimidos, fecha_registro, numero_acta, juez_ejecucion, avalado, fecha_avali, observaciones, created_at, updated_at) FROM stdin;
1	36	11	Deportiva	61	1.50	40	2026-07-09	ACTA-2026-0001	Dra. Ana Martínez	t	2026-07-02	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
2	25	2	Deportiva	29	2.00	14	2026-07-09	ACTA-2026-0002	Dr. Juan Pérez	f	2026-07-06	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
3	25	2	Deportiva	44	3.00	14	2026-07-09	ACTA-2026-0003	Dr. Carlos Rodríguez	t	2026-07-04	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
4	31	2	Laboral	67	1.50	44	2026-07-09	ACTA-2026-0004	Dra. María González	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
5	31	2	Laboral	72	3.00	24	2026-07-09	ACTA-2026-0005	Dr. Juan Pérez	f	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
6	4	2	Educativa	25	1.50	16	2026-07-09	ACTA-2026-0006	Dr. Carlos Rodríguez	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
7	4	2	Laboral	49	3.00	16	2026-07-09	ACTA-2026-0007	Dr. Juan Pérez	f	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
8	34	10	Deportiva	49	3.00	16	2026-07-09	ACTA-2026-0008	Dr. Carlos Rodríguez	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
9	34	10	Cultural	91	2.50	36	2026-07-09	ACTA-2026-0009	Dra. María González	f	2026-07-03	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
10	50	2	Laboral	94	2.00	47	2026-07-09	ACTA-2026-0010	Dra. María González	f	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
11	47	11	Deportiva	45	2.00	22	2026-07-09	ACTA-2026-0011	Dra. María González	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
12	47	11	Educativa	78	3.00	26	2026-07-09	ACTA-2026-0012	Dr. Juan Pérez	t	2026-07-03	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
13	37	2	Deportiva	98	1.50	65	2026-07-09	ACTA-2026-0013	Dra. María González	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
14	37	2	Deportiva	55	3.00	18	2026-07-09	ACTA-2026-0014	Dra. María González	f	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
15	33	2	Educativa	47	2.50	18	2026-07-09	ACTA-2026-0015	Dr. Carlos Rodríguez	t	2026-07-08	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
16	16	2	Cultural	78	2.00	39	2026-07-09	ACTA-2026-0016	Dra. Ana Martínez	f	2026-07-01	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
17	16	2	Deportiva	32	2.50	12	2026-07-09	ACTA-2026-0017	Dra. Ana Martínez	t	2026-07-05	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
18	6	2	Cultural	91	2.50	36	2026-07-09	ACTA-2026-0018	Dra. Ana Martínez	t	2026-07-03	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
19	6	2	Deportiva	23	2.50	9	2026-07-09	ACTA-2026-0019	Dr. Juan Pérez	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
20	26	2	Deportiva	31	2.00	15	2026-07-09	ACTA-2026-0020	Dr. Juan Pérez	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
21	27	11	Educativa	94	1.50	62	2026-07-09	ACTA-2026-0021	Dra. Ana Martínez	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
22	39	2	Cultural	79	2.50	31	2026-07-09	ACTA-2026-0022	Dr. Juan Pérez	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
23	39	2	Laboral	59	3.00	19	2026-07-09	ACTA-2026-0023	Dra. María González	t	\N	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
24	8	2	Educativa	33	2.00	16	2026-07-09	ACTA-2026-0024	Dra. Ana Martínez	f	2026-07-02	\N	2026-07-09 14:31:36	2026-07-09 14:31:36
25	51	18	Educativa	19	2.00	9	2026-07-15	ACTA-2026-0025	FULANO DE TAL	t	2026-07-15	Redencion de pena por Estudio	2026-07-15 03:26:59	2026-07-15 03:27:47
26	52	20	Laboral	38	2.00	19	2026-07-15	ACTA-2026-0026	FULANO DE TAL	t	2026-07-15	REDENCION POR TRABAJO	2026-07-15 04:21:43	2026-07-15 04:21:55
27	52	20	Educativa	39	2.00	19	2026-07-15	ACTA-2026-0027	FULANO DE TAL	t	2026-07-15	REDENCION POR ESTUDIOS	2026-07-15 04:22:38	2026-07-15 04:22:49
28	52	20	Cultural	59	2.00	29	2026-07-15	ACTA-2026-0028	FULANO DE TAL	t	2026-07-15	REDENCION POR ACTIVIDADES CULTURALES	2026-07-15 04:23:41	2026-07-15 04:23:49
29	52	20	Deportiva	59	2.00	29	2026-07-15	ACTA-2026-0029	FULANO DE TAL	t	2026-07-15	REDENCION POR DEPORTE	2026-07-15 04:24:33	2026-07-15 04:24:41
30	54	21	Educativa	39	2.00	19	2026-07-20	ACTA-2026-0030	FULANO DE TAL	t	2026-07-20	\N	2026-07-20 15:06:32	2026-07-20 15:06:43
\.


--
-- TOC entry 5210 (class 0 OID 16773)
-- Dependencies: 224
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
fIRrnKm1C2UkRn1b4jC8cvAfLSSlQuIllPRT16Y1	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoicFpSRUg1VVBaMkh1NzdBSU53cTdTZHRVcUc1ZE1nMmh4b3B0cWxDWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782864887
lhHbwscRiJuCvOSx00UMgRGxqD6bN63n0T5Wwrr8	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiUlhDNUhUMTdsMFJyT2NRbTA3UzBjUzViTWN6bGV4amF6cGxuU0VIRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782864925
uYLL7vbyUO47HX2RXx8OlvU6sKwxpE347v2EjQHA	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiaDBVek1YNm9HbE85MlY3M2FCeW9LODYyTmVPd3JhSUtpdmxFeUk2eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865251
nQzx2od0ptpd4iGfX0I9gpiSshYVLyYR40VGWT4N	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkN4QmtTekZMb3NxbDhRVjNlREpZY2tEZkRDY3YwNldqeUxNN3F1ZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865251
RujxGhuMgG02VPSPaxiHLkynEmtHH7kuxGZ2DIN3	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlRXZXVJRlQ4YXE2UlR3ME05bkZnUkFOSTBOQWJMUjNMVzJTNWhNUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865254
nGt1hw9Gk847XIQed7ACsY94YLqPcA7ubEtT5x4t	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiVmVhV1oxWk5OZVJXWm55RklYNU5iWVpNUmFpOWZENkZleEdyMG9MVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865368
iK6rUQ44oInlLXjkBx0l7IKG8Ujx8mHnGzA4gmzW	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiY2Z3U2l0b1Q5c2JoNDlONTlPSlhnRTJXV0FINUxBQzAzVkptWk55bCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865431
rOVu47bCcnGaJRinJd87Zc5WZx0sTSveKDwTalKU	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmYyRmlBeWV5MXNQa0xBN1VhR2c5Z1BOWnlWZGdWN1BiVldZbUlvUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865431
NZdPCvs7qbT9yAGZC6nd0FvQ0iaM2Zx3CWcvXRlK	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiSllSaFBKdzRzdm83NzducHhOblBQdTJYTUwzc0ZsWTBXNG1odHhiZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865432
sKgbhZ3xt2NPrsPvaBgoIQug5lLHTonujOM3Iexy	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoibUhaZ2QyMzFYeVRmVWY0N29ld3lqMEZQUTZqZndUTmVLdzEyOWY5ciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865432
LBZrLnYwt76nGKJiAhWSUcgmdKJgRNfQ7u2dGtBN	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkhqU3BKRzBTcU9CRUpJRXpCQThQYzdiRmpCeEszWnhTenhvTkZSQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865433
EItQBIPGeGFlseW48VM1r3bUHpdplIiWIoHFh4Pp	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiQk96MnlxT05oNTRVT0h4R2JyaTV4emNuN2sycVh6c3R3VndMNUV6eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782865433
bbwRqGMwt6lKCXxtSBpcZ2NJO1ET36FW9iNAoiQT	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoieGVTWVpTRXRxdGxZRlVqVkpRNkN2WlF2MVhkbWNxcGtXdE5CZ0JwSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782870017
SezQpCjhwuHYNo4Nv5EGXqBASWjdoVeJbmOZolqx	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoia0hTSGxUbnV0R1YxTDdZNElQSnBiWnpFc3hJMFBRRDUzQXlLM2piUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782870018
popBoIGtAf6p6JD4TCTi2jallJTECC8N9NNWfiiD	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiRkp3TGJZOUp2a3BqVTdra0FsN25IeUlGTVZPWWtDNGR3djhYa1FZcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782870019
DS8XHfFJ1wj3cUXg0b3N6CDA6Dhs4EQAgpbz66nn	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiRE9lMlJnS2JFbWFNQ1hzSXcyYWlwQUplQzU4aUtKVm1lTDVzNFpWNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782870020
Y2eIHMAjLaIPlk1FLD7RagDkM8Qe52gjTrqjrRl6	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiZUJZb3BDNFg0bFhIZGVZMGZ0Q3NsVXl3NVB5azZUQVhRUUFBd0xRWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782870021
geXyAdCkqTmU6IxPkeo9kybZIj7toh3ghnDROujM	\N	127.0.0.1	Mozilla/5.0 (Windows NT; Windows NT 10.0; es-VE) WindowsPowerShell/5.1.19041.6456	YTozOntzOjY6Il90b2tlbiI7czo0MDoiT3BtS0x4em9XOXJnUzJEWmM5WUlnSTh4UG0zaXZZZWVnYm5oTVZIWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1782870022
Wh9aJjvkFTxWb47xBwfsJAM5xGvEJKK1HjPaMicY	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiZFJVcFF5U0g5NnBZTDFhbktwZHVDQVJKc3FFYndQRlFEckZ1aUZlZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhci1wYWJlbGxvbmVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1782870831
v8UWU5Za0Gqv9TLRutqiENcpeFWT9qNchl7Qul7Y	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiYTU1RDl6V0VPZVh6aGlPNnZBQ0g2OUNMS2tTbnhmazRjdW1XWm9XVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhci1jZWxkYXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1782884410
Kvb4G8yoPeouUd8lJx5rqToF9sFPaADEX03Cosfo	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiYXIwMktsS3lHZlVsdVQwRlRZcWlIVEc4MEtOOWdqdnpBdVFMbTk3RiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhci1yZWNsdXNvcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1783298177
H9r2l8EaD2n6LKeC8RZp8VxVF68Y22VKo8YnfaQq	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiNThtSWtGamVweFNnc1ZXSXp1a1NINXdmRkY3SjdlOGFMMGt4aVZjMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhci1kZWZlbnNvcmVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1783358842
0EvP1Rq7yqOz0V0ckdqCgfXxgb6JcPAYDNVBvfil	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoieHVPSUtsdjR6QmVMM2YzMk1FTWxDS0dza3Y3cTBTVWdRTG9WZU9SOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhci1leHBlZGllbnRlcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1783523848
cLgdPAgNfaMh1mV89w0JsWJifrNwGW24NUzyPdlX	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiaWpiWTRyTlJtUno2RjUyOHVTMXVKWE5XeEdtNkYyUFM0cUZQS3dETyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhci1yZWRlbmNpb25lcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1783607496
SF44yd8ZVhFyaxs7oZGJmAuFIaI3TtnwECrTVy6a	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiZTNSVjRUcUY4N3VSTFA4d2ExQ2RBZGpCNEczQ0lIaGlBd2JZWFUxWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jcmVhci1wZXJzb25hbCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1783696701
\.


--
-- TOC entry 5249 (class 0 OID 32996)
-- Dependencies: 263
-- Data for Name: turnos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.turnos (id, personal_id, pabellon_id, fecha_turno, hora_inicio, hora_fin, estado, observaciones, created_at, updated_at) FROM stdin;
1	2	6	2026-07-11	15:00:00	23:00:00	En Curso	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
2	3	5	2026-07-16	19:00:00	00:00:00	Completado	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
3	3	3	2026-07-16	14:00:00	18:00:00	Programado	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
4	6	4	2026-07-17	06:00:00	14:00:00	En Curso	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
5	6	1	2026-07-11	09:00:00	17:00:00	Completado	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
6	6	4	2026-07-15	12:00:00	20:00:00	Completado	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
7	7	1	2026-07-13	12:00:00	20:00:00	En Curso	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
8	7	5	2026-07-11	17:00:00	22:00:00	Programado	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
9	8	2	2026-07-12	09:00:00	15:00:00	Programado	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
10	8	5	2026-07-13	10:00:00	15:00:00	En Curso	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
11	10	2	2026-07-15	06:00:00	13:00:00	Completado	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
12	10	3	2026-07-16	08:00:00	16:00:00	En Curso	Turno asignado automáticamente	2026-07-10 15:00:10	2026-07-10 15:00:10
\.


--
-- TOC entry 5239 (class 0 OID 32861)
-- Dependencies: 253
-- Data for Name: unificacion_causa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unificacion_causa (id, unificacion_id, causa_penal_id, created_at, updated_at) FROM stdin;
1	1	1	2026-07-08 15:17:28	2026-07-08 15:17:28
2	1	3	2026-07-08 15:17:28	2026-07-08 15:17:28
3	2	2	2026-07-14 13:15:39	2026-07-14 13:15:39
4	2	11	2026-07-14 13:15:39	2026-07-14 13:15:39
5	3	4	2026-07-15 02:51:06	2026-07-15 02:51:06
6	3	17	2026-07-15 02:51:06	2026-07-15 02:51:06
\.


--
-- TOC entry 5237 (class 0 OID 32839)
-- Dependencies: 251
-- Data for Name: unificaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unificaciones (id, expediente_id, tipo_unificacion, orden_judicial, fecha_resolucion, total_dias_condena, observaciones, created_at, updated_at) FROM stdin;
1	3	Absorción	ORD-6A4E6A089C389	2026-07-08	3510	Unificación de prueba automática	2026-07-08 15:17:28	2026-07-08 15:17:28
2	51	Absorción	ORD-2026-001	2026-07-14	3143	\N	2026-07-14 13:15:38	2026-07-14 13:15:39
3	52	Absorción	ORDEN-2026-010	2026-07-15	200	Unificacion de Penas por hurto de vehiculos	2026-07-15 02:51:05	2026-07-15 02:51:06
\.


--
-- TOC entry 5208 (class 0 OID 16750)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, rol) FROM stdin;
1	Administrador	admin@sgp.com	\N	$2y$12$37OiDmJLUxyHeHqvBy.ToeSgdq/PZ7gom1T3OsrHnt1kPnAVpBxEy	\N	2026-07-10 15:20:32	2026-07-10 15:20:32	Administrador
2	Henry Garcia	henrygarcia69@gmail.com	\N	$2y$12$vnPVs3.QdM0eII6N9kCWcOXJG/HT.oKXro7sPllceXZdxgmqHBxe2	\N	2026-07-15 23:09:16	2026-07-15 23:09:16	Custodio
3	JUAN PEREZ	jperez@gmail.com	\N	$2y$12$v4B1r0OisR0KuPlOD.IL4.dL4Nq7S7EBHaH/4u9PmsPX00f1no0gq	\N	2026-07-16 02:31:05	2026-07-16 02:31:05	Médico
\.


--
-- TOC entry 5278 (class 0 OID 0)
-- Dependencies: 258
-- Name: boletas_excarcelacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.boletas_excarcelacion_id_seq', 13, true);


--
-- TOC entry 5279 (class 0 OID 0)
-- Dependencies: 244
-- Name: causas_penales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.causas_penales_id_seq', 22, true);


--
-- TOC entry 5280 (class 0 OID 0)
-- Dependencies: 236
-- Name: celdas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.celdas_id_seq', 15, true);


--
-- TOC entry 5281 (class 0 OID 0)
-- Dependencies: 232
-- Name: centros_penales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.centros_penales_id_seq', 5, true);


--
-- TOC entry 5282 (class 0 OID 0)
-- Dependencies: 240
-- Name: defensores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defensores_id_seq', 11, true);


--
-- TOC entry 5283 (class 0 OID 0)
-- Dependencies: 248
-- Name: expedientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expedientes_id_seq', 52, true);


--
-- TOC entry 5284 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 5285 (class 0 OID 0)
-- Dependencies: 256
-- Name: faltas_disciplinarias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faltas_disciplinarias_id_seq', 1, false);


--
-- TOC entry 5286 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 5287 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 22, true);


--
-- TOC entry 5288 (class 0 OID 0)
-- Dependencies: 234
-- Name: pabellones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pabellones_id_seq', 10, true);


--
-- TOC entry 5289 (class 0 OID 0)
-- Dependencies: 264
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 38, true);


--
-- TOC entry 5290 (class 0 OID 0)
-- Dependencies: 260
-- Name: personal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_id_seq', 10, true);


--
-- TOC entry 5291 (class 0 OID 0)
-- Dependencies: 246
-- Name: recluso_causa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recluso_causa_id_seq', 150, true);


--
-- TOC entry 5292 (class 0 OID 0)
-- Dependencies: 242
-- Name: recluso_defensor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recluso_defensor_id_seq', 4, true);


--
-- TOC entry 5293 (class 0 OID 0)
-- Dependencies: 238
-- Name: reclusos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reclusos_id_seq', 56, true);


--
-- TOC entry 5294 (class 0 OID 0)
-- Dependencies: 254
-- Name: redenciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.redenciones_id_seq', 30, true);


--
-- TOC entry 5295 (class 0 OID 0)
-- Dependencies: 262
-- Name: turnos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.turnos_id_seq', 12, true);


--
-- TOC entry 5296 (class 0 OID 0)
-- Dependencies: 252
-- Name: unificacion_causa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unificacion_causa_id_seq', 6, true);


--
-- TOC entry 5297 (class 0 OID 0)
-- Dependencies: 250
-- Name: unificaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unificaciones_id_seq', 3, true);


--
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


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


-- Completed on 2026-07-21 09:27:48

--
-- PostgreSQL database dump complete
--

\unrestrict auzw5fruAcCy6EJEHjJouWZ92iU3id76Ok7uH2ks3rypgw8yPVRwbKgQ9XpXQaK

