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
parametroFazenda.tempMax, '°C'
) AS Registro FROM prospect 
JOIN empresa ON empresa.fkProspect = prospect.idProspect
JOIN enderecoEmpresa ON enderecoEmpresa.fkEmpresa = empresa.idEmpresa
JOIN fazenda ON fazenda.fkEmpresa = empresa.IdEmpresa
JOIN usuario ON usuario.fkEmpresa = empresa.idEmpresa
JOIN usuarioHasFazenda ON usuarioHasFazenda.fkUsuario = usuario.idUsuario AND usuarioHasFazenda.fkFazenda = fazenda.idFazenda
JOIN parametroFazenda ON parametroFazenda.fkFazenda = fazenda.idFazenda;


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
SELECT usuario.idUsuario as id FROM usuario WHERE usuario.usuario = 'Fernanda' AND usuario.senha = 'fe123';

SELECT fazenda.localidade as fazendas
FROM usuario
JOIN fazenda ON fazenda.fkEmpresa = usuario.idUsuario
WHERE idUsuario = 1;


-- Histórico de dados
SELECT fazenda.localidade AS 'Fazenda',
sensorLog.dataHora as 'Momento',
sensor.tipo AS 'Sensor',
sensorLog.dadoCapturado AS 'Valor capturado',
sensorLog.critico AS 'Crítico'
FROM fazenda
JOIN sensor ON sensor.fkFazenda = fazenda.idFazenda
JOIN sensorLog ON sensorLog.fkSensor = sensor.idSensor 
JOIN usuario ON usuario.fkFazenda = fazenda.idFazenda
WHERE idUsuario = 1
ORDER BY fazenda, momento;



/*
Selects para a API
*/

use soytech;

-- KPI fazendas e lotes

 -- Usuário logado no momento
    select usuario, nomeEmpresa from usuario
    join Empresa on fkEmpresa = idEmpresa
    where idUsuario = 1;
    
    
 -- Quantidade de fazendas desse usuário
	select count(distinct localidade) as qtdFazendas from usuario
join usuarioHasFazenda on fkUsuario = idUsuario
join fazenda on idFazenda = usuarioHasFazenda.fkFazenda
where idUsuario = '1'
group by usuario;


-- KPI temperatura e umidade mais crítica

select dadoCapturado from sensorLog
join sensor on fkSensor = idSensor
join fazenda on sensor.fkFazenda = idFazenda
join usuarioHasFazenda on usuarioHasFazenda.fkFazenda = idFazenda
join usuario on fkUsuario = idUsuario
where idUsuario = 1 and (dadoCapturado > 30 or dadoCapturado < 20)
and tipo = 'lm35';

select dadoCapturado from sensorLog
join sensor on fkSensor = idSensor
join fazenda on sensor.fkFazenda = idFazenda
join usuarioHasFazenda on usuarioHasFazenda.fkFazenda = idFazenda
join usuario on fkUsuario = idUsuario
where idUsuario = 1 and (dadoCapturado > 14.5 or dadoCapturado < 12)
and tipo = 'dht11';


-- NÃO SERÁ UTILIZADO
/*
SELECT dadoCapturado, margem
FROM (
    SELECT dadoCapturado,
        CASE
            WHEN dadoCapturado < 20 THEN 20 - dadoCapturado
            WHEN dadoCapturado > 30 THEN dadoCapturado - 30
            ELSE LEAST(dadoCapturado - 20, 30 - dadoCapturado)
        END AS margem
    FROM sensorLog
    JOIN sensor ON sensorLog.fkSensor = sensor.idSensor
    JOIN lote ON sensor.fkLote = lote.idLote
    JOIN fazenda ON lote.fkFazenda = fazenda.idFazenda
    JOIN usuarioHasFazenda ON fazenda.idFazenda = usuarioHasFazenda.fkFazenda
    JOIN usuario ON usuarioHasFazenda.fkUsuario = usuario.idUsuario
    WHERE sensor.tipo = 'lm35' AND usuario.idUsuario = 1
) AS subquery
ORDER BY
    (SELECT COUNT(*) 
     FROM sensorLog 
     JOIN sensor ON sensorLog.fkSensor = sensor.idSensor
     JOIN lote ON sensor.fkLote = lote.idLote
     JOIN fazenda ON lote.fkFazenda = fazenda.idFazenda
     JOIN usuarioHasFazenda ON fazenda.idFazenda = usuarioHasFazenda.fkFazenda
     JOIN usuario ON usuarioHasFazenda.fkUsuario = usuario.idUsuario
     WHERE sensor.tipo = 'lm35' AND usuario.idUsuario = 1 AND (sensorLog.dadoCapturado < 20 OR sensorLog.dadoCapturado > 30)) DESC,
    margem ASC
LIMIT 1;


SELECT dadoCapturado, margem
FROM (
    SELECT dadoCapturado,
        CASE
            WHEN dadoCapturado < 12 THEN 12 - dadoCapturado
            WHEN dadoCapturado > 14.5 THEN dadoCapturado - 14.5
        END AS margem,
        CASE
            WHEN dadoCapturado < 12 OR dadoCapturado > 14.5 THEN 1
            ELSE 0
        END AS fora_intervalo
    FROM sensorLog
    JOIN sensor ON sensorLog.fkSensor = sensor.idSensor
    JOIN lote ON sensor.fkLote = lote.idLote
    JOIN fazenda ON lote.fkFazenda = fazenda.idFazenda
    JOIN usuarioHasFazenda ON fazenda.idFazenda = usuarioHasFazenda.fkFazenda
    JOIN usuario ON usuarioHasFazenda.fkUsuario = usuario.idUsuario
    WHERE sensor.tipo = 'dht11' AND usuario.idUsuario = 1
) AS subquery
ORDER BY
    fora_intervalo DESC,
    margem * (1 - 2 * fora_intervalo) ASC
LIMIT 1;

SELECT dadoCapturado, margem
FROM (
    SELECT dadoCapturado,
        CASE
            WHEN dadoCapturado < 20 THEN 20 - dadoCapturado
            WHEN dadoCapturado > 30 THEN dadoCapturado - 30
            ELSE LEAST(dadoCapturado - 20, 30 - dadoCapturado)
        END AS margem,
        CASE
            WHEN dadoCapturado < 20 OR dadoCapturado > 30 THEN 1
            ELSE 0
        END AS fora_intervalo
    FROM sensorLog
    JOIN sensor ON sensorLog.fkSensor = sensor.idSensor
    JOIN lote ON sensor.fkLote = lote.idLote
    JOIN fazenda ON lote.fkFazenda = fazenda.idFazenda
    JOIN usuarioHasFazenda ON fazenda.idFazenda = usuarioHasFazenda.fkFazenda
    JOIN usuario ON usuarioHasFazenda.fkUsuario = usuario.idUsuario
    WHERE sensor.tipo = 'lm35' AND usuario.idUsuario = 1
) AS subquery
ORDER BY
    fora_intervalo DESC,
    margem * (1 - 2 * fora_intervalo) ASC
LIMIT 1;
*/

-- KPI número de sensores operando

SELECT COUNT(idSensor) as 'Sensores lm35' from sensor 
join fazenda on sensor.fkFazenda = idFazenda
join usuarioHasFazenda on usuarioHasFazenda.fkFazenda = idFazenda
join usuario on fkUsuario = idUsuario
where tipo = 'lm35'
and idUsuario = 1;

SELECT COUNT(idSensor) as 'Sensores dht11' from sensor 
join fazenda on sensor.fkFazenda = idFazenda
join usuarioHasFazenda on usuarioHasFazenda.fkFazenda = idFazenda
join usuario on fkUsuario = idUsuario
where tipo = 'dht11'
and idUsuario = 1;