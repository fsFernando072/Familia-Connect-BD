DROP DATABASE IF EXISTS familia_connect;
CREATE DATABASE familia_connect;
USE familia_connect;

CREATE TABLE responsavel(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    data_nascimento DATE NOT NULL,
    rg VARCHAR(12) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    profissao VARCHAR(60) NOT NULL,
    is_trabalhando BOOLEAN NOT NULL,
    data_cadastro DATE NOT NULL,
    UNIQUE(cpf),
    UNIQUE(rg),
    UNIQUE(telefone)
);

CREATE TABLE dependente(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_responsavel INT NOT NULL,
    nome VARCHAR(80) NOT NULL,
    data_nascimento DATE NOT NULL,
	profissao VARCHAR(60) NOT NULL,
    is_trabalhando BOOLEAN NOT NULL,
    FOREIGN KEY(id_responsavel) REFERENCES responsavel(id)
);

CREATE TABLE endereco(
	id INT PRIMARY KEY AUTO_INCREMENT,
    responsavel_id INT NOT NULL,
	bairro VARCHAR(60) NOT NULL,
    tipo_logradouro VARCHAR(20) NOT NULL,
    logradouro VARCHAR(80) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(50),
    FOREIGN KEY(responsavel_id) REFERENCES responsavel(id)
);

CREATE TABLE entrega(
	id INT,
    responsavel_id INT,
    data_entrega DATE NOT NULL,
    PRIMARY KEY(id, responsavel_id),
    FOREIGN KEY(responsavel_id) REFERENCES responsavel(id)
);

CREATE TABLE funcionario(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    senha VARCHAR(256) NOT NULL,
    caminho_foto VARCHAR(100) NOT NULL,
    UNIQUE(cpf),
    UNIQUE(senha)
);