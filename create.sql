USE soytech;

-- lead capturado
INSERT INTO prospect VALUE
	(DEFAULT,'Fernanda Caramico','SPTech School','fernanda.caramico@sptech.school','11940028922','Olá, estou interessado em obter mais informações sobre os seus produtos e serviços. Você poderia me fornecer mais detalhes?');
    
-- lead capturado convertido -> cliente = empresa
INSERT INTO empresa VALUE
	(DEFAULT,'SPTech School','Educare Tecnologia da Informacao S.a','11900001111','educare.tecnologia@company.com','07165496000100','#Gfsptech',1);
    
-- endereço da empresa
INSERT INTO enderecoEmpresa VALUE
	(DEFAULT,'1414905','595','Em frente à Starbucks', 1);

-- fazenda que pertence a essa empresa
INSERT INTO fazenda VALUE 
	(DEFAULT, 500, 500, 1);
