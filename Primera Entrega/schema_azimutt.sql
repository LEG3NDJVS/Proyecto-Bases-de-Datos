-- ============================================================
--  Esquema relacional - Proyecto Videojuego / UX
--  Compatible con Azimutt (PostgreSQL)
-- ============================================================

-- 1. usuario
CREATE TABLE usuario (
    id_usuario       INT          PRIMARY KEY NOT NULL,
    cod_anonimo      VARCHAR(40)  UNIQUE NOT NULL,
    edad             INT          CHECK (edad BETWEEN 10 AND 99),
    genero           VARCHAR(30),
    nivel_experiencia VARCHAR(30),
    consentimiento   BOOLEAN      NOT NULL DEFAULT FALSE,
    fecha_creacion   TIMESTAMP    NOT NULL
);

-- 2. jugador
CREATE TABLE jugador (
    id_jugador        INT          PRIMARY KEY NOT NULL,
    id_usuario        INT          NOT NULL REFERENCES usuario(id_usuario),
    nickname          VARCHAR(60)  NOT NULL,
    fecha_vinculacion TIMESTAMP
);

-- 3. episodio
CREATE TABLE episodio (
    id_episodio      INT          PRIMARY KEY NOT NULL,
    codigo_episodio  VARCHAR(10)  UNIQUE NOT NULL,
    nombre_episodio  VARCHAR(100) NOT NULL
);

-- 4. mapa
CREATE TABLE mapa (
    id_mapa      INT          PRIMARY KEY NOT NULL,
    id_episodio  INT          NOT NULL REFERENCES episodio(id_episodio),
    cod_mapa     VARCHAR(10)  NOT NULL,
    nombre_mapa  VARCHAR(100),
    descripcion  TEXT
);

-- 5. sector
CREATE TABLE sector (
    id_sector    INT            PRIMARY KEY NOT NULL,
    id_mapa      INT            NOT NULL REFERENCES mapa(id_mapa),
    cod_sector   VARCHAR(30)    NOT NULL,
    coord_x      NUMERIC(10,2),
    coord_y      NUMERIC(10,2),
    ancho_sector NUMERIC(10,2)  DEFAULT 250,
    alto_sector  NUMERIC(10,2)  DEFAULT 250
);

-- 6. partida
CREATE TABLE partida (
    id_partida   INT          PRIMARY KEY NOT NULL,
    id_mapa      INT          NOT NULL REFERENCES mapa(id_mapa),
    fecha_inicio TIMESTAMP    NOT NULL,
    fecha_fin    TIMESTAMP    CHECK (fecha_fin >= fecha_inicio),
    modo_juego   VARCHAR(40),
    configuracion TEXT
);

-- 7. participante_partida
CREATE TABLE participante_partida (
    id_participacion INT         PRIMARY KEY NOT NULL,
    id_partida       INT         NOT NULL REFERENCES partida(id_partida),
    id_jugador       INT         NOT NULL REFERENCES jugador(id_jugador),
    rol_jugador      VARCHAR(40),
    resultado        VARCHAR(40),
    UNIQUE (id_partida, id_jugador)
);

-- 8. evento_telemetria
CREATE TABLE evento_telemetria (
    id_evento     BIGINT         PRIMARY KEY NOT NULL,
    id_partida    INT            NOT NULL REFERENCES partida(id_partida),
    id_jugador    INT            NOT NULL REFERENCES jugador(id_jugador),
    id_sector     INT            REFERENCES sector(id_sector),
    tic           INT            NOT NULL CHECK (tic >= 0),
    posicion_x    NUMERIC(12,4)  NOT NULL,
    posicion_y    NUMERIC(12,4)  NOT NULL,
    posicion_z    NUMERIC(12,4),
    angulo_vista  NUMERIC(8,4),
    velocidad_x   NUMERIC(10,4),
    velocidad_y   NUMERIC(10,4),
    velocidad_z   NUMERIC(10,4),
    campo_vision  NUMERIC(6,2),
    salud         INT            CHECK (salud >= 0),
    armadura      INT            CHECK (armadura >= 0),
    municion      INT            CHECK (municion >= 0),
    UNIQUE (id_partida, id_jugador, tic)
);

-- 9. instrumento_ux
CREATE TABLE instrumento_ux (
    id_instrumento     INT          PRIMARY KEY NOT NULL,
    nombre_instrumento VARCHAR(60)  UNIQUE NOT NULL,
    descripcion        TEXT,
    escala_minima      INT,
    escala_maxima      INT
);

-- 10. pregunta_ux
CREATE TABLE pregunta_ux (
    id_pregunta    INT         PRIMARY KEY NOT NULL,
    id_instrumento INT         NOT NULL REFERENCES instrumento_ux(id_instrumento),
    texto_pregunta TEXT        NOT NULL,
    dimension      VARCHAR(60),
    orden_pregunta INT
);

-- 11. respuesta_ux
CREATE TABLE respuesta_ux (
    id_respuesta    INT         PRIMARY KEY NOT NULL,
    id_usuario      INT         NOT NULL REFERENCES usuario(id_usuario),
    id_instrumento  INT         NOT NULL REFERENCES instrumento_ux(id_instrumento),
    id_partida      INT         REFERENCES partida(id_partida),
    fecha_respuesta TIMESTAMP   NOT NULL,
    observacion     TEXT
);

-- 12. detalle_respuesta_ux
CREATE TABLE detalle_respuesta_ux (
    id_detalle_respuesta INT           PRIMARY KEY NOT NULL,
    id_respuesta         INT           NOT NULL REFERENCES respuesta_ux(id_respuesta),
    id_pregunta          INT           NOT NULL REFERENCES pregunta_ux(id_pregunta),
    valor                NUMERIC(5,2)  NOT NULL,
    UNIQUE (id_respuesta, id_pregunta)
);

-- 13. carga_tsv
CREATE TABLE carga_tsv (
    id_carga           INT          PRIMARY KEY NOT NULL,
    nombre_archivo     VARCHAR(150) NOT NULL,
    fecha_carga        TIMESTAMP    NOT NULL,
    estado_carga       VARCHAR(30)  NOT NULL,
    total_registros    INT          DEFAULT 0,
    registros_validos  INT          DEFAULT 0,
    registros_invalidos INT         DEFAULT 0
);

-- 14. log_error_carga
CREATE TABLE log_error_carga (
    id_error       INT          PRIMARY KEY NOT NULL,
    id_carga       INT          REFERENCES carga_tsv(id_carga),
    linea_original TEXT         NOT NULL,
    motivo_error   VARCHAR(200) NOT NULL,
    fecha_error    TIMESTAMP    NOT NULL DEFAULT NOW()
);
