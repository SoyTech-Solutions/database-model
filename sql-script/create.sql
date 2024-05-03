USE soytech;

-- lead capturado
INSERT INTO prospect VALUE
	(DEFAULT,'Fernanda Caramico','SPTech School','fernanda.caramico@sptech.school','11940028922','Olá, estou interessado em obter mais informações sobre os seus produtos e serviços. Você poderia me fornecer mais detalhes?');
    
-- lead capturado convertido -> cliente = empresa
INSERT INTO empresa VALUE
	(DEFAULT,'SPTech School','Educare Tecnologia da Informacao S.a','11900001111','educare.tecnologia@company.com','07165496000100', 'Fernanda', '12345', 1);
    
-- endereço da empresa
INSERT INTO enderecoEmpresa VALUE
	(DEFAULT,'1414905','595','Em frente à Starbucks', 1);
    
-- usuario/funcionarios da empresa
INSERT INTO usuario VALUE 
	(DEFAULT, 'Fernanda', 'fernanda.caramico@sptech.school', '12345', 'Proprietária', 1, null);

-- fazenda que pertence a essa empresa
INSERT INTO fazenda VALUE 
	(DEFAULT, 1, 20, 01234567);

-- Parte da fazenda
INSERT INTO lote VALUE 
	(DEFAULT, 1, 10, 'fazenda1'),
    (DEFAULT, 1, 10, 'fazenda2');

INSERT INTO sensor VALUE
	(DEFAULT, 'dht11', 1),
    (DEFAULT, 'lm35', 1);
    
INSERT INTO parametro VALUE 
	(DEFAULT, 12, 14.5, 20.00, 30.00, 1);