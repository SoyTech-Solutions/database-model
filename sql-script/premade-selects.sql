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
JOIN empresa ON empresa.fkProspect = prospect.idProspect
JOIN enderecoEmpresa ON enderecoEmpresa.fkEmpresa = empresa.idEmpresa
JOIN fazenda ON fazenda.fkEmpresa = empresa.IdEmpresa
JOIN usuario ON usuario.fkEmpresa = empresa.idEmpresa
JOIN usuarioHasFazenda ON usuarioHasFazenda.fkUsuario = usuario.idUsuario AND usuarioHasFazenda.fkFazenda = fazenda.idFazenda
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


-- Simulando um login
SELECT usuario.idUsuario FROM usuario WHERE usuario.usuario = 'Fernanda' AND usuario.senha = 'fe123';

SELECT fazenda.localidade
FROM usuario
JOIN fazenda ON fazenda.fkEmpresa = usuario.idUsuario
WHERE idUsuario = 1;


-- Histórico de dados
SELECT fazenda.localidade AS 'Fazenda',
lote.apelido AS 'Lote',
sensorLog.dataHora as 'Momento',
sensor.tipo AS 'Sensor',
sensorLog.dadoCapturado AS 'Valor capturado',
sensorLog.critico AS 'Crítico'
FROM fazenda
JOIN lote ON lote.fkFazenda = fazenda.idFazenda
JOIN sensor ON sensor.fkLote = lote.idLote
JOIN sensorLog ON sensorLog.fkSensor = sensor.idSensor 
JOIN usuario ON usuario.fkFazenda = fazenda.idFazenda
WHERE idUsuario = 1
ORDER BY fazenda, lote, momento;



/*
Selects para a API
*/
use soytech;

    select usuario, count(distinct localidade) as qtdFazendas, count(lote.fkFazenda) as qtdTotalLotes from usuario
join usuarioHasFazenda on fkUsuario = idUsuario
join fazenda on idFazenda = usuarioHasFazenda.fkFazenda
join lote on idFazenda = lote.fkFazenda
where idUsuario = '1'
group by usuario;