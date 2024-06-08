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
    (DEFAULT, 'Tatuí',30,'18282899', 1),
    (DEFAULT, 'Jales',40,'15709899',1);


-- usuarios da empresa
INSERT INTO usuario VALUE 
	(DEFAULT, 'Fernanda', 'fernanda.caramico@sptech.school', 'fe123', 1, 1),
    (DEFAULT, 'Rafael', 'rafael.brandao@sptech.school', 'rafa123', 1, 1),
	(DEFAULT, 'Fernando', 'fernando.souza@sptech.school', 'nando123', 1, 2),
    (DEFAULT, 'Julia', 'julia.duda@sptech.school', 'ju123', 1, 1),
	(DEFAULT, 'Pedro', 'pedro.santos@sptech.school', 'pedrao123', 1, 1),
    (DEFAULT, 'Lais', 'lais.figueroa@sptech.school', 'lala123', 1, 2);
    -- Ordem das fk's: fkEmpresa em que trabalha, fkFazenda em que está gerenciando (caso seja o Root, será a idFazenda da primeira fazenda cadastrada),
    
    -- Usuario das fazendas, um Usuario pode gerenciar muitas fazendas, e uma fazenda pode ser gerenciada por muitos Usuarios
    INSERT INTO usuarioHasFazenda VALUE
	(1, 1, 1),
    (1, 1, 2),
    (1, 2, 1),
    (1, 3, 2),
    (1, 4, 1),
    (1, 5, 2),
    (1, 6, 2);
    -- id, Usuario, Fazenda
    
-- parametros da fazenda 
INSERT INTO parametroFazenda VALUE 
	(DEFAULT, 12, 14.5, 20.00, 30.00, 1),
    (DEFAULT, 13, 14, 23, 27, 2);
    
-- sensor que esta alocado dentro das fazendas
INSERT INTO sensor VALUE
	(DEFAULT, 'dht11', 5,5, 1),
    (DEFAULT, 'lm35', 5,6, 1),
	(DEFAULT, 'dht11', 5,5, 2),
    (DEFAULT, 'lm35', 5,6, 2),
	(DEFAULT, 'dht11', 5,5, 3),
    (DEFAULT, 'lm35', 5,6, 3);