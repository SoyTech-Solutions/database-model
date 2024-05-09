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
	cepRural CHAR(8)
);	


-- funcionarios que pertence a essa empresa
CREATE TABLE usuario(
	idUsuario INT AUTO_INCREMENT,
    usuario VARCHAR(25) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
	cargo VARCHAR(5) NOT NULL DEFAULT 'User',
		CONSTRAINT chkCargo CHECK (cargo IN('User','Admin','Root')),
    fkEmpresa INT,
    fkFazenda INT,
		CONSTRAINT pkEmpresaHasUsuario PRIMARY KEY (idUsuario, fkEmpresa, fkFazenda),
		CONSTRAINT fkEmpresaHasUsuario FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
		CONSTRAINT fkUsuarioHasFazenda FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda)
	
);


-- relação N:M entre Representantes de Empresa e Fazendas;
CREATE TABLE RepresentanteHasFazenda(
	idRepresentanteHasFazenda INT,
    fkUsuario INT,
    fkFazenda INT,
		CONSTRAINT pkRepresentante PRIMARY KEY (idRepresentanteHasFazenda, fkUsuario, fkFazenda),
        CONSTRAINT fkFazenda FOREIGN KEY (fkFazenda) references fazenda(idFazenda),
        CONSTRAINT fkUsuario FOREIGN KEY (fkUsuario) references usuario(idUsuario),
	qtdFazenda INT NOT NULL
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

-- uma fazenda pode ter vários lotes, separando a fazenda
CREATE TABLE lote(
	idLote INT AUTO_INCREMENT,
	qtdHec INT NOT NULL,
	apelido VARCHAR(45) NOT NULL,
	fkFazenda INT,
		CONSTRAINT pkLoteFazenda PRIMARY KEY (idLote, fkFazenda),
		CONSTRAINT fkLoteFazenda FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda)
);

-- sensor cadastrado onde pertence a uma fazenda
-- simulando sua localização apenas por meio de eixo x e y (caso informado)
CREATE TABLE sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(5) NOT NULL,
		CONSTRAINT chkTipo CHECK (tipo in('dht11','lm35')),
	eixoX INT,
    eixoY INT,
	fkLote INT,
		CONSTRAINT sensorHasLote FOREIGN KEY (fkLote) REFERENCES lote(idLote)
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