CREATE DATABASE soytech; -- criando a base de dados
USE soytech; 

-- dados do lead capturado pelos meios de contato
CREATE TABLE prospect(
	idProspect INT PRIMARY KEY AUTO_INCREMENT,
    representante VARCHAR(45) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(13) NOT NULL,
    descricao VARCHAR(500) NOT NULL
);

-- após o prospect, ele se torna nosso cliente, a empresa que representa o comprador da solução
-- como representa o "cliente", "ele" possui o acesso principal, o primeiro acesso verificado para a plataforma
CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    telCorp VARCHAR(13) NOT NULL,
	usuario VARCHAR(25) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(255) NOT NULL,
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

-- funcionarios que pertence a essa empresa
-- cadastrado pelo cliente, usuário "master", autonomia de multiusuários
CREATE TABLE usuario(
	idUsuario INT AUTO_INCREMENT,
    usuario VARCHAR(25) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
	fkEmpresa INT,
		CONSTRAINT pkEmpresaHasUsuario PRIMARY KEY (idUsuario, fkEmpresa),
		CONSTRAINT fkEmpresaHasUsuario FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
	fkMaster INT,
		CONSTRAINT fkUsuario FOREIGN KEY (fkMaster) REFERENCES usuario(idUsuario)
);



-- a fazenda que pertence á essa empresa de produção de soja
-- apenas o acesso "master" pode cadastrar a fazenda ou fazendas
CREATE TABLE fazenda(
	idFazenda INT AUTO_INCREMENT,
    localidade VARCHAR(25) NOT NULL,
    qtdHec INT NOT NULL,
	cepRural CHAR(8),
	fkMaster INT,
		CONSTRAINT pkFazenda PRIMARY KEY (idFazenda, fkMaster)
);	

-- parametros dos sensores em cada fazenda
CREATE TABLE parametroFazenda(
	idParametroFazenda INT AUTO_INCREMENT,
	umidMin INT,
	umidMax INT,
	tempMin DECIMAL(5,2),
	tempMax DECIMAL(5,2),
	fkFazenda INT,
		CONSTRAINT fkParametroFazenda FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda),
        CONSTRAINT pkParametroFazenda PRIMARY KEY (idParametroFazenda,fkFazenda)
);

CREATE TABLE lote(
	idLote INT AUTO_INCREMENT,
	qtdHec INT NOT NULL,
	apelido VARCHAR(45) NOT NULL,
	fkFazenda INT,
		CONSTRAINT pkLoteFazenda PRIMARY KEY (idLote, fkFazenda),
		CONSTRAINT fkLoteFazenda FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda)
);

-- sensor cadastrado onde pertence a uma fazenda
-- simulando sua localização apenas por meio de eixo x e y
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
    critico BOOL,
	fkSensor INT,
		CONSTRAINT pkSensorHasSensorLog PRIMARY KEY (idSensorLog,fkSensor),
        CONSTRAINT fkSensorHasSensorLog FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);