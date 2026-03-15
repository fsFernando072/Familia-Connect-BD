DROP DATABASE IF EXISTS familia_connect;
CREATE DATABASE familia_connect;
USE familia_connect;

CREATE TABLE familia(
	id INT PRIMARY KEY AUTO_INCREMENT,
    data_cadastro DATE NOT NULL
);

CREATE TABLE pessoa(
	id INT,
    familia_id INT,
    nome VARCHAR(80) NOT NULL,
    data_nascimento DATE NOT NULL,
	profissao VARCHAR(60) NOT NULL,
    is_trabalhando BOOLEAN NOT NULL,
    PRIMARY KEY(id, familia_id),
    FOREIGN KEY(familia_id) REFERENCES familia(id)
);

CREATE TABLE responsavel(
	pessoa_id INT,
    familia_id INT,
    rg VARCHAR(12) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    PRIMARY KEY(pessoa_id, familia_id),
    UNIQUE(familia_id),
    UNIQUE(cpf),
    UNIQUE(rg),
    UNIQUE(telefone)
);

CREATE TABLE endereco(
	id INT PRIMARY KEY AUTO_INCREMENT,
    familia_id INT NOT NULL,
	bairro VARCHAR(60) NOT NULL,
    tipo_logradouro VARCHAR(20) NOT NULL,
    logradouro VARCHAR(80) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(50),
    FOREIGN KEY(familia_id) REFERENCES familia(id)
);

CREATE TABLE funcionario(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    rg VARCHAR(12) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    senha VARCHAR(256) NOT NULL,
    caminho_foto VARCHAR(100) NOT NULL,
    UNIQUE(cpf),
    UNIQUE(senha)
);

CREATE TABLE entrega(
	id INT,
    data_entrega DATE NOT NULL,
    funcionario_id INT NOT NULL,
    pessoa_id INT NOT NULL,
    familia_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(funcionario_id) REFERENCES funcionario(id),
    FOREIGN KEY(pessoa_id, familia_id) REFERENCES pessoa(id, familia_id)
);