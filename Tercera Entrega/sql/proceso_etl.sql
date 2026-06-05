TRUNCATE TABLE evento_telemetria, carga_tsv, log_error_carga CASCADE;

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

\copy staging_telemetria FROM '/home/jubotero/3erSemestre/proyecto_basesdedatos/telemetria_organica.tsv' DELIMITER E'\t' CSV HEADER;



INSERT INTO evento_telemetria (
    id_partida, id_jugador, id_sector, tic, 
    posicion_x, posicion_y, posicion_z, 
    angulo_vista, velocidad_x, velocidad_y, velocidad_z, 
    campo_vision, salud, armadura
)
SELECT 
    st.game_id,
    st.player_id,
    s.id_sector,  
    st.tic,
    st.pos_x, st.pos_y, st.pos_z,
    st.angulo,
    st.vel_x, st.vel_y, st.vel_z,
    st.fov,
    st.salud, st.armadura
FROM staging_telemetria st

JOIN mapa m ON m.cod_mapa = TRIM(st.codigo_mapa)
JOIN sector s ON s.cod_sector = TRIM(st.codigo_sector) AND s.id_mapa = m.id_mapa;