USE soytech;

/*
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
JOIN usuario ON usuario.fkEmpresa = empresa.idEmpresa
JOIN fazenda ON usuario.fkFazenda = fazenda.idFazenda
JOIN usuarioHasFazenda ON usuarioHasFazenda.fkUsuario = usuario.idUsuario AND usuarioHasFazenda.fkFazenda = fazenda.idFazenda
JOIN parametroFazenda ON parametroFazenda.fkFazenda = fazenda.idFazenda;
*/

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
    select usuario as 'nomeUsuario', nomeEmpresa as 'nomeEmpresa' from usuario
    join Empresa on fkEmpresa = idEmpresa
    where idUsuario = 1;
    

 -- Quantidade de fazendas dessea empresa
	select nomeEmpresa, count(distinct localidade) as 'qtdFazendas' from fazenda
join empresa on fkEmpresa = idEmpresa
where fkEmpresa = 1
group by nomeEmpresa;
select * from sensorLog;
-- KPI temperatura e umidade mais crítica

select dadoCapturado as 'capturaTemperatura' from sensorLog
join sensor on fkSensor = idSensor
join fazenda on sensor.fkFazenda = idFazenda
join usuario on usuario.fkFazenda = idFazenda
where fazenda.fkEmpresa = 1 and (dadoCapturado > 30 or dadoCapturado < 20)
and tipo = 'lm35' order by dataHora desc limit 1;

select dadoCapturado as 'capturaUmidade' from sensorLog
join sensor on fkSensor = idSensor
join fazenda on sensor.fkFazenda = idFazenda
join usuario on sensor.fkFazenda = idFazenda
where usuario.fkEmpresa = 1 and (dadoCapturado > 14.5 or dadoCapturado < 12)
and tipo = 'dht11' order by dataHora desc limit 1;

-- KPI número de sensores operando

SELECT COUNT(idSensor) as 'sensoresLM35' from sensor 
join fazenda on sensor.fkFazenda = idFazenda
where tipo = 'lm35'
and fazenda.fkEmpresa = 1;

SELECT COUNT(idSensor) as 'sensoresDHT11' from sensor 
join fazenda on sensor.fkFazenda = idFazenda
where tipo = 'dht11'
and fazenda.fkEmpresa = 1;

-- Gráficos página principal da dashboard !AINDA TEM QUE REVISAR O CONCEITO DOS GRÁFICOS!
/*
SELECT COUNT(critico) as 'problemas' from sensorLog
join sensor on fkSensor = idSensor
join fazenda on sensor.fkFazenda = idFazenda
join usuarioHasFazenda on usuarioHasFazenda.fkFazenda = idFazenda
join usuario on fkUsuario = idUsuario
where idFazenda = 1 and idUsuario = 1;  -- NO BACKEND, FAZER ESSE CÓDIGO REPETIR PARA CADA FAZENDA EXISTENTE NO CADASTRO DO USUÁRIO
*/

-- Página das fazendas

SELECT dadoCapturado from sensorLog
join sensor on fkSensor = idSensor
join fazenda on sensor.fkFazenda = idFazenda
join usuarioHasFazenda on usuarioHasFazenda.fkFazenda = idFazenda
join usuario on fkUsuario = idUsuario
where idUsuario = 1 and idFazenda = 1 order by dataHora limit 1;