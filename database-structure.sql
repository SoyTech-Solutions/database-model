CREATE DATABASE soytech; -- criando a base de dados
USE soytech; 

-- dados do lead capturado pelos meios de contato
CREATE TABLE prospect(
	idProspect INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    razaoSocial VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(13),
    descricao VARCHAR(500)
);

-- após o prospect, ele se torna nosso cliente, a empresa que representa o comprador da solução
-- como representa o "cliente", "ele" possui o acesso principal, o primeiro acesso verificado para a plataforma
CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    razaoSocial VARCHAR(100),
    telCorp VARCHAR(13),
    email VARCHAR(100),
    cnpj CHAR(14),
    fkProspect INT,
		CONSTRAINT fkEmpresaHasProspect FOREIGN KEY (fkProspect) REFERENCES prospect(idProspect)
);

-- essa empresa possui endereço
CREATE TABLE enderecoEmpresa(
	idEnderecoEmpresa INT AUTO_INCREMENT,
	cep CHAR(8),
	numEndereco VARCHAR(8),
    complemento VARCHAR(45),
	fkEmpresa INT,
		CONSTRAINT pkEnderecoEmpresa PRIMARY KEY (idEnderecoEmpresa, fkEmpresa),
        CONSTRAINT fkEmpresaHasEndereco FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- a fazenda que pertence á essa empresa de produção de soja
-- apenas o acesso "master" pode cadastrar a fazenda ou fazendas
CREATE TABLE fazenda(
	idFazenda INT AUTO_INCREMENT,
	larguraHec INT,
    alturaHec INT,
	fkEmpresa INT,
		CONSTRAINT pkEmpresaHasFazenda PRIMARY KEY (idFazenda,fkEmpresa),
        CONSTRAINT fkEmpresaHasFazenda FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);	

-- funcionarios que pertence a essa empresa
-- cadastrado pelo cliente, usuário "master", autonomia de multiusuários
CREATE TABLE funcionario(
	idFuncionario INT AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(100),
    senha VARCHAR(255),
	fkEmpresa INT,
		CONSTRAINT pkEmpresaHasFuncionario PRIMARY KEY (idFuncionario, fkEmpresa),
		CONSTRAINT fkEmpresaHasFuncionario FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
	fkRepresentante INT,
    CONSTRAINT fkfuncionario FOREIGN KEY (fkRepresentante) REFERENCES funcionario(idFuncionario)
);

-- sensor cadastrado onde pertence a uma fazenda
-- simulando sua localização apenas por meio de eixo x e y
CREATE TABLE sensor(
	idSensor INT AUTO_INCREMENT,
    tipo VARCHAR(5) NOT NULL,
		CONSTRAINT chkTipo CHECK (tipo in('dht11','lm35')),
	eixoX INT,
    eixoY INT,
    minIdeal DECIMAL(5,2) NOT NULL,
    maxIdeal DECIMAL(5,2) NOT NULL,
	fkFazenda INT,
		CONSTRAINT pkFazendaHasSensor PRIMARY KEY (idSensor,fkFazenda),
		CONSTRAINT fkFazendaHasSensor FOREIGN KEY (fkFazenda) REFERENCES fazenda(idFazenda)
);

-- dados capturados 
-- que pertence a algum sensor
CREATE TABLE sensorLog(
	idSensorLog INT AUTO_INCREMENT,
    dadoCapturado DECIMAL(5,2),
    dataHora DATETIME,
	fkSensor INT,
		CONSTRAINT pkSensorHasSensorLog PRIMARY KEY (idSensorLog,fkSensor),
        CONSTRAINT fkSensorHasSensorLog FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);
