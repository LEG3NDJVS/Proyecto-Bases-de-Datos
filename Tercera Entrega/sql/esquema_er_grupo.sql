-- Esquema Relacional basado en el Diagrama ER del grupo

-- 1. Tabla de Usuarios
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    cod_anonimo VARCHAR(40) UNIQUE NOT NULL,
    consentimiento BOOLEAN NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    edad INT,
    genero TEXT,
    nivel_experiencia TEXT
);

-- 2. Tabla de Jugadores
CREATE TABLE jugador (
    id_jugador SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    nickname TEXT NOT NULL,
    fecha_vinculacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabla de Episodios
CREATE TABLE episodio (
    id_episodio SERIAL PRIMARY KEY,
    codigo_episodio VARCHAR(10) UNIQUE NOT NULL,
    nombre_episodio TEXT NOT NULL
);

-- 4. Tabla de Mapas
CREATE TABLE mapa (
    id_mapa SERIAL PRIMARY KEY,
    id_episodio INT REFERENCES episodio(id_episodio) ON DELETE CASCADE,
    cod_mapa TEXT NOT NULL,
    nombre_mapa TEXT,
    descripcion TEXT
);~

-- 5. Tabla de Sectores
CREATE TABLE sector (
    id_sector SERIAL PRIMARY KEY,
    id_mapa INT REFERENCES mapa(id_mapa) ON DELETE CASCADE,
    cod_sector TEXT NOT NULL,
    coord_x FLOAT,
    coord_y FLOAT,
    ancho_sector FLOAT,
    alto_sector FLOAT
);

-- 6. Tabla de Partidas
CREATE TABLE partida (
    id_partida SERIAL PRIMARY KEY,
    id_mapa INT REFERENCES mapa(id_mapa) ON DELETE SET NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP,
    modo_juego TEXT,
    configuracion TEXT
);

-- 7. Tabla Intermedia: Participante - Partida
CREATE TABLE participante_partida (
    id_participacion SERIAL PRIMARY KEY,
    id_partida INT REFERENCES partida(id_partida) ON DELETE CASCADE,
    id_jugador INT REFERENCES jugador(id_jugador) ON DELETE CASCADE,
    rol_jugador TEXT,
    resultado TEXT,
    UNIQUE(id_partida, id_jugador)
);

-- 8. Tabla de Eventos de Telemetría
CREATE TABLE evento_telemetria (
    id_evento SERIAL PRIMARY KEY,
    id_partida INT REFERENCES partida(id_partida) ON DELETE CASCADE,
    id_jugador INT REFERENCES jugador(id_jugador) ON DELETE CASCADE,
    id_sector INT REFERENCES sector(id_sector) ON DELETE SET NULL,
    tic INT NOT NULL,
    posicion_x FLOAT NOT NULL,
    posicion_y FLOAT NOT NULL,
    posicion_z FLOAT,
    angulo_vista FLOAT,
    velocidad_x FLOAT,
    velocidad_y FLOAT,
    velocidad_z FLOAT,
    campo_vision FLOAT,
    salud INT,
    armadura INT

);

-- 9. Tablas de UX (User Experience)
CREATE TABLE instrumento_ux (
    id_instrumento SERIAL PRIMARY KEY,
    nombre_instrumento VARCHAR(60) UNIQUE NOT NULL,
    descripcion TEXT,
    escala_minima INT,
    escala_maxima INT
);

CREATE TABLE pregunta_ux (
    id_pregunta SERIAL PRIMARY KEY,
    id_instrumento INT REFERENCES instrumento_ux(id_instrumento) ON DELETE CASCADE,
    texto_pregunta TEXT NOT NULL,
    dimension TEXT,
    orden_pregunta INT
);

CREATE TABLE respuesta_ux (
    id_respuesta SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    id_instrumento INT REFERENCES instrumento_ux(id_instrumento) ON DELETE CASCADE,
    id_partida INT REFERENCES partida(id_partida) ON DELETE SET NULL,
    fecha_respuesta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacion TEXT
);

CREATE TABLE detalle_respuesta_ux (
    id_detalle_respuesta SERIAL PRIMARY KEY,
    id_respuesta INT REFERENCES respuesta_ux(id_respuesta) ON DELETE CASCADE,
    id_pregunta INT REFERENCES pregunta_ux(id_pregunta) ON DELETE CASCADE,
    valor FLOAT NOT NULL,
    UNIQUE(id_respuesta, id_pregunta)
);

-- 10. Tablas de Log y Carga (ETL)
CREATE TABLE carga_tsv (
    id_carga SERIAL PRIMARY KEY,
    nombre_archivo TEXT NOT NULL,
    fecha_carga TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_carga TEXT NOT NULL,
    total_registros INT,
    registros_validos INT,
    registros_invalidos INT
);

CREATE TABLE log_error_carga (
    id_error SERIAL PRIMARY KEY,
    id_carga INT REFERENCES carga_tsv(id_carga) ON DELETE CASCADE,
    linea_original TEXT NOT NULL,
    motivo_error TEXT NOT NULL,
    fecha_error TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
