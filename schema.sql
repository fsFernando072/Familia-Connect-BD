CREATE DATABASE IF NOT EXISTS familia_connect;
USE familia_connect;

CREATE TABLE IF NOT EXISTS profissao (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(80) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS estado (
  id INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  sigla VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS endereco (
  id INT NOT NULL AUTO_INCREMENT,
  cep INT NOT NULL,
  bairro VARCHAR(50) NOT NULL,
  logradouro VARCHAR(80) NOT NULL,
  numero INT NOT NULL,
  complemento VARCHAR(45) NULL,
  estado_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (estado_id) REFERENCES estado (id));

CREATE TABLE IF NOT EXISTS familia (
  id INT NOT NULL AUTO_INCREMENT,
  data_cadastro DATE NOT NULL,
  endereco_id INT NOT NULL,
  foto_familia VARCHAR(100) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (endereco_id) REFERENCES endereco (id));

CREATE TABLE IF NOT EXISTS deficiencia (
  id INT NOT NULL,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS pessoa (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  rg INT NOT NULL,
  cpf INT NOT NULL,
  dt_nascimento DATE NOT NULL,
  is_trabalhando TINYINT(1) NOT NULL,
  profissao_id INT NULL,
  familia_id INT NOT NULL,
  is_responsavel TINYINT(1) NOT NULL,
  grau_parentesco VARCHAR(45) NOT NULL,
  deficiencia_id INT NULL,
  telefone INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (profissao_id) REFERENCES profissao (id),
  FOREIGN KEY (familia_id) REFERENCES familia (id),
  FOREIGN KEY (deficiencia_id) REFERENCES deficiencia (id));

CREATE TABLE IF NOT EXISTS cargo (
  id INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS funcionario (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  cpf INT NOT NULL,
  senha VARCHAR(20) NOT NULL,
  foto_funcionario VARCHAR(100) NULL,
  cargo_id INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX cpf_UNIQUE (cpf ASC) VISIBLE,
  FOREIGN KEY (cargo_id) REFERENCES cargo (id));

CREATE TABLE IF NOT EXISTS permissao (
  id INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS acesso (
  id INT NOT NULL,
  nome_tela VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS cargo_has_acesso (
  cargo_id INT NOT NULL,
  acesso_id INT NOT NULL,
  permissao_id INT NOT NULL,
  PRIMARY KEY (cargo_id, acesso_id),
  FOREIGN KEY (cargo_id) REFERENCES cargo (id),
  FOREIGN KEY (acesso_id) REFERENCES acesso (id),
  FOREIGN KEY (permissao_id) REFERENCES permissao (id));

CREATE TABLE IF NOT EXISTS auditoria (
  id INT NOT NULL,
  tipo_log VARCHAR(45) NULL,
  log VARCHAR(45) NULL,
  dado_antigo VARCHAR(45) NULL,
  dado_novo VARCHAR(45) NULL,
  created_at DATE NULL,
  funcionario_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (funcionario_id) REFERENCES funcionario (id));
    
CREATE TABLE IF NOT EXISTS entrega (
  id INT NOT NULL,
  data_entrega DATE NOT NULL,
  funcionario_id INT NOT NULL,
  pessoa_id INT NOT NULL,
  PRIMARY KEY (id, data_entrega),
  FOREIGN KEY (funcionario_id) REFERENCES funcionario (id),
  FOREIGN KEY (pessoa_id) REFERENCES pessoa (id));
