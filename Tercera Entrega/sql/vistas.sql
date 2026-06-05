-- Esta vista sirve para ver un resumen de cada jugador
-- en cada partida, o sea cuantos registros de telemetria tuvo,
-- cuanto duro su recorrido y como fue su salud y armadura promedio.

CREATE OR REPLACE VIEW vista_resumen AS
SELECT
    et.id_partida,
    et.id_jugador,
    j.nickname,
    COUNT(*) AS total_eventos,
    MIN(et.tic) AS primer_tic,
    MAX(et.tic) AS ultimo_tic,
    MAX(et.tic) - MIN(et.tic) + 1 AS duracion_tics,
    AVG(et.salud) AS salud_promedio,
    AVG(et.armadura) AS armadura_promedio
FROM evento_telemetria et
JOIN jugador j
    ON j.id_jugador = et.id_jugador
GROUP BY
    et.id_partida,
    et.id_jugador,
    j.nickname;



-- Esta vista sirve para saber cuales sectores fueron mas visitados
-- en cada partida, episodio y mapa.

CREATE OR REPLACE VIEW vista_sectores AS
SELECT
    et.id_partida,
    e.codigo_episodio,
    m.cod_mapa,
    s.cod_sector,
    COUNT(*) AS cantidad_visitas
FROM evento_telemetria et
JOIN sector s
    ON s.id_sector = et.id_sector
JOIN mapa m
    ON m.id_mapa = s.id_mapa
JOIN episodio e
    ON e.id_episodio = m.id_episodio
GROUP BY
    et.id_partida,
    e.codigo_episodio,
    m.cod_mapa,
    s.cod_sector;



-- Vista materializada.
-- Esta vista guarda un resumen general por jugador.
-- Sirve para consultar rapido cuantos registros tiene cada jugador,
-- en cuantas partidas participo y sus promedios de salud y armadura.
-- Si se cargan nuevos datos, se actualiza con:
-- REFRESH MATERIALIZED VIEW vista_mate_jugador;


DROP MATERIALIZED VIEW IF EXISTS vista_mate_jugador;

CREATE MATERIALIZED VIEW vista_mate_jugador AS
SELECT
    et.id_jugador,
    j.nickname,
    COUNT(*) AS total_eventos,
    COUNT(DISTINCT et.id_partida) AS total_partidas,
    AVG(et.salud) AS salud_promedio,
    AVG(et.armadura) AS armadura_promedio,
    MIN(et.tic) AS primer_tic,
    MAX(et.tic) AS ultimo_tic
FROM evento_telemetria et
JOIN jugador j
    ON j.id_jugador = et.id_jugador
GROUP BY
    et.id_jugador,
    j.nickname;

-- Consultas pa probar que las vistas funcionen

SELECT * 
FROM vista_resumen 
LIMIT 10;

SELECT * 
FROM vista_sectores
ORDER BY cantidad_visitas DESC
LIMIT 10;

SELECT * 
FROM vista_mate_jugador;