USE SistemaFiscalizacaoAmbiental;

GO

SELECT TOP 10 *
FROM usuarios_login

GO

-- Inser��o de dados em usuarios_login
INSERT INTO usuarios_login (nome_usuario, senha, ult_login, status) VALUES
('JoaoS', 'senha123', '2024-03-10 14:30:00', 1),
('MariaB', 'senha321', '2024-03-09 09:15:00', 1),
('CarlosK', '123456', '2024-03-08 16:45:00', 1);

GO

SELECT TOP 10 *
FROM usuarios_login