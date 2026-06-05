

DROP INDEX IF EXISTS idx_telemetria_tiempo;
DROP INDEX IF EXISTS idx_telemetria_sector;
DROP INDEX IF EXISTS idx_telemetria_espacial;
DROP INDEX IF EXISTS idx_participante_jp;



EXPLAIN ANALYZE
SELECT id_partida, id_jugador, tic, posicion_x, posicion_y, salud
FROM evento_telemetria
WHERE id_partida = 1 AND id_jugador = 1
ORDER BY tic;

CREATE INDEX idx_telemetria_tiempo
    ON evento_telemetria (id_partida, id_jugador, tic);

EXPLAIN ANALYZE
SELECT id_partida, id_jugador, tic, posicion_x, posicion_y, salud
FROM evento_telemetria
WHERE id_partida = 1 AND id_jugador = 1
ORDER BY tic;

EXPLAIN ANALYZE
SELECT t.id_partida, t.id_sector, s.cod_sector, COUNT(*) AS frecuencia
FROM evento_telemetria t
JOIN sector s ON s.id_sector = t.id_sector
WHERE t.id_partida = 1
GROUP BY t.id_partida, t.id_sector, s.cod_sector
ORDER BY frecuencia DESC;

CREATE INDEX idx_telemetria_sector
    ON evento_telemetria (id_partida, id_sector);

EXPLAIN ANALYZE
SELECT t.id_partida, t.id_sector, s.cod_sector, COUNT(*) AS frecuencia
FROM evento_telemetria t
JOIN sector s ON s.id_sector = t.id_sector
WHERE t.id_partida = 1
GROUP BY t.id_partida, t.id_sector, s.cod_sector
ORDER BY frecuencia DESC;



EXPLAIN ANALYZE
SELECT id_evento, id_partida, id_jugador, posicion_x, posicion_y
FROM evento_telemetria
WHERE point(posicion_x, posicion_y) <@ box(point(0, -250), point(250, 0));

CREATE INDEX idx_telemetria_espacial
    ON evento_telemetria USING gist (point(posicion_x, posicion_y));

EXPLAIN ANALYZE
SELECT id_evento, id_partida, id_jugador, posicion_x, posicion_y
FROM evento_telemetria
WHERE point(posicion_x, posicion_y) <@ box(point(0, -250), point(250, 0));



EXPLAIN ANALYZE
SELECT pp.id_partida, p.modo_juego, j.nickname
FROM participante_partida pp
JOIN partida p ON p.id_partida = pp.id_partida
JOIN jugador j ON j.id_jugador = pp.id_jugador
WHERE pp.id_jugador = 3;

CREATE INDEX idx_participante_jp
    ON participante_partida (id_jugador, id_partida);

EXPLAIN ANALYZE
SELECT pp.id_partida, p.modo_juego, j.nickname
FROM participante_partida pp
JOIN partida p ON p.id_partida = pp.id_partida
JOIN jugador j ON j.id_jugador = pp.id_jugador
WHERE pp.id_jugador = 3;
