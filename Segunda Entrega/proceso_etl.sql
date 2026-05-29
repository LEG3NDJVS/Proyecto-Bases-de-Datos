-- ==========================================
-- FASE 1: EXTRACT (Extracción) y STAGING
-- ==========================================

-- 1. Creamos la Tabla de Staging temporal
CREATE TEMP TABLE staging_telemetria (
    game_id INT,
    player_id INT,
    codigo_episodio TEXT,
    codigo_mapa TEXT,
    codigo_sector TEXT,
    tic INT,
    pos_x FLOAT,
    pos_y FLOAT,
    pos_z FLOAT,
    angulo FLOAT,
    vel_x FLOAT,
    vel_y FLOAT,
    vel_z FLOAT,
    fov FLOAT,
    salud INT,
    armadura INT
);

-- 2. Cargamos los datos crudos del archivo a la tabla de staging
COPY staging_telemetria 
FROM '/home/jubotero/3erSemestre/proyecto_basesdedatos/telemetria_muestra.tsv' 
DELIMITER E'\t' CSV HEADER;

-- ==========================================
-- FASE 2 y 3: TRANSFORM (Transformación) y LOAD (Carga)
-- ==========================================

-- 3. Pasamos los datos de la tabla Staging a la tabla FINAL (evento_telemetria)
INSERT INTO evento_telemetria (
    id_partida, id_jugador, id_sector, tic, 
    posicion_x, posicion_y, posicion_z, 
    angulo_vista, velocidad_x, velocidad_y, velocidad_z, 
    campo_vision, salud, armadura
)
SELECT 
    st.game_id,
    st.player_id,
    s.id_sector,  -- <-- TRANSFORMACIÓN: Cambiamos texto por el ID numérico
    st.tic,
    st.pos_x, st.pos_y, st.pos_z,
    st.angulo,
    st.vel_x, st.vel_y, st.vel_z,
    st.fov,
    st.salud, st.armadura
FROM staging_telemetria st
-- Las validaciones (Cruzamos datos de texto para hallar su llave foránea real)
JOIN mapa m ON m.cod_mapa = st.codigo_mapa
JOIN sector s ON s.cod_sector = st.codigo_sector AND s.id_mapa = m.id_mapa;
