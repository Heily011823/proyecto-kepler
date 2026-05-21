-- database/seed.sql

USE kepler;

-- Insertar sondas de prueba
INSERT INTO sondas (nombre, tipo, fecha_lanzamiento)
VALUES ('Voyager IX', 'No tripulada', '2024-01-01');

-- Insertar reporte de prueba
INSERT INTO voyager_reportes (sonda_id, timestamp, coordenadas, lectura_espectral, nivel_confianza, reglas_recorridas)
VALUES (1, NOW(), '12:34:56, -45:67:89', '{"H2O": "detectado"}', 0.95, 'regla1, regla2');

-- Insertar paquete de HERMES
INSERT INTO hermes_paquetes (reporte_id, hash_sha256, timestamp_recibido)
VALUES (1, SHA2('prueba', 256), NOW());

-- Insertar mensaje de ATLAS
INSERT INTO atlas_mensajes (paquete_id, nivel_prioridad, agencia_responsable, misiones_activas, trazabilidad)
VALUES (1, 5, 'ESA', 140, 'Voyager IX -> HERMES -> ATLAS');

-- Insertar historial en GROUND
INSERT INTO ground_historial (mensaje_id, resumen_consolidado)
VALUES (1, 'Reporte de Voyager IX recibido y procesado correctamente');