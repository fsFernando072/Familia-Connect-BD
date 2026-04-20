CREATE DATABASE IF NOT EXISTS familia_connect;
USE familia_connect;

CREATE TABLE IF NOT EXISTS profissao (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(80) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS estado (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  sigla VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS endereco (
  id INT NOT NULL AUTO_INCREMENT,
  cep VARCHAR(8) NOT NULL,
  bairro VARCHAR(50) NOT NULL,
  logradouro VARCHAR(80) NOT NULL,
  numero INT NOT NULL,
  complemento VARCHAR(45) NULL,
  cidade VARCHAR(50) NOT NULL,
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
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS pessoa (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  rg VARCHAR(9) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  dt_nascimento DATE NOT NULL,
  is_trabalhando TINYINT(1) NOT NULL,
  profissao_id INT NULL,
  familia_id INT NOT NULL,
  is_responsavel TINYINT(1) NOT NULL,
  grau_parentesco VARCHAR(45) NOT NULL,
  deficiencia_id INT NULL,
  telefone VARCHAR(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (profissao_id) REFERENCES profissao (id),
  FOREIGN KEY (familia_id) REFERENCES familia (id),
  FOREIGN KEY (deficiencia_id) REFERENCES deficiencia (id));

CREATE TABLE IF NOT EXISTS cargo (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS funcionario (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  senha VARCHAR(20) NOT NULL,
  foto_funcionario VARCHAR(100) NULL,
  cargo_id INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX cpf_UNIQUE (cpf ASC) VISIBLE,
  FOREIGN KEY (cargo_id) REFERENCES cargo (id));

CREATE TABLE IF NOT EXISTS permissao (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS acesso (
  id INT NOT NULL AUTO_INCREMENT,
  nome_tela VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS cargo_has_acesso (
  id INT NOT NULL AUTO_INCREMENT,
  cargo_id INT NOT NULL,
  acesso_id INT NOT NULL,
  permissao_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cargo_id) REFERENCES cargo (id),
  FOREIGN KEY (acesso_id) REFERENCES acesso (id),
  FOREIGN KEY (permissao_id) REFERENCES permissao (id));

CREATE TABLE IF NOT EXISTS auditoria (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_log VARCHAR(45) NULL,
  log VARCHAR(45) NULL,
  dado_antigo VARCHAR(45) NULL,
  dado_novo VARCHAR(45) NULL,
  created_at DATE NULL,
  funcionario_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (funcionario_id) REFERENCES funcionario (id));
    
CREATE TABLE IF NOT EXISTS entrega (
  id INT NOT NULL AUTO_INCREMENT,
  data_entrega DATE NOT NULL,
  funcionario_id INT NOT NULL,
  pessoa_id INT NOT NULL,
  PRIMARY KEY (id, data_entrega),
  FOREIGN KEY (funcionario_id) REFERENCES funcionario (id),
  FOREIGN KEY (pessoa_id) REFERENCES pessoa (id));
  
  CREATE TABLE IF NOT EXISTS categoria(
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY(id));
  
  CREATE TABLE Produto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  quantidade INT NOT NULL,
  descricao VARCHAR(100),
  Categoria_id INT,
  FOREIGN KEY (Categoria_id) REFERENCES Categoria(id));
  
INSERT INTO estado (nome, sigla) VALUES
('Acre', 'AC'),
('Alagoas', 'AL'),
('Amapá', 'AP'),
('Amazonas', 'AM'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Distrito Federal', 'DF'),
('Espírito Santo', 'ES'),
('Goiás', 'GO'),
('Maranhão', 'MA'),
('Mato Grosso', 'MT'),
('Mato Grosso do Sul', 'MS'),
('Minas Gerais', 'MG'),
('Pará', 'PA'),
('Paraíba', 'PB'),
('Paraná', 'PR'),
('Pernambuco', 'PE'),
('Piauí', 'PI'),
('Rio de Janeiro', 'RJ'),
('Rio Grande do Norte', 'RN'),
('Rio Grande do Sul', 'RS'),
('Rondônia', 'RO'),
('Roraima', 'RR'),
('Santa Catarina', 'SC'),
('São Paulo', 'SP'),
('Sergipe', 'SE'),
('Tocantins', 'TO');

INSERT INTO profissao (nome) VALUES
('Balconista e vendedor de loja'),
('Condutor de automóvel, táxi e caminhonete'),
('Pedreiro'),
('Trabalhador de limpeza de interiores'),
('Trabalhador de serviços domésticos'),
('Auxiliar administrativo'),
('Faxineiro'),
('Motorista de caminhão'),
('Vendedor do comércio varejista'),
('Auxiliar de escritório'),
('Trabalhador rural'),
('Cozinheiro'),
('Operador de caixa'),
('Professor de ensino fundamental'),
('Técnico em enfermagem'),
('Ajudante de obras'),
('Empregado doméstico'),
('Segurança'),
('Carpinteiro'),
('Eletricista'),
('Enfermeiro'),
('Garçom'),
('Trabalhador de produção industrial'),
('Contador'),
('Analista administrativo'),
('Desenvolvedor de software'),
('Médico'),
('Professor de ensino médio'),
('Técnico de manutenção'),
('Auxiliar de logística');