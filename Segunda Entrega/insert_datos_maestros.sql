-- 1. Insertar 3 Episodios
INSERT INTO episodio (id_episodio, codigo_episodio, nombre_episodio) VALUES 
(1, 'E1', 'Knee-Deep in the Dead'),
(2, 'E2', 'The Shores of Hell'),
(3, 'E3', 'Inferno');

-- 2. Insertar 3 Mapas
INSERT INTO mapa (id_mapa, id_episodio, cod_mapa, nombre_mapa, descripcion) VALUES 
(1, 1, 'E1M1', 'Hangar', 'Primer nivel del juego'),
(2, 2, 'E2M1', 'Deimos Anomaly', 'Nivel infernal base'),
(3, 3, 'E3M1', 'Hell Keep', 'Fortaleza del infierno');

-- 3. Insertar 6 Sectores (2 por cada mapa)
INSERT INTO sector (id_sector, id_mapa, cod_sector, coord_x, coord_y, ancho_sector, alto_sector) VALUES 
(1, 1, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(2, 1, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(3, 2, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(4, 2, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(5, 3, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(6, 3, 'SEC_02', 250.0, 0.0, 250.0, 250.0);

-- 4. Insertar 6 Usuarios (Estudiantes Voluntarios)
INSERT INTO usuario (id_usuario, cod_anonimo, consentimiento, edad, genero, nivel_experiencia) VALUES 
(1, 'USER_ANON_1', TRUE, 21, 'M', 'Intermedio'),
(2, 'USER_ANON_2', TRUE, 22, 'F', 'Avanzado'),
(3, 'USER_ANON_3', TRUE, 20, 'M', 'Principiante'),
(4, 'USER_ANON_4', TRUE, 23, 'F', 'Experto'),
(5, 'USER_ANON_5', TRUE, 19, 'M', 'Intermedio'),
(6, 'USER_ANON_6', TRUE, 24, 'M', 'Avanzado');

-- 5. Insertar 6 Jugadores (Avatares en el juego)
INSERT INTO jugador (id_jugador, id_usuario, nickname) VALUES 
(1, 1, 'DoomSlayer_1'),
(2, 2, 'DoomSlayer_2'),
(3, 3, 'DoomSlayer_3'),
(4, 4, 'DoomSlayer_4'),
(5, 5, 'DoomSlayer_5'),
(6, 6, 'DoomSlayer_6');

-- 6. Insertar 3 Partidas
INSERT INTO partida (id_partida, id_mapa, fecha_inicio, fecha_fin, modo_juego, configuracion) VALUES 
(1, 1, '2026-05-20 10:00:00', '2026-05-20 10:30:00', 'Co-op', 'Dificil'),
(2, 2, '2026-05-21 11:00:00', '2026-05-21 11:45:00', 'Co-op', 'Dificil'),
(3, 3, '2026-05-22 15:00:00', '2026-05-22 15:20:00', 'Deathmatch', 'Nightmare');

-- 7. Vincular Jugadores con Partidas
INSERT INTO participante_partida (id_partida, id_jugador, rol_jugador, resultado) VALUES 
(1, 1, 'Marine', 'Victoria'),
(1, 2, 'Marine', 'Victoria'),
(2, 3, 'Marine', 'Victoria'),
(2, 4, 'Marine', 'Victoria'),
(3, 5, 'Marine', 'Derrota'),
(3, 6, 'Marine', 'Victoria');

-- Restaurar los auto-incrementables (Secuencias) para evitar errores futuros
SELECT setval('episodio_id_episodio_seq', (SELECT MAX(id_episodio) FROM episodio));
SELECT setval('mapa_id_mapa_seq', (SELECT MAX(id_mapa) FROM mapa));
SELECT setval('sector_id_sector_seq', (SELECT MAX(id_sector) FROM sector));
SELECT setval('usuario_id_usuario_seq', (SELECT MAX(id_usuario) FROM usuario));
SELECT setval('jugador_id_jugador_seq', (SELECT MAX(id_jugador) FROM jugador));
SELECT setval('partida_id_partida_seq', (SELECT MAX(id_partida) FROM partida));
