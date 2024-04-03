CREATE DATABASE SistemaFiscalizacaoAmbiental;

GO

USE SistemaFiscalizacaoAmbiental;

GO

CREATE TABLE pontos_fiscalizacao (
    ponto_id INT PRIMARY KEY,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(255),
    cep VARCHAR(20),
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    observacao VARCHAR(255)
);

CREATE TABLE usuarios_login (
    usuario_id INT IDENTITY (1,1) PRIMARY KEY,
    nome_usuario VARCHAR(255),
    senha VARCHAR(255),
    ult_login DATETIME,
    status BIT
);

CREATE TABLE agentes (
    funcionario_id INT PRIMARY KEY,
    usuario_id INT,
    nome VARCHAR(255),
    cpf VARCHAR(14),
    data_nascimento DATE,
    nivel_acesso VARCHAR(50),
    email VARCHAR(255),
    telefone VARCHAR(20),
    data_cadastro DATETIME,
    FOREIGN KEY (usuario_id) REFERENCES usuarios_login (usuario_id)
);

CREATE TABLE ocorrencias (
    ocorrencia_id INT PRIMARY KEY,
    ponto_id INT,
    usuario_id INT,
    data DATETIME,
    url_imagens VARCHAR(255),
    dispositivo VARCHAR(50),
    versao VARCHAR(50),
    infracao BIT,
    FOREIGN KEY (ponto_id) REFERENCES pontos_fiscalizacao (ponto_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios_login (usuario_id)
);