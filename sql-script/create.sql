USE soytech;

-- lead capturado
INSERT INTO prospect VALUE
	(DEFAULT,'Fernanda Caramico','SPTech School','fernanda.caramico@sptech.school','11940028922','Olá, estou interessado em obter mais informações sobre os seus produtos e serviços. Você poderia me fornecer mais detalhes?');

-- lead capturado convertido -> cliente = empresa
INSERT INTO empresa VALUE
	(DEFAULT,'SPTech School','Educare Tecnologia da Informacao S.a','551135894043','sptech#20241','educare.tecnologia@company.com','#GfSptech','07165496000100', 1);

-- endereço da empresa
INSERT INTO enderecoEmpresa VALUE
	(DEFAULT,'1414905','595','Em frente à Starbucks', 1);
    
-- fazenda que pertence á este usuario master, representante
INSERT INTO fazenda VALUE 
	(DEFAULT, 'Boituva',25,'18559899', 1),
    (DEFAULT, 'Tatuí',30,'18282899', 1),
    (DEFAULT, 'Jales',40,'15709899', 1);    

-- usuario MASTER da empresa
INSERT INTO usuario VALUE 
	(DEFAULT, 'Fernanda', 'fernanda.caramico@sptech.school', 'fe123', 1, null),
    (DEFAULT, 'Rafael', 'rafael.brandao@sptech.school', 'rafa123', 1, 1);
    
-- parametros da fazenda 
INSERT INTO parametroFazenda VALUE 
	(DEFAULT, 12, 14.5, 20.00, 30.00, 1);
    
-- Parte da fazenda, fragmento em lotes
INSERT INTO lote VALUE 
	(DEFAULT, 10, 'lote 1x', 1),
    (DEFAULT, 10, 'lote 1y', 1),
    (DEFAULT, 5, 'lote 1z', 1),
    (DEFAULT, 10, 'lote 2x', 2),
    (DEFAULT, 10, 'lote 2y', 2),
    (DEFAULT, 10, 'lote 2z', 2),
    (DEFAULT, 20, 'lote 3x', 3),
    (DEFAULT, 20, 'lote 3y', 3);
    
-- sensor que esta alocado dentro dos lotes
INSERT INTO sensor VALUE
	(DEFAULT, 'dht11', 5,5, 1),
    (DEFAULT, 'lm35', 5,6, 1),
	(DEFAULT, 'dht11', 5,5, 2),
    (DEFAULT, 'lm35', 5,6, 2),
	(DEFAULT, 'dht11', 5,5, 3),
    (DEFAULT, 'lm35', 5,6, 3);
    
	-- ======= simulando os dados sendo inseridos =========
-- alterando entre dados capturado do sensor 1 e 2 (dht11,lm35) que estao no lote 1 da fazenda 1
-- intervalo de 1 minuto para cada medição
-- variação randomica
INSERT INTO sensorLog VALUES
	(DEFAULT, 35.50, '2024-04-12 23:39:30', 0, 1), --
	(DEFAULT, 25.50, '2024-04-12 23:39:30', 0, 2),
    (DEFAULT, 36.50, '2024-04-12 23:40:30', 0, 1), --
	(DEFAULT, 26.20, '2024-04-12 23:40:30', 0, 2),
    (DEFAULT, 36.50, '2024-04-12 23:41:30', 0, 1), --
	(DEFAULT, 24.80, '2024-04-12 23:41:30', 0, 2),
    (DEFAULT, 37.50, '2024-04-12 23:42:30', 0, 1), --
	(DEFAULT, 25.70, '2024-04-12 23:42:30', 0, 2),
    (DEFAULT, 36.50, '2024-04-12 23:43:30', 0, 1), --
	(DEFAULT, 26.50, '2024-04-12 23:43:30', 0, 2),
    (DEFAULT, 36.50, '2024-04-12 23:44:30', 0, 1), --
	(DEFAULT, 24.90, '2024-04-12 23:44:30', 0, 2),
    (DEFAULT, 34.50, '2024-04-12 23:45:30', 0, 1), --
	(DEFAULT, 25.80, '2024-04-12 23:45:30', 0, 2),
    (DEFAULT, 37.50, '2024-04-12 23:46:30', 0, 1), --
	(DEFAULT, 25.30, '2024-04-12 23:46:30', 0, 2),
    (DEFAULT, 37.50, '2024-04-12 23:47:30', 0, 1), --
	(DEFAULT, 26.10, '2024-04-12 23:47:30', 0, 2),
    (DEFAULT, 36.50, '2024-04-12 23:48:30', 0, 1), --
	(DEFAULT, 24.60, '2024-04-12 23:48:30', 0, 2);
    
    

    
