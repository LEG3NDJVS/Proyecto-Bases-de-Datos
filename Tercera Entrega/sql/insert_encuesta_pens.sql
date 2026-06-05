
INSERT INTO instrumento_ux (id_instrumento, nombre_instrumento, descripcion, escala_minima, escala_maxima) 
VALUES (1, 'PENS', 'Player Experience of Need Satisfaction - Mide las necesidades psicológicas básicas en el juego', 1, 7);

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

SELECT setval('instrumento_ux_id_instrumento_seq', (SELECT MAX(id_instrumento) FROM instrumento_ux));
SELECT setval('pregunta_ux_id_pregunta_seq', (SELECT MAX(id_pregunta) FROM pregunta_ux));


INSERT INTO respuesta_ux (id_respuesta, id_usuario, id_instrumento, id_partida, observacion) VALUES 
(1, 1, 1, 1, 'El juego fue muy entretenido pero los controles de movimiento fueron un poco difíciles al principio.');

INSERT INTO respuesta_ux (id_respuesta, id_usuario, id_instrumento, id_partida, observacion) VALUES 
(2, 2, 1, 2, 'Me sentí muy inmerso, excelente experiencia en el nivel infernal.');

INSERT INTO respuesta_ux (id_respuesta, id_usuario, id_instrumento, id_partida, observacion) VALUES 
(3, 3, 1, 3, 'Fue un poco frustrante perder en el Deathmatch, pero el diseño del mapa es genial.');

INSERT INTO detalle_respuesta_ux (id_respuesta, id_pregunta, valor) VALUES
(1, 1, 5), (1, 2, 6), (1, 3, 4), (1, 4, 5), (1, 5, 6), 
(1, 6, 4), (1, 7, 3), (1, 8, 4), (1, 9, 7), (1, 10, 6);

INSERT INTO detalle_respuesta_ux (id_respuesta, id_pregunta, valor) VALUES
(2, 1, 7), (2, 2, 6), (2, 3, 5), (2, 4, 6), (2, 5, 7), 
(2, 6, 5), (2, 7, 6), (2, 8, 6), (2, 9, 5), (2, 10, 5);

INSERT INTO detalle_respuesta_ux (id_respuesta, id_pregunta, valor) VALUES
(3, 1, 4), (3, 2, 7), (3, 3, 5), (3, 4, 7), (3, 5, 5), 
(3, 6, 3), (3, 7, 5), (3, 8, 4), (3, 9, 6), (3, 10, 7);

SELECT setval('respuesta_ux_id_respuesta_seq', (SELECT MAX(id_respuesta) FROM respuesta_ux));
SELECT setval('detalle_respuesta_ux_id_detalle_respuesta_seq', (SELECT MAX(id_detalle_respuesta) FROM detalle_respuesta_ux));
