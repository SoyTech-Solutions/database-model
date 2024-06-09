CREATE DATABASE soytech; -- criando a base de dados
USE soytech; 

-- dados do lead capturado pelos meios de contato
CREATE TABLE prospect(
	idProspect INT PRIMARY KEY AUTO_INCREMENT,
    representante VARCHAR(45) NOT NULL,
    nomeEmpresa VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(13) NOT NULL,
    descricao VARCHAR(500) NOT NULL
);

-- após o prospect, caso seja aprovado por nós, ele se torna nosso cliente, a empresa que representa o comprador da solução
CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(45) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    telCorp VARCHAR(13) NOT NULL,
    emailCorp VARCHAR(100) NOT NULL UNIQUE,
    cnpj CHAR(14) NOT NULL,
    fkProspect INT,
		CONSTRAINT fkEmpresaHasProspect FOREIGN KEY (fkProspect) REFERENCES prospect(idProspect)
);

-- essa empresa possui endereço
CREATE TABLE enderecoEmpresa(
	idEnderecoEmpresa INT AUTO_INCREMENT,
	cep CHAR(8) NOT NULL,
	numEndereco VARCHAR(8) NOT NULL,
    complemento VARCHAR(45),
	fkEmpresa INT,
		CONSTRAINT pkEnderecoEmpresa PRIMARY KEY (idEnderecoEmpresa, fkEmpresa),
        CONSTRAINT fkEmpresaHasEndereco FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);


-- a fazenda que pertence á essa empresa de produção de soja
CREATE TABLE fazenda(
	idFazenda INT PRIMARY KEY AUTO_INCREMENT,
    localidade VARCHAR(25) NOT NULL,
    qtdHec INT NOT NULL,
	cepRural CHAR(8),
    fkEmpresa INT,
		CONSTRAINT fkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);	


-- funcionarios que pertence a essa empresa
CREATE TABLE usuario(
	idUsuario INT AUTO_INCREMENT,
    usuario VARCHAR(25) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    administrador bool,
    fkEmpresa INT,
    fkFazenda INT,
		CONSTRAINT pkEmpresaHasUsuario PRIMARY KEY (idUsuario, fkEmpresa),
		CONSTRAINT fkEmpresaHasUsuario FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
		CONSTRAINT fkUsuarioHasFazenda FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda)
);


CREATE TABLE usuarioHasFazenda (
	idUsuarioHasFazenda INT AUTO_INCREMENT,
    fkUsuario INT,
    fkFazenda INT,
		CONSTRAINT pkUsuarioFazenda PRIMARY KEY (idUsuarioHasFazenda, fkUsuario, fkFazenda),
        CONSTRAINT fkRoot FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
        CONSTRAINT fkFazenda FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda)
);


-- parametros dos sensores em cada fazenda
CREATE TABLE parametroFazenda(
	idParametroFazenda INT AUTO_INCREMENT,
	umidMin DECIMAL(5,2),
	umidMax DECIMAL(5,2),
	tempMin DECIMAL(5,2),
	tempMax DECIMAL(5,2),
	fkFazenda INT,
		CONSTRAINT fkParametroFazenda FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda),
        CONSTRAINT pkParametroFazenda PRIMARY KEY (idParametroFazenda,fkFazenda)
);

-- sensor cadastrado onde pertence a uma fazenda
-- simulando sua localização apenas por meio de eixo x e y (caso informado)
CREATE TABLE sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(5) NOT NULL,
		CONSTRAINT chkTipo CHECK (tipo in('dht11','lm35')),
	eixoX INT,
    eixoY INT,
	fkFazenda INT,
		CONSTRAINT sensorHasFazenda FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda)
);


-- dados capturados 
-- que pertence a algum sensor
CREATE TABLE sensorLog(
	idSensorLog INT AUTO_INCREMENT,
    dadoCapturado DECIMAL(5,2) NOT NULL,
    dataHora DATETIME NOT NULL,
    critico TINYINT,
	fkSensor INT,
		CONSTRAINT pkSensorHasSensorLog PRIMARY KEY (idSensorLog,fkSensor),
        CONSTRAINT fkSensorHasSensorLog FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

SELECT * FROM sensorLog;
-- drop database soytech;