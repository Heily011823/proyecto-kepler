-- database/schema.sql

CREATE DATABASE IF NOT EXISTS kepler;
USE kepler;

-- Tabla de sondas
CREATE TABLE sondas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50),
    fecha_lanzamiento DATE
);

-- Tabla de reportes de Voyager
CREATE TABLE voyager_reportes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sonda_id INT NOT NULL,
    timestamp DATETIME NOT NULL,
    coordenadas VARCHAR(100),
    lectura_espectral TEXT,
    nivel_confianza DECIMAL(3,2),
    reglas_recorridas TEXT,
    FOREIGN KEY (sonda_id) REFERENCES sondas(id)
);

-- Tabla de paquetes de HERMES
CREATE TABLE hermes_paquetes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reporte_id INT NOT NULL,
    hash_sha256 CHAR(64) NOT NULL,
    timestamp_recibido DATETIME,
    FOREIGN KEY (reporte_id) REFERENCES voyager_reportes(id)
);

-- Tabla de mensajes de ATLAS
CREATE TABLE atlas_mensajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paquete_id INT NOT NULL,
    nivel_prioridad INT,
    agencia_responsable VARCHAR(50),
    misiones_activas INT,
    trazabilidad TEXT,
    FOREIGN KEY (paquete_id) REFERENCES hermes_paquetes(id)
);

-- Tabla de historial en GROUND
CREATE TABLE ground_historial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensaje_id INT NOT NULL,
    resumen_consolidado TEXT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (mensaje_id) REFERENCES atlas_mensajes(id)
);