create database peopleCocer;

use peopleCocer;

create table personas (
    id int primary key not null auto_increment,
    nombre varchar(250) not null,
    apellido_p varchar(250) not null,
    apellido_m varchar(250) not null,
    correo varchar(250) not null ,
    contrasena varchar(250) not null ,
    telefono varchar(12) not null ,
    edad int not null
);


CREATE TABLE bitacora (
    id_bitacora INT PRIMARY KEY AUTO_INCREMENT,
    persona_id INT NOT NULL,
    dia_realizado DATETIME NOT NULL,
    operacion varchar(250) NOT NULL ,
    FOREIGN KEY (persona_id) REFERENCES personas(id) ON DELETE CASCADE
);


INSERT INTO personas (nombre, apellido_p, apellido_m, correo, contrasena, telefono, edad)
VALUES ('admin', 'admin', 'admin', 'admin@gmail.com', sha1('Admin12$'), '5551234567', 30);