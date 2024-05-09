USE soytech;


SELECT CONCAT('O(A) representante ', 
prospect.representante, 
' da empresa ', 
empresa.nomeEmpresa, 
' localizada no CEP ', 
enderecoEmpresa.cep, 
' número ', 
enderecoEmpresa.numEndereco,
' dona da fazenda ',
fazenda.localidade,
', tem uma conta no nosso site com nome de usuário ',
usuario.usuario,
' e email ',
usuario.email,
'. A sua fazenda tem como parâmetros: umidade mín: ',
parametroFazenda.umidMin,'%',
' máx: ',
parametroFazenda.umidMax, '%',
' temperatura mín: ',
parametroFazenda.tempMin, '°C',
' máx: ',
parametroFazenda.tempMax, '°C',
' e contém como parte dessa fazenda o lote apelidado de ',
lote.apelido
) AS Registro FROM prospect 
JOIN empresa ON empresa.fkProspect = Prospect.idProspect
JOIN enderecoEmpresa ON enderecoEmpresa.fkEmpresa = Empresa.idEmpresa
JOIN fazenda ON fazenda.fkEmpresa = empresa.IdEmpresa
JOIN usuario ON usuario.fkEmpresa = Empresa.idEmpresa
JOIN rootHasFazenda ON rootHasFazenda.fkRoot = Usuario.idUsuario AND rootHasFazenda.fkFazenda = fazenda.idFazenda
JOIN parametroFazenda ON parametroFazenda.fkFazenda = fazenda.idFazenda
JOIN lote ON lote.fkFazenda = fazenda.idFazenda;


-- simulando um cadastro de usuário
SELECT CONCAT('O(A) usuário ',
usuario.usuario,
' email: ',
usuario.email,
' foi cadastrado com sucesso para gerenciar a fazenda ',
fazenda.localidade,
' ☺'
) AS 'Cadastrando usuário' FROM usuario
JOIN fazenda ON fazenda.idFazenda = usuario.fkFazenda WHERE usuario.usuario = 'Pedro';

-- simulando uma alteração dos parâmetros de uma fazenda
SELECT CONCAT('Os parâmetros da fazenda ',
fazenda.localidade,
' foram atualizados para: umidade mín: ',
parametroFazenda.umidMin,'%',
' máx: ',
parametroFazenda.umidMax, '%',
' temperatura mín: ',
parametroFazenda.tempMin, '°C',
' máx: ',
parametroFazenda.tempMax, '°C',
' com sucesso!'
) AS 'Atualização de parâmetro' FROM fazenda
JOIN parametroFazenda ON parametroFazenda.fkFazenda = fazenda.idFazenda WHERE fazenda.localidade = 'Tatuí';