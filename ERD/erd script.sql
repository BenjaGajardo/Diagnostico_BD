-- MySQL Script generated by MySQL Workbench
-- Thu Mar  6 10:34:05 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_type` (
  `idtable1` INT NOT NULL,
  `names_usertype` VARCHAR(45) NOT NULL,
  `descripcion_usertype` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtable1`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medicos` (
  `idmedicos` INT NOT NULL,
  `especialidad` VARCHAR(45) NOT NULL,
  `disponibilidad` VARCHAR(45) NOT NULL,
  `experiencia_años` INT NOT NULL,
  `create_datetime` DATETIME NOT NULL,
  PRIMARY KEY (`idmedicos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `pastword` INT NOT NULL,
  `teléfono` INT NOT NULL,
  `create_date` DATETIME NOT NULL,
  `RUT` INT NOT NULL,
  `user_type_idtable1` INT NOT NULL,
  `medicos_idmedicos` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_user_type_idx` (`user_type_idtable1` ASC) VISIBLE,
  INDEX `fk_usuario_medicos1_idx` (`medicos_idmedicos` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_user_type`
    FOREIGN KEY (`user_type_idtable1`)
    REFERENCES `mydb`.`user_type` (`idtable1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_medicos1`
    FOREIGN KEY (`medicos_idmedicos`)
    REFERENCES `mydb`.`medicos` (`idmedicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pacientes` (
  `idpacientes` INT NOT NULL,
  `create_date` DATETIME NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idpacientes`),
  INDEX `fk_pacientes_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_pacientes_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`citas` (
  `idcitas` INT NOT NULL,
  `fecha_solicitud` INT NOT NULL,
  `fecha_cita` INT NOT NULL,
  `hora_cita` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `pacientes_idpacientes` INT NOT NULL,
  PRIMARY KEY (`idcitas`),
  INDEX `fk_citas_pacientes1_idx` (`pacientes_idpacientes` ASC) VISIBLE,
  CONSTRAINT `fk_citas_pacientes1`
    FOREIGN KEY (`pacientes_idpacientes`)
    REFERENCES `mydb`.`pacientes` (`idpacientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`recetas_medicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`recetas_medicas` (
  `idrecetas_medicas` INT NOT NULL,
  `indicaciones` VARCHAR(45) NOT NULL,
  `fecha_emisión` INT NOT NULL,
  `fecha_vencimiento` INT NOT NULL,
  PRIMARY KEY (`idrecetas_medicas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`consultas` (
  `idconsultas` INT NOT NULL,
  `fecha_consulta` INT NOT NULL,
  `hora_consulta` INT NOT NULL,
  `motivo_consulta` VARCHAR(45) NOT NULL,
  `diagnostico_consulta` VARCHAR(45) NOT NULL,
  `receta` VARCHAR(45) NOT NULL,
  `create_date` DATETIME NOT NULL,
  `medicos_idmedicos` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `recetas_medicas_idrecetas_medicas` INT NOT NULL,
  `citas_idcitas` INT NOT NULL,
  PRIMARY KEY (`idconsultas`),
  INDEX `fk_consultas_medicos1_idx` (`medicos_idmedicos` ASC) VISIBLE,
  INDEX `fk_consultas_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_consultas_recetas_medicas1_idx` (`recetas_medicas_idrecetas_medicas` ASC) VISIBLE,
  INDEX `fk_consultas_citas1_idx` (`citas_idcitas` ASC) VISIBLE,
  CONSTRAINT `fk_consultas_medicos1`
    FOREIGN KEY (`medicos_idmedicos`)
    REFERENCES `mydb`.`medicos` (`idmedicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_recetas_medicas1`
    FOREIGN KEY (`recetas_medicas_idrecetas_medicas`)
    REFERENCES `mydb`.`recetas_medicas` (`idrecetas_medicas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_citas1`
    FOREIGN KEY (`citas_idcitas`)
    REFERENCES `mydb`.`citas` (`idcitas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tratamientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tratamientos` (
  `idtratamientos` INT NOT NULL,
  `nombre_tratamiento` VARCHAR(45) NOT NULL,
  `descripcion_tratamiento` VARCHAR(45) NOT NULL,
  `duracion_tratamiento` VARCHAR(45) NOT NULL,
  `create_date` DATETIME NOT NULL,
  PRIMARY KEY (`idtratamientos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`consultas_tratamientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`consultas_tratamientos` (
  `consultas_idconsultas` INT NOT NULL,
  `tratamientos_idtratamientos` INT NOT NULL,
  PRIMARY KEY (`consultas_idconsultas`, `tratamientos_idtratamientos`),
  INDEX `fk_consultas_has_tratamientos_tratamientos1_idx` (`tratamientos_idtratamientos` ASC) VISIBLE,
  INDEX `fk_consultas_has_tratamientos_consultas1_idx` (`consultas_idconsultas` ASC) VISIBLE,
  CONSTRAINT `fk_consultas_has_tratamientos_consultas1`
    FOREIGN KEY (`consultas_idconsultas`)
    REFERENCES `mydb`.`consultas` (`idconsultas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_has_tratamientos_tratamientos1`
    FOREIGN KEY (`tratamientos_idtratamientos`)
    REFERENCES `mydb`.`tratamientos` (`idtratamientos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- CREATE
-- inserciones de las tablas 
INSERT INTO user_type (idtable1, names_usertype, descripcion_usertype) VALUES
(1, 'Paciente', 'Usuario con rol de paciente'),
(2, 'Médico', 'Usuario con rol de médico'),
(3, 'Administrador', 'Usuario con rol de administrador');

INSERT INTO medicos (idmedicos, especialidad, disponibilidad, experiencia_años, create_datetime) VALUES
(1, 'Cardiología', 'Disponible', 10, NOW()),
(2, 'Pediatría', 'Disponible', 7, NOW()),
(3, 'Neurología', 'No disponible', 12, NOW()),
(4, 'Dermatología', 'Disponible', 5, NOW()),
(5, 'Traumatología', 'No disponible', 8, NOW());

ALTER TABLE usuario MODIFY medicos_idmedicos INT NULL;

INSERT INTO usuario (idusuario, username, pastword, teléfono, create_date, RUT, user_type_idtable1, medicos_idmedicos) VALUES
(1, 'juan_perez', 123456, 987654321, NOW(), 11223344, 1, NULL),
(2, 'maria_gomez', 234567, 912345678, NOW(), 22334455, 1, NULL),
(3, 'dr_lopez', 345678, 934567890, NOW(), 33445566, 2, 1),
(4, 'dr_ramirez', 456789, 945678901, NOW(), 44556677, 2, 2),
(5, 'admin1', 567890, 956789012, NOW(), 55667788, 3, NULL);

INSERT INTO pacientes (idpacientes, create_date, usuario_idusuario) VALUES
(1, NOW(), 1),
(2, NOW(), 2),
(3, NOW(), 1),
(4, NOW(), 2),
(5, NOW(), 1);

INSERT INTO citas (idcitas, fecha_solicitud, fecha_cita, hora_cita, estado, pacientes_idpacientes) VALUES
(1, 20250301, 20250310, 10, 'Pendiente', 1),
(2, 20250302, 20250311, 12, 'Confirmada', 2),
(3, 20250303, 20250312, 14, 'Cancelada', 3),
(4, 20250304, 20250313, 16, 'Pendiente', 4),
(5, 20250305, 20250314, 18, 'Confirmada', 5);

INSERT INTO recetas_medicas (idrecetas_medicas, indicaciones, fecha_emisión, fecha_vencimiento) VALUES
(1, 'Tomar 1 pastilla cada 12 horas', 20250310, 20250410),
(2, 'Aplicar ungüento 2 veces al día', 20250311, 20250411),
(3, 'Evitar exposición al sol', 20250312, 20250412),
(4, 'Hacer ejercicios de respiración', 20250313, 20250413),
(5, 'Tomar 2 litros de agua al día', 20250314, 20250414);

INSERT INTO consultas (idconsultas, fecha_consulta, hora_consulta, motivo_consulta, diagnostico_consulta, receta, create_date, medicos_idmedicos, usuario_idusuario, recetas_medicas_idrecetas_medicas, citas_idcitas) VALUES
(1, 20250310, 10, 'Dolor de cabeza', 'Migraña', 'Paracetamol', NOW(), 1, 1, 1, 1),
(2, 20250311, 12, 'Erupción en la piel', 'Alergia', 'Antihistamínico', NOW(), 2, 2, 2, 2),
(3, 20250312, 14, 'Dificultad para respirar', 'Asma', 'Inhalador', NOW(), 3, 1, 3, 3),
(4, 20250313, 16, 'Dolor muscular', 'Desgarro', 'Fisioterapia', NOW(), 4, 2, 4, 4),
(5, 20250314, 18, 'Fatiga extrema', 'Anemia', 'Suplementos', NOW(), 5, 1, 5, 5);

INSERT INTO tratamientos (idtratamientos, nombre_tratamiento, descripcion_tratamiento, duracion_tratamiento, create_date) VALUES
(1, 'Fisioterapia', 'Ejercicios de recuperación muscular', '2 meses', NOW()),
(2, 'Terapia Respiratoria', 'Ejercicios para mejorar la respiración', '1 mes', NOW()),
(3, 'Rehabilitación Cardiaca', 'Programa de ejercicios controlados', '3 meses', NOW()),
(4, 'Terapia del Habla', 'Mejorar la articulación y pronunciación', '4 meses', NOW()),
(5, 'Nutrición Especializada', 'Dieta balanceada para anemia', '3 meses', NOW());

INSERT INTO consultas_tratamientos (consultas_idconsultas, tratamientos_idtratamientos) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

SET SQL_SAFE_UPDATES = 0; -- descativa el modo seguro

-- READ

select * from usuario;

select * from citas;

select * from recetas_medicas;

select * from medicos;

select * from consultas;

-- UPDATE 

UPDATE medicos 
SET especialidad = 'Cardiología' 
WHERE idmedicos = 1;

UPDATE citas 
SET estado = 'Cancelada' 
WHERE idcitas = 3;

UPDATE usuario 
SET teléfono = 987654321 
WHERE idusuario = 2;

UPDATE tratamientos 
SET descripcion_tratamiento = 'Terapia física avanzada' 
WHERE idtratamientos = 4;

UPDATE recetas_medicas 
SET fecha_vencimiento = 20251231 
WHERE idrecetas_medicas = 5;

-- DELETE 

delete from usuario where idusuario = 3;

delete from consultas where idconsultas = 10;

delete from recetas_medicas WHERE fecha_vencimiento < 20240306;

DELETE FROM tratamientos WHERE nombre_tratamiento = 'Fisioterapia avanzada';
select * from tratamientos;

DELETE FROM consultas_tratamientos 
WHERE consultas_idconsultas IN (SELECT idconsultas FROM consultas WHERE usuario_idusuario = 1);
