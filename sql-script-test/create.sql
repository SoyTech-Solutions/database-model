USE soytech;


-- lead capturado
INSERT INTO prospect VALUE
	(DEFAULT,'Fernanda Caramico','SPTech School','fernanda.caramico@sptech.school','11940028922','Olá, estou interessado em obter mais informações sobre os seus produtos e serviços. Você poderia me fornecer mais detalhes?');


-- lead capturado convertido -> cliente = empresa
INSERT INTO empresa VALUE
	(DEFAULT,'SPTech School','Educare Tecnologia da Informacao S.a','551135894043','educare.tecnologia@company.com','07165496000100', 1);


-- endereço da empresa
INSERT INTO enderecoEmpresa VALUE
	(DEFAULT,'1414905','595','Em frente à Starbucks', 1);
    
    
-- fazenda que pertencente a este representante
INSERT INTO fazenda VALUE 
	(DEFAULT, 'Boituva',25,'18559899', 1),
    (DEFAULT, 'Tatuí',30,'18282899', 1);


-- usuarios da empresa
INSERT INTO usuario VALUE 
	(DEFAULT, 'Fernanda', 'fernanda.caramico@sptech.school', 'fe123', 'Root', 1, 1),
    (DEFAULT, 'Rafael', 'rafael.brandao@sptech.school', 'rafa123', 'Admin', 1, 1),
	(DEFAULT, 'Fernando', 'fernando.souza@sptech.school', 'nando123', 'Admin', 1, 2),
    (DEFAULT, 'Julia', 'julia.duda@sptech.school', 'ju123', 'User', 1, 1),
	(DEFAULT, 'Pedro', 'pedro.santos@sptech.school', 'pedrao123', 'User', 1, 1),
    (DEFAULT, 'Lais', 'lais.figueroa@sptech.school', 'lala123', 'User', 1, 2);
    -- Ordem das fk's: fkEmpresa em que trabalha, fkFazenda em que está gerenciando (caso seja o Root, será a idFazenda da primeira fazenda cadastrada),
    
    -- ROOT das fazendas, um ROOT pode gerenciar muitas fazendas, e uma fazenda pode ser gerenciada por muitos Usuarios
    INSERT INTO rootHasFazenda VALUE
	(1, 1, 1),
    (1, 1, 2);
    -- id, Root, Fazenda
    
    
-- parametros da fazenda 
INSERT INTO parametroFazenda VALUE 
	(DEFAULT, 12, 14.5, 20.00, 30.00, 1),
    (DEFAULT, 13, 14, 23, 27, 2);
    
    
-- Parte da fazenda, fragmento em lotes
INSERT INTO lote VALUE 
	(DEFAULT, 10, 'lote 1x', 1),
    (DEFAULT, 10, 'lote 1y', 1),
    (DEFAULT, 5, 'lote 1z', 1),
    (DEFAULT, 10, 'lote 2x', 2), -- Sem sensor
    (DEFAULT, 10, 'lote 2y', 2), -- Sem sensor
    (DEFAULT, 10, 'lote 2z', 2); -- Sem sensor
    
    
-- sensor que esta alocado dentro dos lotes
INSERT INTO sensor VALUE
	(DEFAULT, 'dht11', 5,5, 1),
    (DEFAULT, 'lm35', 5,6, 1),
	(DEFAULT, 'dht11', 5,5, 2),
    (DEFAULT, 'lm35', 5,6, 2),
	(DEFAULT, 'dht11', 5,5, 3),
    (DEFAULT, 'lm35', 5,6, 3);