CREATE TABLE IF NOT EXISTS `entrenamiento` (
    `id` int(10) AUTO_INCREMENT NOT NULL,
    `tipoEntrenamiento` ENUM('fisico', 'tecnico') DEFAULT NULL,
    `ubicacion` varchar(30) DEFAULT NULL,
    `fechaRealizacion` DATE DEFAULT NULL,
    PRIMARY KEY (`id`)
    );