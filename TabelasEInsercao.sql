CREATE DATABASE oficina;

USE oficina; 

-- Criação da Tabela Cliente - OK
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Documento` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Documento_UNIQUE` (`Documento` ASC) VISIBLE)
ENGINE = InnoDB;

-- Inserção de dados Cliente - OK
INSERT INTO `oficina`.`cliente` (`idCliente`, `Nome`, `Documento`, `Endereco`, `Telefone`, `Email`) 
	VALUES ('1', 'Maria da Silva', '12345678910', 'Rua das Flores, 123, São Paulo, SP', '11 1234-5678', 'maria@mail.com'),
			('2', 'João Santos', '98765432110', 'Rua das Árvores, 321, São Paulo, SP', '11 9874-5612', 'joao@mail.com'),
			('3', 'Pedro Souza', '65432198710', 'Av. do Céu, 987, São Paulo, SP', '11 4321-9876', 'pedro@mail.com'),
			('4', 'Ana Silveira', '32165498710', 'Al. da Terra, 456, São Paulo, SP', '11 4567-1234', 'ana@mail.com'),
			('5', 'Joana Oliveira', '45678912310', 'Av. das Águas, São Paulo, SP', '11 1478-5236', 'joana@mail.com');

SELECT * FROM cliente;

-- Criação Tabela Equipe de Mecanicos - OK

CREATE TABLE IF NOT EXISTS `EquipeDeMecanicos` (
  `idEquipeDeMecanicos` INT NOT NULL,
  `Especialidade` VARCHAR(45) NULL,
  PRIMARY KEY (`idEquipeDeMecanicos`))
ENGINE = InnoDB;

-- Inserção de dados Equipe de Mecanicos - OK

INSERT INTO `oficina`.`equipedemecanicos` (`idEquipeDeMecanicos`, `Especialidade`) 
	VALUES ('1', 'Funilaria'),
			('2', 'Motor'),
			('3', 'Pneus'),
			('4', 'Câmbio'),
			('6', 'Manutenção');
            
-- Criação Tabela Mecanicos - OK
CREATE TABLE IF NOT EXISTS `Mecanico` (
  `idMecanico` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  `EquipeDeMecanicos_idEquipeDeMecanicos` INT NOT NULL,
  PRIMARY KEY (`idMecanico`),
  INDEX `fk_Mecanico_EquipeDeMecanicos1_idx` (`EquipeDeMecanicos_idEquipeDeMecanicos` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_EquipeDeMecanicos1`
    FOREIGN KEY (`EquipeDeMecanicos_idEquipeDeMecanicos`)
    REFERENCES `EquipeDeMecanicos` (`idEquipeDeMecanicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserção de dados Mecanicos - OK

INSERT INTO `oficina`.`mecanico` (`idMecanico`, `Nome`, `Endereço`, `Especialidade`, `EquipeDeMecanicos_idEquipeDeMecanicos`) 
	VALUES ('1', 'João Santos', 'Rua Um, 123, São Paulo, SP', 'Funilaria', '1'),
			('2', 'Henriqueta Silva', 'Rua Dois, 321, São Paulo, SP','Manutenção', '6'),
			('3', 'Josefina de Tal', 'Rua Três, 456, São Paulo, SP', 'Funilaria', '1'),
			('4', 'Bruna Corsi', 'Rua Quatro, 654, São Paulo, SP', 'Pneus', '3'),
			('5', 'Mario Monteiro', 'Rua Cinco, 789, São Paulo, SP', 'Motor', '2'),
			('6', 'Angelo Vergueiro', 'Rua Seis, 987, São Paulo, SP', 'Câmbio', '4'),
			('7', 'Carla Lentino', 'Rua Sete, 147, São Paulo, SP', 'Motor', '2'),
			('8', 'Filipe Soares', 'Rua Oito, 258, São Paulo, SP', 'Pneus', '3'),
			('9', 'Francisco Alves', 'Rua Nove, 369, São Paulo, SP', 'Manutenção', '6');
 
 -- Criação Tabela Ordem De Serviço - OK
 
 CREATE TABLE IF NOT EXISTS `OrdemDeServico` (
  `idOrdemDeServico` INT NOT NULL,
  `DataEmissao` DATETIME NULL,
  `ValorTotal` FLOAT NULL,
  `Status` VARCHAR(45) NULL,
  `PrevisaoDeFinalizacao` DATETIME NULL,
  `EquipeDeMecanicos_idEquipeDeMecanicos` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `AutorizacaoCliente` BIT(1) NULL,
  PRIMARY KEY (`idOrdemDeServico`, `EquipeDeMecanicos_idEquipeDeMecanicos`, `Cliente_idCliente`),
  INDEX `fk_OrdemDeServico_EquipeDeMecanicos1_idx` (`EquipeDeMecanicos_idEquipeDeMecanicos` ASC) VISIBLE,
  INDEX `fk_OrdemDeServico_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_OrdemDeServico_EquipeDeMecanicos1`
    FOREIGN KEY (`EquipeDeMecanicos_idEquipeDeMecanicos`)
    REFERENCES `EquipeDeMecanicos` (`idEquipeDeMecanicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdemDeServico_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

Select * from OrdemDeServico;

-- Criação Tabela Veiculo - OK

CREATE TABLE IF NOT EXISTS `Veiculo` (
  `idVeiculo` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `EquipeDeMecanicos_idEquipeDeMecanicos` INT NOT NULL,
  `Placa` VARCHAR(45) NULL,
  `Marca` VARCHAR(45) NULL,
  `Cor` VARCHAR(45) NULL,
  `Ano` INT NULL,
  PRIMARY KEY (`idVeiculo`, `Cliente_idCliente`, `EquipeDeMecanicos_idEquipeDeMecanicos`),
  INDEX `fk_Veiculo_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Veiculo_EquipeDeMecanicos1_idx` (`EquipeDeMecanicos_idEquipeDeMecanicos` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veiculo_EquipeDeMecanicos1`
    FOREIGN KEY (`EquipeDeMecanicos_idEquipeDeMecanicos`)
    REFERENCES `EquipeDeMecanicos` (`idEquipeDeMecanicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserção de dados Veiculo - OK
INSERT INTO `oficina`.`veiculo` (`idVeiculo`, `Cliente_idCliente`, `EquipeDeMecanicos_idEquipeDeMecanicos`, `Placa`, `Marca`, `Cor`, `Ano`) 
	VALUES ('1', '1', '6', 'ABC-1234', 'Fiat', 'Vermelho', '2020'),
			('2', '2', '4', 'QWE-7896', 'Chevrolet', 'Vermelho', '2019'),
			('3', '3', '6', 'ASD-3698', 'Fiat', 'Preto', '2020'),
			('4', '4', '3', 'UIO-4563', 'Land Rover', 'Cinza', '2019'),
			('5', '5', '1', 'ZXC-9874', 'Fiat', 'Cinza', '2015');
   
 Select * from veiculo;  
           
  -- Criação Tabela Serviço
  
CREATE TABLE IF NOT EXISTS `Servico` (
  `idServico` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB;

-- Inserção de dados da tabela Serviço

INSERT INTO `oficina`.`servico` (`idServico`, `Descricao`, `Valor`) 
	VALUES ('1', 'Funilaria', '100'),
			('2', 'Motor', '500'),
			('3', 'Pneus', '75'),
			('4', 'Câmbio', '45'),
			('6', 'Manutenção', '30');
            
SELECT * FROM servico;

-- Criação tabela Peça 

CREATE TABLE IF NOT EXISTS `Peca` (
  `idPeca` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  `ValorUnitario` FLOAT NULL,
  PRIMARY KEY (`idPeca`))
ENGINE = InnoDB;

-- Inserçao de dados de Peças

INSERT INTO `oficina`.`peca` (`idPeca`, `Descricao`, `ValorUnitario`) 
	VALUES ('1', 'Kit Funilaria', '900'),
			('2', 'Motor automotivo', '4500'),
			('3', 'Pneu', '168.75'),
			('4', 'Kit Câmbio', '405'),
			('5', 'Kit Manutenção', '270');

-- Criação da Tabela EstoquePeças

CREATE TABLE IF NOT EXISTS `EstoqueDePecas` (
  `idEstoqueDePecas` INT NOT NULL,
  `Quantidade` INT NULL,
  `Peca_idPeca` INT NOT NULL,
  PRIMARY KEY (`idEstoqueDePecas`, `Peca_idPeca`),
  INDEX `fk_EstoqueDePecas_Peca1_idx` (`Peca_idPeca` ASC) VISIBLE,
  CONSTRAINT `fk_EstoqueDePecas_Peca1`
    FOREIGN KEY (`Peca_idPeca`)
    REFERENCES `Peca` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Inserção de Dados EstoqueDePeças

INSERT INTO `oficina`.`estoquedepecas` (`idEstoqueDePecas`, `Quantidade`, `Peca_idPeca`) VALUES ('1', '100', '1');
INSERT INTO `oficina`.`estoquedepecas` (`idEstoqueDePecas`, `Quantidade`, `Peca_idPeca`) VALUES ('2', '100', '2');
INSERT INTO `oficina`.`estoquedepecas` (`idEstoqueDePecas`, `Quantidade`, `Peca_idPeca`) VALUES ('3', '100', '3');
INSERT INTO `oficina`.`estoquedepecas` (`idEstoqueDePecas`, `Quantidade`, `Peca_idPeca`) VALUES ('4', '100', '4');
INSERT INTO `oficina`.`estoquedepecas` (`idEstoqueDePecas`, `Quantidade`, `Peca_idPeca`) VALUES ('5', '100', '5');

-- Criação Tabela Peças por Ordem de Serviço

CREATE TABLE IF NOT EXISTS `OrdemDeServico_has_Peca` (
  `OrdemDeServico_idOrdemDeServico` INT NOT NULL,
  `Peca_idPeca` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  INDEX `fk_OrdemDeServico_has_Peca_Peca1_idx` (`Peca_idPeca` ASC) VISIBLE,
  INDEX `fk_OrdemDeServico_has_Peca_OrdemDeServico1_idx` (`OrdemDeServico_idOrdemDeServico` ASC) VISIBLE,
  CONSTRAINT `fk_OrdemDeServico_has_Peca_OrdemDeServico1`
    FOREIGN KEY (`OrdemDeServico_idOrdemDeServico`)
    REFERENCES `OrdemDeServico` (`idOrdemDeServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdemDeServico_has_Peca_Peca1`
    FOREIGN KEY (`Peca_idPeca`)
    REFERENCES `Peca` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserção de dados Peças por Ordem de Serviço

INSERT INTO `oficina`.`ordemdeservico_has_peca` (`OrdemDeServico_idOrdemDeServico`, `Peca_idPeca`, `Quantidade`) 
VALUES ('1', '1', '1'),
		('2', '3', '4'),
		('3', '5', '1'),
		('4', '4', '1'),
		('5', '5', '1');

-- Criação tabela Peças por Serviço

CREATE TABLE IF NOT EXISTS `ServicoUtilizaPeca` (
  `Servico_idServico` INT NOT NULL,
  `Peca_idPeca` INT NOT NULL,
  PRIMARY KEY (`Servico_idServico`),
  INDEX `fk_Servico_has_Peca_Peca1_idx` (`Peca_idPeca` ASC) VISIBLE,
  INDEX `fk_Servico_has_Peca_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_has_Peca_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Peca_Peca1`
    FOREIGN KEY (`Peca_idPeca`)
    REFERENCES `Peca` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserção de dados Peças por Serviço

INSERT INTO `oficina`.`servicoutilizapeca` (`Servico_idServico`, `Peca_idPeca`) 
	VALUES ('1', '1'),
			('2', '2'),
			('3', '3'),
			('4', '4'),
			('6', '5');

-- Criação da tabela de Mão de Obra

CREATE TABLE IF NOT EXISTS `MaoDeObra` (
  `EquipeDeMecanicos_idEquipeDeMecanicos` INT NOT NULL,
  `Servico_idServico` INT NOT NULL,
  PRIMARY KEY (`EquipeDeMecanicos_idEquipeDeMecanicos`),
  INDEX `fk_Servico_has_EquipeDeMecanicos_EquipeDeMecanicos1_idx` (`EquipeDeMecanicos_idEquipeDeMecanicos` ASC) VISIBLE,
  INDEX `fk_Servico_has_EquipeDeMecanicos_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_has_EquipeDeMecanicos_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_EquipeDeMecanicos_EquipeDeMecanicos1`
    FOREIGN KEY (`EquipeDeMecanicos_idEquipeDeMecanicos`)
    REFERENCES `EquipeDeMecanicos` (`idEquipeDeMecanicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserção de dados de Mao de Obra

INSERT INTO `oficina`.`maodeobra` (`EquipeDeMecanicos_idEquipeDeMecanicos`, `Servico_idServico`) 
		VALUES ('1', '1'),
				('2', '2'),
				('3', '3'),
				('4', '4'),
				('6', '6');

-- Criação Tabela OrdemDeServicoHasServico

CREATE TABLE IF NOT EXISTS `OrdemDeServico_has_Servico` (
  `OrdemDeServico_idOrdemDeServico` INT NOT NULL,
  `Servico_idServico` INT NOT NULL,
  INDEX `fk_OrdemDeServico_has_Servico_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  INDEX `fk_OrdemDeServico_has_Servico_OrdemDeServico1_idx` (`OrdemDeServico_idOrdemDeServico` ASC) VISIBLE,
  PRIMARY KEY (`OrdemDeServico_idOrdemDeServico`),
  CONSTRAINT `fk_OrdemDeServico_has_Servico_OrdemDeServico1`
    FOREIGN KEY (`OrdemDeServico_idOrdemDeServico`)
    REFERENCES `OrdemDeServico` (`idOrdemDeServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdemDeServico_has_Servico_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Inserção Dados OrdemDeServicoHasServico

INSERT INTO `oficina`.`ordemdeservico_has_servico` (`OrdemDeServico_idOrdemDeServico`, `Servico_idServico`) 
	VALUES ('1', '6'),
			('2', '4'),
			('3', '6'),
			('4', '3'),
			('5', '1');
