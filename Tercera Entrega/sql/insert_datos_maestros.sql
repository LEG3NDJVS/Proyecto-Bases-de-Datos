TRUNCATE TABLE participante_partida, partida, evento_telemetria, sector, mapa, episodio, jugador, usuario CASCADE;

-- 1. Insertar 4 Episodios (nombres reales de Freedoom: Phase 1)
INSERT INTO episodio (id_episodio, codigo_episodio, nombre_episodio) VALUES 
(1, 'E1', 'Outpost Outbreak'),
(2, 'E2', 'Military Labs'),
(3, 'E3', 'Event Horizon'),
(4, 'E4', 'Double Impact');

-- 2. Insertar 36 Mapas (9 por episodio, nombres reales de Freedoom)
INSERT INTO mapa (id_mapa, id_episodio, cod_mapa, nombre_mapa) VALUES 
-- Episodio 1: Outpost Outbreak
(1, 1, 'E1M1', 'Outer Prison'),
(2, 1, 'E1M2', 'Communications Center'),
(3, 1, 'E1M3', 'Waste Disposal'),
(4, 1, 'E1M4', 'Supply Depot'),
(5, 1, 'E1M5', 'Armory'),
(6, 1, 'E1M6', 'Training Facility'),
(7, 1, 'E1M7', 'Xenobiotic Materials Lab'),
(8, 1, 'E1M8', 'Outpost Quarry'),
(9, 1, 'E1M9', 'Nutrient Recycling'),
-- Episodio 2: Military Labs
(10, 2, 'E2M1', 'Elemental Gate'),
(11, 2, 'E2M2', 'Shifter'),
(12, 2, 'E2M3', 'Reclaimed Facilities'),
(13, 2, 'E2M4', 'Flooded Installation'),
(14, 2, 'E2M5', 'Underground Hub'),
(15, 2, 'E2M6', 'Hidden Sector'),
(16, 2, 'E2M7', 'Control Complex'),
(17, 2, 'E2M8', 'Containment Cell'),
(18, 2, 'E2M9', 'Fortress 31'),
-- Episodio 3: Event Horizon
(19, 3, 'E3M1', 'Land of the Lost'),
(20, 3, 'E3M2', 'Geothermal Tunnels'),
(21, 3, 'E3M3', 'Sacrificial Bastion'),
(22, 3, 'E3M4', 'Oblation Temple'),
(23, 3, 'E3M5', 'Infernal Hallows'),
(24, 3, 'E3M6', 'Igneous Intrusion'),
(25, 3, 'E3M7', 'No Regrets'),
(26, 3, 'E3M8', 'Ancient Lair'),
(27, 3, 'E3M9', 'Acquainted With Grief'),
-- Episodio 4: Double Impact
(28, 4, 'E4M1', 'Maintenance Area'),
(29, 4, 'E4M2', 'Research Complex'),
(30, 4, 'E4M3', 'Central Computing'),
(31, 4, 'E4M4', 'Hydroponic Facility'),
(32, 4, 'E4M5', 'Engineering Station'),
(33, 4, 'E4M6', 'Command Center'),
(34, 4, 'E4M7', 'Waste Treatment'),
(35, 4, 'E4M8', 'Launch Bay'),
(36, 4, 'E4M9', 'Operations');

-- 3. Insertar 72 Sectores (2 por mapa: SEC_01 para x<250, SEC_02 para x>=250)
INSERT INTO sector (id_sector, id_mapa, cod_sector, coord_x, coord_y, ancho_sector, alto_sector) VALUES 
-- E1: Outpost Outbreak (mapas 1-9)
(1, 1, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(2, 1, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(3, 2, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(4, 2, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(5, 3, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(6, 3, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(7, 4, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(8, 4, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(9, 5, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(10, 5, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(11, 6, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(12, 6, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(13, 7, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(14, 7, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(15, 8, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(16, 8, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(17, 9, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(18, 9, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
-- E2: Military Labs (mapas 10-18)
(19, 10, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(20, 10, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(21, 11, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(22, 11, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(23, 12, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(24, 12, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(25, 13, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(26, 13, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(27, 14, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(28, 14, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(29, 15, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(30, 15, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(31, 16, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(32, 16, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(33, 17, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(34, 17, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(35, 18, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(36, 18, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
-- E3: Event Horizon (mapas 19-27)
(37, 19, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(38, 19, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(39, 20, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(40, 20, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(41, 21, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(42, 21, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(43, 22, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(44, 22, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(45, 23, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(46, 23, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(47, 24, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(48, 24, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(49, 25, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(50, 25, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(51, 26, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(52, 26, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(53, 27, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(54, 27, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
-- E4: Double Impact (mapas 28-36)
(55, 28, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(56, 28, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(57, 29, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(58, 29, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(59, 30, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(60, 30, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(61, 31, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(62, 31, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(63, 32, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(64, 32, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(65, 33, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(66, 33, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(67, 34, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(68, 34, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(69, 35, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(70, 35, 'SEC_02', 250.0, 0.0, 250.0, 250.0),
(71, 36, 'SEC_01', 0.0, 0.0, 250.0, 250.0),
(72, 36, 'SEC_02', 250.0, 0.0, 250.0, 250.0);

INSERT INTO usuario (id_usuario, cod_anonimo, consentimiento, edad, genero, nivel_experiencia) VALUES 
(1, 'USER_ANON_1', TRUE, 21, 'M', 'Intermedio'),
(2, 'USER_ANON_2', TRUE, 22, 'F', 'Avanzado'),
(3, 'USER_ANON_3', TRUE, 20, 'M', 'Principiante');

INSERT INTO jugador (id_jugador, id_usuario, nickname) VALUES 
(1, 1, 'DoomSlayer_1'),
(2, 1, 'DoomSlayer_2'),
(3, 2, 'DoomSlayer_3'),
(4, 2, 'DoomSlayer_4'),
(5, 3, 'DoomSlayer_5'),
(6, 3, 'DoomSlayer_6');

INSERT INTO partida (id_partida, id_mapa, fecha_inicio, fecha_fin, modo_juego, configuracion) VALUES 
(1, 1, '2026-05-20 10:00:00', '2026-05-20 10:30:00', 'Co-op', 'Dificil'),
(2, 10, '2026-05-21 11:00:00', '2026-05-21 11:45:00', 'Co-op', 'Dificil'),
(3, 19, '2026-05-22 15:00:00', '2026-05-22 15:20:00', 'Deathmatch', 'Nightmare');

INSERT INTO participante_partida (id_partida, id_jugador, rol_jugador, resultado) VALUES 
(1, 1, 'Marine', 'Victoria'),
(1, 2, 'Marine', 'Victoria'),
(2, 3, 'Marine', 'Victoria'),
(2, 4, 'Marine', 'Victoria'),
(3, 5, 'Marine', 'Derrota'),
(3, 6, 'Marine', 'Victoria');

SELECT setval('episodio_id_episodio_seq', (SELECT MAX(id_episodio) FROM episodio));
SELECT setval('mapa_id_mapa_seq', (SELECT MAX(id_mapa) FROM mapa));
SELECT setval('sector_id_sector_seq', (SELECT MAX(id_sector) FROM sector));
SELECT setval('usuario_id_usuario_seq', (SELECT MAX(id_usuario) FROM usuario));
SELECT setval('jugador_id_jugador_seq', (SELECT MAX(id_jugador) FROM jugador));
SELECT setval('partida_id_partida_seq', (SELECT MAX(id_partida) FROM partida));
