
-- Consulta 1: Duración promedio de sesiones por mapa
SELECT 
    m.cod_mapa,
    m.nombre_mapa,
    ROUND(AVG(EXTRACT(EPOCH FROM (p.fecha_fin - p.fecha_inicio)) / 60)::numeric, 2) AS duracion_promedio_minutos,
    COUNT(*) AS total_partidas
FROM partida p
JOIN mapa m ON m.id_mapa = p.id_mapa
GROUP BY m.cod_mapa, m.nombre_mapa
ORDER BY m.cod_mapa;


-- Consulta 2: Jugadores con mayor proximidad promedio

SELECT 
    j1.nickname AS jugador1,
    j2.nickname AS jugador2,
    ROUND(AVG(SQRT(POW(e1.posicion_x - e2.posicion_x, 2) + POW(e1.posicion_y - e2.posicion_y, 2)))::numeric, 2) AS distancia_promedio,
    COUNT(*) AS tics_compartidos
FROM evento_telemetria e1
JOIN evento_telemetria e2 
    ON e1.id_partida = e2.id_partida 
    AND e1.tic = e2.tic
    AND e1.id_jugador < e2.id_jugador
JOIN jugador j1 ON j1.id_jugador = e1.id_jugador
JOIN jugador j2 ON j2.id_jugador = e2.id_jugador
GROUP BY j1.nickname, j2.nickname
ORDER BY distancia_promedio;

-- Consulta 3: Distancias de trayectoria mín/máx por jugador
WITH distancias_por_tic AS (
    SELECT 
        id_jugador,
        id_partida,
        tic,
        posicion_x,
        posicion_y,
        posicion_z,
        LAG(posicion_x) OVER (PARTITION BY id_jugador, id_partida ORDER BY tic) AS prev_x,
        LAG(posicion_y) OVER (PARTITION BY id_jugador, id_partida ORDER BY tic) AS prev_y,
        LAG(posicion_z) OVER (PARTITION BY id_jugador, id_partida ORDER BY tic) AS prev_z
    FROM evento_telemetria
),
trayectoria_por_partida AS (
    SELECT 
        id_jugador,
        id_partida,
        ROUND(SUM(SQRT(POW(posicion_x - prev_x, 2) + POW(posicion_y - prev_y, 2) + POW(posicion_z - prev_z, 2)))::numeric, 2) AS distancia_total
    FROM distancias_por_tic
    WHERE prev_x IS NOT NULL
    GROUP BY id_jugador, id_partida
)
SELECT 
    j.nickname,
    ROUND(MIN(tp.distancia_total)::numeric, 2) AS distancia_minima,
    ROUND(MAX(tp.distancia_total)::numeric, 2) AS distancia_maxima,
    ROUND(AVG(tp.distancia_total)::numeric, 2) AS distancia_promedio
FROM trayectoria_por_partida tp
JOIN jugador j ON j.id_jugador = tp.id_jugador
GROUP BY j.id_jugador, j.nickname
ORDER BY j.nickname;

-- Consulta 4: Respuestas UX para jugadores con trayectorias
WITH duracion_jugador AS (
    SELECT 
        id_jugador,
        id_partida,
        MAX(tic) - MIN(tic) + 1 AS duracion_tics
    FROM evento_telemetria
    GROUP BY id_jugador, id_partida
),
promedio_global AS (
    SELECT AVG(duracion_tics) AS promedio_global_tics FROM duracion_jugador
),
jugadores_sobre_promedio AS (
    SELECT DISTINCT dj.id_jugador, dj.id_partida
    FROM duracion_jugador dj, promedio_global pg
    WHERE dj.duracion_tics > pg.promedio_global_tics
)
SELECT 
    j.nickname,
    ru.id_respuesta,
    ru.observacion,
    ROUND(AVG(dr.valor)::numeric, 2) AS puntaje_ux_promedio
FROM jugadores_sobre_promedio jsp
JOIN jugador j ON j.id_jugador = jsp.id_jugador
JOIN respuesta_ux ru ON ru.id_usuario = j.id_usuario AND ru.id_partida = jsp.id_partida
JOIN detalle_respuesta_ux dr ON dr.id_respuesta = ru.id_respuesta
GROUP BY j.nickname, ru.id_respuesta, ru.observacion
ORDER BY puntaje_ux_promedio DESC;

-- Consulta 5: Sector más visitado (punto caliente) por episodio/mapa
SELECT 
    e.codigo_episodio,
    e.nombre_episodio,
    m.cod_mapa,
    m.nombre_mapa,
    s.cod_sector,
    COUNT(*) AS visitas,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY m.id_mapa), 1) AS porcentaje_en_mapa
FROM evento_telemetria et
JOIN sector s ON s.id_sector = et.id_sector
JOIN mapa m ON m.id_mapa = s.id_mapa
JOIN episodio e ON e.id_episodio = m.id_episodio
GROUP BY e.codigo_episodio, e.nombre_episodio, m.cod_mapa, m.nombre_mapa, m.id_mapa, s.cod_sector
ORDER BY e.codigo_episodio, m.cod_mapa, visitas DESC;

-- Consulta 6: Número de tics de co-presencia en un mismo sector
SELECT 
    e1.id_partida,
    s.cod_sector,
    m.cod_mapa,
    j1.nickname AS jugador1,
    j2.nickname AS jugador2,
    COUNT(DISTINCT e1.tic) AS tics_copresencia
FROM evento_telemetria e1
JOIN evento_telemetria e2 
    ON e1.id_partida = e2.id_partida 
    AND e1.tic = e2.tic 
    AND e1.id_sector = e2.id_sector
    AND e1.id_jugador < e2.id_jugador
JOIN sector s ON s.id_sector = e1.id_sector
JOIN mapa m ON m.id_mapa = s.id_mapa
JOIN jugador j1 ON j1.id_jugador = e1.id_jugador
JOIN jugador j2 ON j2.id_jugador = e2.id_jugador
GROUP BY e1.id_partida, s.cod_sector, m.cod_mapa, j1.nickname, j2.nickname
ORDER BY tics_copresencia DESC;
