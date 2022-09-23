CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Inventario` (
  `Codigo_Inventario` INT NOT NULL,
  `Productos_Disponibles` VARCHAR(45) NOT NULL,
  `Cantidad_Total` INT NOT NULL,
  PRIMARY KEY (`Codigo_Inventario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `Codigo_Producto` INT NOT NULL,
  `Descripcion_Producto` VARCHAR(120) NOT NULL,
  `Tipo_Producto` VARCHAR(80) NOT NULL,
  `Valor_Producto` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Codigo_Producto`),
  CONSTRAINT `Consulta_Producto_Inventario`
    FOREIGN KEY (`Codigo_Producto`)
    REFERENCES `mydb`.`Inventario` (`Codigo_Inventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stock` (
  `Codigo_Producto` INT NOT NULL,
  `Producto_Stock` INT NOT NULL,
  `Tipo_Producto` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`Codigo_Producto`),
  CONSTRAINT `Consultar_Tipo_Producto`
    FOREIGN KEY (`Producto_Stock`)
    REFERENCES `mydb`.`Producto` (`Codigo_Producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proveedor` (
  `Codigo_Pedidos` INT NOT NULL,
  `Producto_Encargado` VARCHAR(70) NOT NULL,
  `Precio_Producto` VARCHAR(20) NOT NULL,
  `Cantidad_Productos` SMALLINT(3) NOT NULL,
  PRIMARY KEY (`Codigo_Pedidos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Administrador` (
  `Codigo_Administrador` INT NOT NULL,
  `Telefono_Administrador` VARCHAR(20) NOT NULL,
  `Nombre_Administrador` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Codigo_Administrador`),
  CONSTRAINT `Consultar_Tipo_Producto`
    FOREIGN KEY (`Codigo_Administrador`)
    REFERENCES `mydb`.`Stock` (`Codigo_Producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Solicitar_Producto_Pedido`
    FOREIGN KEY (`Codigo_Administrador`)
    REFERENCES `mydb`.`Proveedor` (`Codigo_Pedidos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `Codigo_Usuario` INT NOT NULL,
  `Codigo_Usuario_Rol` INT NOT NULL,
  `Direccion_Usuario` VARCHAR(70) NOT NULL,
  `Nombre_Usuario` VARCHAR(50) NOT NULL,
  `Correo_Usuario` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`Codigo_Usuario`, `Codigo_Usuario_Rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleado` (
  `Codigo_Empleado` INT NOT NULL,
  `Nombre_Empleado` VARCHAR(50) NOT NULL,
  `Cargo_Empleado` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Codigo_Empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Domiciliario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Domiciliario` (
  `Codigo_Domiciliario` INT NOT NULL,
  `Telefono_Domiciliario` VARCHAR(20) NOT NULL,
  `Referencia_Producto_Cliente` INT NOT NULL,
  PRIMARY KEY (`Codigo_Domiciliario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Acceder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Acceder` (
  `Codigo_Rol` INT NOT NULL,
  `Tipo_Rol_Usuario` INT NOT NULL,
  `Tipo_Rol_Administrador` INT NOT NULL,
  `Tipo_Rol_Empleado` INT NOT NULL,
  PRIMARY KEY (`Codigo_Rol`, `Tipo_Rol_Administrador`, `Tipo_Rol_Empleado`, `Tipo_Rol_Usuario`),
  INDEX `Codigo_Cliente_idx` (`Tipo_Rol_Usuario` ASC) VISIBLE,
  INDEX `Acceder_Codigo_Empleado_idx` (`Tipo_Rol_Empleado` ASC) VISIBLE,
  INDEX `Acceder_Codigo_Administrador_idx` (`Tipo_Rol_Administrador` ASC) VISIBLE,
  CONSTRAINT `Acceder_Codigo_Cliente`
    FOREIGN KEY (`Tipo_Rol_Usuario`)
    REFERENCES `mydb`.`Usuario` (`Codigo_Usuario_Rol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Acceder_Codigo_Administrador`
    FOREIGN KEY (`Tipo_Rol_Administrador`)
    REFERENCES `mydb`.`Administrador` (`Codigo_Administrador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Acceder_Codigo_Empleado`
    FOREIGN KEY (`Tipo_Rol_Empleado`)
    REFERENCES `mydb`.`Empleado` (`Codigo_Empleado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Iniciar Sesion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Iniciar Sesion` (
  `Codigo_Usuario` INT NOT NULL,
  `Correo` VARCHAR(80) NOT NULL,
  `Contraseña` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Codigo_Usuario`),
  CONSTRAINT `Iniciar_Usuario`
    FOREIGN KEY (`Codigo_Usuario`)
    REFERENCES `mydb`.`Usuario` (`Codigo_Usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Registro` (
  `Codigo_Usuario` INT NOT NULL,
  `Registro_Correo` VARCHAR(80) NOT NULL,
  `Registro_Contraseña` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Codigo_Usuario`),
  CONSTRAINT `Dar_Codigo_Usuario`
    FOREIGN KEY (`Codigo_Usuario`)
    REFERENCES `mydb`.`Iniciar Sesion` (`Codigo_Usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pago` (
  `Codigo_Pago` INT NOT NULL,
  `Total_Pago` INT NOT NULL,
  `Tipo_Pago` VARCHAR(50) NOT NULL,
  `Referencia_Pedido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codigo_Pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `Codigo_Pedido` INT NOT NULL,
  `Referencia_Pedido` INT NOT NULL,
  `Consultar_Carrito` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Codigo_Pedido`),
  INDEX `Consultar_Referencia_Pedido_idx` (`Referencia_Pedido` ASC) INVISIBLE,
  CONSTRAINT `Consultar_Codigo_Pedido`
    FOREIGN KEY (`Codigo_Pedido`)
    REFERENCES `mydb`.`Pago` (`Codigo_Pago`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Consultar_Referencia_Pedido`
    FOREIGN KEY (`Referencia_Pedido`)
    REFERENCES `mydb`.`Domiciliario` (`Codigo_Domiciliario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Carrito` (
  `Codigo_Carrito` INT NOT NULL,
  `Añadir_Producto` VARCHAR(45) NOT NULL,
  `Productos_Carrito` INT NOT NULL,
  PRIMARY KEY (`Codigo_Carrito`),
  INDEX `Productos_en_Carrito_idx` (`Productos_Carrito` ASC) VISIBLE,
  CONSTRAINT `Codigo_Carrito`
    FOREIGN KEY (`Codigo_Carrito`)
    REFERENCES `mydb`.`Usuario` (`Codigo_Usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Productos_en_Carrito`
    FOREIGN KEY (`Productos_Carrito`)
    REFERENCES `mydb`.`Pedido` (`Codigo_Pedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factura` (
  `Codigo_Factura` INT NOT NULL,
  `Cantidad_Productos` INT NOT NULL,
  `Tipo_Productos` VARCHAR(45) NOT NULL,
  `Valor_Productos` DECIMAL(20) NOT NULL,
  PRIMARY KEY (`Codigo_Factura`),
  CONSTRAINT `Consultar_Codigo_Pago`
    FOREIGN KEY (`Codigo_Factura`)
    REFERENCES `mydb`.`Pago` (`Codigo_Pago`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
