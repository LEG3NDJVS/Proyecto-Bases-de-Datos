-- Script para insertar la encuesta UX (PENS)
-- Cumpliendo con el requerimiento de la Parte B.3 del proyecto

-- 1. Insertar el instrumento PENS
INSERT INTO instrumento_ux (id_instrumento, nombre_instrumento, descripcion, escala_minima, escala_maxima) 
VALUES (1, 'PENS', 'Player Experience of Need Satisfaction - Mide las necesidades psicológicas básicas en el juego', 1, 7);

-- 2. Insertar las preguntas de la encuesta PENS vinculadas al instrumento 1
INSERT INTO pregunta_ux (id_instrumento, orden_pregunta, dimension, texto_pregunta) VALUES
(1, 1, 'Competencia', 'Me siento muy capaz y efectivo cuando juego.'),
(1, 2, 'Competencia', 'Siento que el juego me proporciona nuevos retos interesantes.'),
(1, 3, 'Autonomia', 'El juego me da decisiones y opciones interesantes.'),
(1, 4, 'Autonomia', 'Siento que hago las cosas en el juego porque yo quiero, no porque me obligan.'),
(1, 5, 'Inmersion', 'Al jugar, olvido mi entorno inmediato.'),
(1, 6, 'Inmersion', 'Me siento emocionalmente apegado al juego.'),
(1, 7, 'Controles Intuitivos', 'Aprender los controles del juego fue fácil.'),
(1, 8, 'Controles Intuitivos', 'Los controles se sienten muy naturales y no me frustran.'),
(1, 9, 'Relacion', 'El juego me permite interactuar con otros de forma significativa.'),
(1, 10, 'Relacion', 'Siento que me apoyo en otros jugadores durante la partida.');

-- 3. Ajustar las secuencias de las tablas para evitar errores en futuros inserts automáticos
SELECT setval('instrumento_ux_id_instrumento_seq', (SELECT MAX(id_instrumento) FROM instrumento_ux));
SELECT setval('pregunta_ux_id_pregunta_seq', (SELECT MAX(id_pregunta) FROM pregunta_ux));
