-- sensor dht11 que esta na fazenda 1
INSERT INTO sensor VALUES
	(DEFAULT,'dht11', 1);
-- sensor lm35 que esta na fazenda 1
INSERT INTO sensor VALUES
	(DEFAULT,'lm35', 1);

-- ======= simulando os dados sendo inseridos =========
-- alterando entre dados capturado do sensor 1 e 2 (dht11,lm35)
-- intervalo de 1 minuto para cada medição
-- variação randomica
INSERT INTO sensorLog VALUES
	(DEFAULT, 35.50, '2024-04-12 23:39:30', 1), --
	(DEFAULT, 25.50, '2024-04-12 23:39:30', 2),
    (DEFAULT, 36.50, '2024-04-12 23:40:30', 1), --
	(DEFAULT, 26.20, '2024-04-12 23:40:30', 2),
    (DEFAULT, 36.50, '2024-04-12 23:41:30', 1), --
	(DEFAULT, 24.80, '2024-04-12 23:41:30', 2),
    (DEFAULT, 37.50, '2024-04-12 23:42:30', 1), --
	(DEFAULT, 25.70, '2024-04-12 23:42:30', 2),
    (DEFAULT, 36.50, '2024-04-12 23:43:30', 1), --
	(DEFAULT, 26.50, '2024-04-12 23:43:30', 2),
    (DEFAULT, 36.50, '2024-04-12 23:44:30', 1), --
	(DEFAULT, 24.90, '2024-04-12 23:44:30', 2),
    (DEFAULT, 34.50, '2024-04-12 23:45:30', 1), --
	(DEFAULT, 25.80, '2024-04-12 23:45:30', 2),
    (DEFAULT, 37.50, '2024-04-12 23:46:30', 1), --
	(DEFAULT, 25.30, '2024-04-12 23:46:30', 2),
    (DEFAULT, 37.50, '2024-04-12 23:47:30', 1), --
	(DEFAULT, 26.10, '2024-04-12 23:47:30', 2),
    (DEFAULT, 36.50, '2024-04-12 23:48:30', 1), --
	(DEFAULT, 24.60, '2024-04-12 23:48:30', 2);
    