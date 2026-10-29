CREATE DATABASE IF NOT EXISTS familia_connect;

USE familia_connect;

/* ============================================================
   CREATES
   ============================================================ */

/* ------------------------------------------------------------
   Tabela: cargo
   ------------------------------------------------------------ */

CREATE TABLE `cargo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
);


/* ------------------------------------------------------------
   Tabela: cargo_permissao
   ------------------------------------------------------------ */

CREATE TABLE `cargo_permissao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cargo_id` int NOT NULL,
  `pagina` varchar(30) NOT NULL,
  `nivel` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_cargo_pagina` (`cargo_id`, `pagina`),
  CONSTRAINT `fk_cargo_permissao_cargo`
    FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id`)
);


/* ------------------------------------------------------------
   Tabela: categoria arquivo
   ------------------------------------------------------------ */

CREATE TABLE `categoria_arquivo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);


/* ------------------------------------------------------------
   Tabela: arquivo
   ------------------------------------------------------------ */

CREATE TABLE `arquivo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_original` varchar(100) NOT NULL,
  `nome_gerado` varchar(100) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `tamanho` bigint NOT NULL,
  `dados` longblob DEFAULT NULL,
  `data_upload` datetime NOT NULL,
  `categoria_arquivo_id` int NOT NULL,
  KEY `categoria_arquivo_id` (`categoria_arquivo_id`),
  CONSTRAINT `arquivo_ibfk_1`
    FOREIGN KEY (`categoria_arquivo_id`) REFERENCES `categoria_arquivo` (`id`),
  PRIMARY KEY (`id`)
);


/* ------------------------------------------------------------
   Tabela: funcionario
   ------------------------------------------------------------ */

CREATE TABLE `funcionario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `foto_id` int DEFAULT NULL,
  `cargo_id` int NOT NULL,
  `ativo` boolean default true not null,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  KEY `cargo_id` (`cargo_id`),
  KEY `foto_id` (`foto_id`),
  CONSTRAINT `funcionario_ibfk_1`
    FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id`),
  CONSTRAINT `funcionario_ibfk_2`
    FOREIGN KEY (`foto_id`) REFERENCES `arquivo` (`id`)
);


/* ------------------------------------------------------------
   Tabela: categoria
   ------------------------------------------------------------ */

CREATE TABLE `categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `ativo` boolean default true not null,
  PRIMARY KEY (`id`)
);


/* ------------------------------------------------------------
   Tabela: produto
   ------------------------------------------------------------ */

CREATE TABLE `produto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  `ativo` boolean default true not null,
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `produto_ibfk_1`
    FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`)
);


/* ------------------------------------------------------------
   Tabela: estado
   ------------------------------------------------------------ */

CREATE TABLE `estado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `sigla` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);


/* ------------------------------------------------------------
   Tabela: endereco
   ------------------------------------------------------------ */

CREATE TABLE `endereco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cep` varchar(8) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `logradouro` varchar(80) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `complemento` varchar(45) DEFAULT NULL,
  `cidade` varchar(50) NOT NULL,
  `estado_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `estado_id` (`estado_id`),
  CONSTRAINT `endereco_ibfk_1`
    FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`)
);


/* ------------------------------------------------------------
   Tabela: familia
   ------------------------------------------------------------ */

CREATE TABLE `familia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_cadastro` date NOT NULL,
  `endereco_id` int NOT NULL,
  `foto_id` int DEFAULT NULL,
  `possui_prioridade` tinyint(1) NOT NULL,
  id_carteirinha VARCHAR(255),
  PRIMARY KEY (`id`),
  KEY `endereco_id` (`endereco_id`),
  KEY `foto_id` (`foto_id`),
  CONSTRAINT `familia_ibfk_1`
    FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`),
  CONSTRAINT `familia_ibfk_2`
    FOREIGN KEY (`foto_id`) REFERENCES `arquivo` (`id`)
);


/* ------------------------------------------------------------
   Tabela: profissao
   ------------------------------------------------------------ */

CREATE TABLE `profissao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
);


/* ------------------------------------------------------------
   Tabela: grau_parentesco
   ------------------------------------------------------------ */

CREATE TABLE `grau_parentesco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `grau` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
);


/* ------------------------------------------------------------
   Tabela: pessoa
   ------------------------------------------------------------ */

CREATE TABLE `pessoa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `rg` varchar(9) DEFAULT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `dt_nascimento` date NOT NULL,
  `profissao_id` int DEFAULT NULL,
  `familia_id` int NOT NULL,
  `is_responsavel` tinyint(1) NOT NULL,
  `grau_parentesco_id` int NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `sexo` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profissao_id` (`profissao_id`),
  KEY `familia_id` (`familia_id`),
  KEY `grau_parentesco_id` (`grau_parentesco_id`),
  CONSTRAINT `pessoa_ibfk_1`
    FOREIGN KEY (`profissao_id`) REFERENCES `profissao` (`id`),
  CONSTRAINT `pessoa_ibfk_2`
    FOREIGN KEY (`familia_id`) REFERENCES `familia` (`id`),
  CONSTRAINT `pessoa_ibfk_3`
    FOREIGN KEY (`grau_parentesco_id`) REFERENCES `grau_parentesco` (`id`)
);


/* ------------------------------------------------------------
   Tabela: historico_estoque
   ------------------------------------------------------------ */

CREATE TABLE `historico_estoque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantidade` double NOT NULL,
  `data_estoque` date NOT NULL,
  `produto_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `produto_id` (`produto_id`),
  CONSTRAINT `historico_estoque_ibfk_1`
    FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`)
);


/* ------------------------------------------------------------
   Tabela: entrega
   ------------------------------------------------------------ */

CREATE TABLE `entrega` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_entrega` date NOT NULL,
  `funcionario_id` int NOT NULL,
  `pessoa_id` int NOT NULL,
  `produto_id` int NOT NULL,
  PRIMARY KEY (`id`,`data_entrega`),
  KEY `funcionario_id` (`funcionario_id`),
  KEY `pessoa_id` (`pessoa_id`),
  KEY `produto_id` (`produto_id`),
  CONSTRAINT `entrega_ibfk_1`
    FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`),
  CONSTRAINT `entrega_ibfk_2`
    FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`),
  CONSTRAINT `entrega_ibfk_3`
    FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`)
);


/* ============================================================
   INSERTS
   ============================================================ */


/* ------------------------------------------------------------
   cargo
   ------------------------------------------------------------ */

INSERT INTO `cargo` VALUES 
(1, 'Diretor', 'Diretoria do CIFA, responsavel pelo orquestramento da organização'),
(2, 'Recepcionista', 'Recepcionar as pessoas que necessitarem de informações ou de auxílio');


/* ------------------------------------------------------------
   cargo_permissao
   ------------------------------------------------------------ */

INSERT INTO `cargo_permissao` (cargo_id, pagina, nivel) VALUES
(1, 'FAMILIAS', 'ADMINISTRADOR'),
(1, 'FUNCIONARIOS', 'ADMINISTRADOR'),
(1, 'PRODUTOS', 'ADMINISTRADOR'),
(1, 'CARGOS', 'ADMINISTRADOR'),
(1, 'CATEGORIAS', 'ADMINISTRADOR'),
(1, 'HISTORICO_ENTREGAS', 'ADMINISTRADOR'),
(1, 'HISTORICO_ESTOQUE', 'ADMINISTRADOR'),
(1, 'DASHBOARD', 'ADMINISTRADOR');


/* ------------------------------------------------------------
   funcionario
   ------------------------------------------------------------ */

INSERT INTO `funcionario` (nome, cpf, senha, foto_id, cargo_id) 
values
('João Silva', '52437201866', '$2a$10$vWlYEp1T8pbMJVL2JUgb8uhDbeFkwAOYdTtLM.Jr84kLWHLqs3BQ2', NULL, 1),
('Ana Souza', '24704891801', '$2a$10$xKpL9mQw2nRtVbHuJdYe5OiWzA1csFgM3kD7pN6qE4rT8vX0yZ.', NULL, 2);

/* ------------------------------------------------------------
   estado
   ------------------------------------------------------------ */

INSERT INTO `estado` VALUES 
(1,'Acre','AC'),
(2,'Alagoas','AL'),
(3,'Amapá','AP'),
(4,'Amazonas','AM'),
(5,'Bahia','BA'),
(6,'Ceará','CE'),
(7,'Distrito Federal','DF'),
(8,'Espírito Santo','ES'),
(9,'Goiás','GO'),
(10,'Maranhão','MA'),
(11,'Mato Grosso','MT'),
(12,'Mato Grosso do Sul','MS'),
(13,'Minas Gerais','MG'),
(14,'Pará','PA'),
(15,'Paraíba','PB'),
(16,'Paraná','PR'),
(17,'Pernambuco','PE'),
(18,'Piauí','PI'),
(19,'Rio de Janeiro','RJ'),
(20,'Rio Grande do Norte','RN'),
(21,'Rio Grande do Sul','RS'),
(22,'Rondônia','RO'),
(23,'Roraima','RR'),
(24,'Santa Catarina','SC'),
(25,'São Paulo','SP'),
(26,'Sergipe','SE'),
(27,'Tocantins','TO');


/* ------------------------------------------------------------
   endereco
   ------------------------------------------------------------ */

INSERT INTO `endereco`
(cep, bairro, logradouro, numero, complemento, cidade, estado_id)
VALUES 
('01310100', 'Bela Vista', 'Avenida Paulista', '1578', 'Apto 101', 'São Paulo', 25),
('20040020', 'Centro', 'Avenida Rio Branco', '156', 'Sala 302', 'Rio de Janeiro', 19),
('30130110', 'Centro', 'Avenida Afonso Pena', '1500', NULL, 'Belo Horizonte', 13),
('80010020', 'Centro', 'Rua XV de Novembro', '800', 'Casa', 'Curitiba', 16),
('40020010', 'Comercial', 'Avenida Sete de Setembro', '220', NULL, 'Salvador', 5);


/* ------------------------------------------------------------
   profissao
   ------------------------------------------------------------ */

INSERT INTO `profissao` VALUES 
(1,'Balconista e vendedor de loja'),
(2,'Condutor de automóvel, táxi e caminhonete'),
(3,'Pedreiro'),
(4,'Trabalhador de limpeza de interiores'),
(5,'Trabalhador de serviços domésticos'),
(6,'Auxiliar administrativo'),
(7,'Faxineiro'),
(8,'Motorista de caminhão'),
(9,'Vendedor do comércio varejista'),
(10,'Auxiliar de escritório'),
(11,'Trabalhador rural'),
(12,'Cozinheiro'),
(13,'Operador de caixa'),
(14,'Professor de ensino fundamental'),
(15,'Técnico em enfermagem'),
(16,'Ajudante de obras'),
(17,'Empregado doméstico'),
(18,'Segurança'),
(19,'Carpinteiro'),
(20,'Eletricista'),
(21,'Enfermeiro'),
(22,'Garçom'),
(23,'Trabalhador de produção industrial'),
(24,'Contador'),
(25,'Analista administrativo'),
(26,'Desenvolvedor de software'),
(27,'Médico'),
(28,'Professor de ensino médio'),
(29,'Técnico de manutenção'),
(30,'Auxiliar de logística');


/* ------------------------------------------------------------
   grau_parentesco
   ------------------------------------------------------------ */

INSERT INTO `grau_parentesco` (grau) VALUES
('Pai/Mãe'),
('Filho/Filha'),
('Avô/Avó'),
('Tio/Tia'),
('Primo/Prima'),
('Sobrinho/Sobrinha'),
('Neto/Neta'),
('Genro/Nora');


/* ------------------------------------------------------------
   categoria arquivo
   ------------------------------------------------------------ */

INSERT INTO `categoria_arquivo` (nome) VALUES
('familias'),
('funcionarios');


/* ------------------------------------------------------------
   familia
   ------------------------------------------------------------ */

INSERT INTO `familia`
(data_cadastro, endereco_id, foto_id, possui_prioridade)
VALUES
('2026-01-01', 1, null, 1),
('2026-01-02', 2, null, 0),
('2026-01-03', 3, null, 1),
('2026-01-04', 4, null, 0);


/* ------------------------------------------------------------
   pessoa
   ------------------------------------------------------------ */

INSERT INTO `pessoa`
(nome, rg, cpf, dt_nascimento, profissao_id, familia_id,
 is_responsavel, grau_parentesco_id, telefone, sexo)
VALUES
('João da Silva',   '334490662', '39308870881', '1985-06-15', 1,    1, 1, 1, '11940028920', 'MASCULINO'),
('Maria da Silva',  '377685094', '27131850845', '1988-09-20', 2,    1, 0, 1, '11976543210', 'FEMININO'),
('Pedro da Silva',  '283118854', '46331122877', '2012-03-10', NULL, 1, 0, 2, '11965432109', 'MASCULINO'),
('Carla Oliveira',  '376315891', '72647130833', '1990-04-12', 5,    2, 1, 1, '11955001100', 'FEMININO'),
('Lucas Oliveira',  '278403050', '27407725802', '2015-11-08', NULL, 2, 0, 2, '11955001101', 'MASCULINO'),
('Fernanda Lima',   '439955609', '29547647830', '1978-02-25', 12,   3, 1, 1, '11933445566', 'FEMININO'),
('Rafael Lima',     '174459609', '82395800848', '1975-07-30', 8,    3, 0, 1, '11933445567', 'MASCULINO'),
('Beatriz Costa',   '275066459', '73808940808', '1995-12-01', 13,   4, 1, 1, '11922334455', 'FEMININO'),
('Henrique Costa',  '468510977', '62272437877', '2018-05-20', NULL, 4, 0, 2, '11922334456', 'MASCULINO');


/* ------------------------------------------------------------
   categoria
   ------------------------------------------------------------ */

INSERT INTO `categoria` (nome) VALUES
('Alimentos'),
('Higiene Pessoal'),
('Limpeza'),
('Vestuário'),
('Medicamentos');


/* ------------------------------------------------------------
   produto
   ------------------------------------------------------------ */

INSERT INTO `produto`
(nome, descricao, categoria_id)
VALUES
('Cesta Básica', 'Cesta com itens essenciais de alimentação', 1),
('Óleo de Soja 900ml', 'Garrafa de óleo de soja 900ml', 1),
('Arroz 5kg', 'Pacote de arroz tipo 1 5kg', 1),
('Feijão 1kg', 'Pacote de feijão carioca 1kg', 1),
('Sabonete', 'Sabonete 90g', 2),
('Shampoo 350ml', 'Shampoo neutro 350ml', 2),
('Pasta de Dente', 'Pasta de dente com flúor 90g', 2),
('Detergente 500ml', 'Detergente líquido 500ml', 3),
('Sabão em Pó 1kg', 'Sabão em pó multiação 1kg', 3),
('Água Sanitária 1L', 'Água sanitária 1 litro', 3),
('Agasalho Adulto', 'Agasalho adulto tamanhos variados', 4),
('Roupa Infantil', 'Kit roupa infantil sortida', 4),
('Dipirona 500mg', 'Dipirona sódica 500mg caixa com 20 comprimidos', 5),
('Vitamina C 1g', 'Vitamina C efervescente 1g caixa com 10 unidades', 5);

select * from produto;
/* ------------------------------------------------------------
   historico_estoque
   ------------------------------------------------------------ */

INSERT INTO `historico_estoque`
(quantidade, data_estoque, produto_id)
VALUES
(20, '2026-02-01', 1),
(20, '2026-02-01', 2),
(20, '2026-03-01', 3),
(20, '2026-03-01', 4),
(20, '2026-03-01', 5),
(20, '2026-04-01', 6),
(20, '2026-04-01', 7),
(20, '2026-04-01', 8),
(20, '2026-04-01', 1);

INSERT INTO historico_estoque
(quantidade, data_estoque, produto_id) VALUES (20, CURDATE(), 1);

/* ------------------------------------------------------------
   entrega
   ------------------------------------------------------------ */

INSERT INTO `entrega`
(data_entrega, funcionario_id, pessoa_id, produto_id)
VALUES
('2026-02-15', 1, 1, 1),
('2026-02-15', 1, 4, 1),
('2026-02-15', 1, 6, 2),
('2026-03-10', 1, 1, 3),
('2026-03-10', 2, 4, 4),
('2026-03-10', 2, 8, 5),
('2026-04-05', 1, 1, 6),
('2026-04-05', 2, 6, 7),
('2026-04-20', 1, 4, 8),
('2026-04-20', 2, 8, 1);

-- INSERTS PARA DEMONSTRAÇÃO DE DADOS NA DASHBOARD --
START TRANSACTION;

-- Funcionarios adicionais: cargo_id=2 existente no script base
INSERT INTO funcionario (id,nome,cpf,senha,foto_id,cargo_id,ativo) VALUES
(90001, 'Mariana Rocha', '90000000001', '$2a$10$DEMONSTRACAO_CONTA_DESATIVADA_NAO_USAR_LOGIN', NULL, 2, 0),
(90002, 'Carlos Mendes', '90000000002', '$2a$10$DEMONSTRACAO_CONTA_DESATIVADA_NAO_USAR_LOGIN', NULL, 2, 0),
(90003, 'Patricia Almeida', '90000000003', '$2a$10$DEMONSTRACAO_CONTA_DESATIVADA_NAO_USAR_LOGIN', NULL, 2, 0);

-- Enderecos em Sao Paulo (dados ficticios)
INSERT INTO endereco (id,cep,bairro,logradouro,numero,complemento,cidade,estado_id) VALUES
(90001, '08200000', 'Itaquera', 'Rua Demonstração 1', '100', NULL, 'São Paulo', 25),
(90002, '08200000', 'Itaquera', 'Rua Demonstração 2', '101', NULL, 'São Paulo', 25),
(90003, '08200000', 'Itaquera', 'Rua Demonstração 3', '102', NULL, 'São Paulo', 25),
(90004, '08200000', 'Guaianases', 'Rua Demonstração 4', '103', NULL, 'São Paulo', 25),
(90005, '08200000', 'Guaianases', 'Rua Demonstração 5', '104', NULL, 'São Paulo', 25),
(90006, '08200000', 'São Miguel Paulista', 'Rua Demonstração 6', '105', NULL, 'São Paulo', 25),
(90007, '08200000', 'São Miguel Paulista', 'Rua Demonstração 7', '106', NULL, 'São Paulo', 25),
(90008, '08200000', 'Cidade Tiradentes', 'Rua Demonstração 8', '107', NULL, 'São Paulo', 25),
(90009, '08200000', 'Cidade Tiradentes', 'Rua Demonstração 9', '108', NULL, 'São Paulo', 25),
(90010, '08200000', 'Artur Alvim', 'Rua Demonstração 10', '109', NULL, 'São Paulo', 25),
(90011, '08200000', 'Penha', 'Rua Demonstração 11', '110', NULL, 'São Paulo', 25),
(90012, '08200000', 'Vila Matilde', 'Rua Demonstração 12', '111', NULL, 'São Paulo', 25);

-- Familias: 6 prioritarias; cadastros distribuidos entre maio e outubro
INSERT INTO familia (id,data_cadastro,endereco_id,foto_id,possui_prioridade,id_carteirinha) VALUES
(90001, '2026-05-04', 90001, NULL, 1, 'DEMO-90001'),
(90002, '2026-05-12', 90002, NULL, 1, 'DEMO-90002'),
(90003, '2026-06-08', 90003, NULL, 0, 'DEMO-90003'),
(90004, '2026-06-20', 90004, NULL, 1, 'DEMO-90004'),
(90005, '2026-07-05', 90005, NULL, 0, 'DEMO-90005'),
(90006, '2026-07-21', 90006, NULL, 1, 'DEMO-90006'),
(90007, '2026-08-02', 90007, NULL, 0, 'DEMO-90007'),
(90008, '2026-08-19', 90008, NULL, 0, 'DEMO-90008'),
(90009, '2026-09-01', 90009, NULL, 1, 'DEMO-90009'),
(90010, '2026-09-15', 90010, NULL, 0, 'DEMO-90010'),
(90011, '2026-10-01', 90011, NULL, 1, 'DEMO-90011'),
(90012, '2026-10-10', 90012, NULL, 0, 'DEMO-90012');

-- Uma pessoa responsavel por familia; CPFs ficticios nao destinados a uso real
INSERT INTO pessoa (id,nome,rg,cpf,dt_nascimento,profissao_id,familia_id,is_responsavel,grau_parentesco_id,telefone,sexo) VALUES
(90001, 'Amanda Ribeiro', NULL, NULL, '1988-06-15', NULL, 90001, 1, 1, NULL, 'FEMININO'),
(90002, 'Bruno Ferreira', NULL, NULL, '1988-06-15', NULL, 90002, 1, 1, NULL, 'MASCULINO'),
(90003, 'Camila Santos', NULL, NULL, '1988-06-15', NULL, 90003, 1, 1, NULL, 'FEMININO'),
(90004, 'Diego Martins', NULL, NULL, '1988-06-15', NULL, 90004, 1, 1, NULL, 'MASCULINO'),
(90005, 'Elisa Barbosa', NULL, NULL, '1988-06-15', NULL, 90005, 1, 1, NULL, 'FEMININO'),
(90006, 'Fabio Nogueira', NULL, NULL, '1988-06-15', NULL, 90006, 1, 1, NULL, 'MASCULINO'),
(90007, 'Gabriela Lima', NULL, NULL, '1988-06-15', NULL, 90007, 1, 1, NULL, 'FEMININO'),
(90008, 'Henrique Oliveira', NULL, NULL, '1988-06-15', NULL, 90008, 1, 1, NULL, 'MASCULINO'),
(90009, 'Isabela Costa', NULL, NULL, '1988-06-15', NULL, 90009, 1, 1, NULL, 'FEMININO'),
(90010, 'Julio Pereira', NULL, NULL, '1988-06-15', NULL, 90010, 1, 1, NULL, 'MASCULINO'),
(90011, 'Karina Souza', NULL, NULL, '1988-06-15', NULL, 90011, 1, 1, NULL, 'FEMININO'),
(90012, 'Leandro Alves', NULL, NULL, '1988-06-15', NULL, 90012, 1, 1, NULL, 'MASCULINO');

-- Historico de estoque demonstrativo: reposicoes dos produtos ja existentes (IDs 1-14)
INSERT INTO historico_estoque (quantidade,data_estoque,produto_id) VALUES
(80, '2026-05-03', 1),
(47, '2026-05-03', 2),
(41, '2026-05-03', 3),
(57, '2026-05-03', 4),
(55, '2026-05-03', 5),
(54, '2026-05-03', 6),
(48, '2026-05-03', 7),
(46, '2026-05-03', 8),
(74, '2026-05-03', 9),
(45, '2026-05-03', 10),
(77, '2026-06-03', 1),
(67, '2026-06-03', 2),
(42, '2026-06-03', 3),
(41, '2026-06-03', 4),
(45, '2026-06-03', 5),
(53, '2026-06-03', 6),
(54, '2026-06-03', 7),
(72, '2026-06-03', 8),
(78, '2026-06-03', 9),
(41, '2026-06-03', 10),
(75, '2026-07-03', 1),
(52, '2026-07-03', 2),
(74, '2026-07-03', 3),
(66, '2026-07-03', 4),
(54, '2026-07-03', 5),
(68, '2026-07-03', 6),
(77, '2026-07-03', 7),
(57, '2026-07-03', 8),
(40, '2026-07-03', 9),
(50, '2026-07-03', 10),
(67, '2026-08-03', 1),
(61, '2026-08-03', 2),
(57, '2026-08-03', 3),
(49, '2026-08-03', 4),
(53, '2026-08-03', 5),
(61, '2026-08-03', 6),
(46, '2026-08-03', 7),
(45, '2026-08-03', 8),
(64, '2026-08-03', 9),
(46, '2026-08-03', 10),
(62, '2026-09-03', 1),
(62, '2026-09-03', 2),
(78, '2026-09-03', 3),
(56, '2026-09-03', 4),
(42, '2026-09-03', 5),
(69, '2026-09-03', 6),
(74, '2026-09-03', 7),
(47, '2026-09-03', 8),
(64, '2026-09-03', 9),
(45, '2026-09-03', 10),
(75, '2026-10-03', 1),
(58, '2026-10-03', 2),
(80, '2026-10-03', 3),
(79, '2026-10-03', 4),
(63, '2026-10-03', 5),
(76, '2026-10-03', 6),
(52, '2026-10-03', 7),
(44, '2026-10-03', 8),
(42, '2026-10-03', 9),
(54, '2026-10-03', 10);

-- Entregas: uma linha por item; diferentes familias e funcionarios por mes.
-- Familias 90011 e 90012: sem entregas; 90001 e 90002: ultima entrega antiga.
INSERT INTO entrega (data_entrega,funcionario_id,pessoa_id,produto_id) VALUES
('2026-05-15', 90001, 90001, 11),
('2026-05-15', 2, 90001, 8),
('2026-05-15', 90002, 90001, 3),
('2026-05-15', 90001, 90006, 2),
('2026-05-15', 90001, 90006, 2),
('2026-05-15', 90001, 90006, 6),
('2026-05-15', 1, 90006, 5),
('2026-05-28', 2, 90001, 4),
('2026-05-28', 2, 90001, 2),
('2026-05-28', 90002, 90006, 3),
('2026-05-28', 90003, 90006, 2),
('2026-05-28', 90001, 90006, 7),
('2026-06-12', 1, 90002, 2),
('2026-06-12', 1, 90002, 7),
('2026-06-12', 90002, 90002, 3),
('2026-06-12', 2, 90002, 9),
('2026-06-12', 90003, 90003, 8),
('2026-06-12', 90001, 90003, 2),
('2026-06-25', 90002, 90002, 3),
('2026-06-25', 90002, 90002, 2),
('2026-06-25', 2, 90002, 3),
('2026-06-25', 90003, 90003, 4),
('2026-06-25', 90003, 90003, 4),
('2026-06-25', 90003, 90003, 3),
('2026-06-25', 2, 90003, 12),
('2026-07-10', 2, 90003, 4),
('2026-07-10', 1, 90003, 7),
('2026-07-10', 1, 90003, 2),
('2026-07-10', 2, 90003, 7),
('2026-07-10', 90002, 90009, 5),
('2026-07-10', 90002, 90009, 3),
('2026-07-10', 90002, 90009, 4),
('2026-07-24', 90003, 90009, 8),
('2026-07-24', 1, 90009, 5),
('2026-07-24', 1, 90009, 5),
('2026-07-24', 90003, 90009, 7),
('2026-07-24', 90001, 90009, 1),
('2026-07-24', 90002, 90004, 2),
('2026-07-24', 1, 90004, 10),
('2026-08-07', 90001, 90004, 10),
('2026-08-07', 2, 90004, 4),
('2026-08-07', 1, 90004, 8),
('2026-08-07', 90001, 90004, 7),
('2026-08-07', 90003, 90004, 5),
('2026-08-07', 2, 90005, 3),
('2026-08-07', 2, 90005, 4),
('2026-08-07', 90003, 90005, 9),
('2026-08-21', 90003, 90004, 3),
('2026-08-21', 1, 90004, 1),
('2026-08-21', 90001, 90004, 8),
('2026-08-21', 90001, 90004, 2),
('2026-08-21', 2, 90008, 8),
('2026-08-21', 1, 90008, 1),
('2026-09-09', 90002, 90005, 7),
('2026-09-09', 90003, 90005, 7),
('2026-09-09', 2, 90005, 5),
('2026-09-09', 90003, 90005, 2),
('2026-09-09', 90003, 90005, 8),
('2026-09-09', 90002, 90006, 10),
('2026-09-09', 90003, 90006, 7),
('2026-09-09', 2, 90006, 6),
('2026-09-09', 90002, 90006, 12),
('2026-09-09', 90001, 90008, 4),
('2026-09-09', 90003, 90008, 4),
('2026-09-09', 2, 90008, 2),
('2026-09-23', 90001, 90005, 1),
('2026-09-23', 90003, 90005, 2),
('2026-09-23', 2, 90005, 1),
('2026-09-23', 1, 90005, 2),
('2026-09-23', 1, 90008, 8),
('2026-09-23', 1, 90008, 4),
('2026-09-23', 90001, 90008, 5),
('2026-10-06', 2, 90003, 4),
('2026-10-06', 90003, 90003, 4),
('2026-10-06', 2, 90003, 7),
('2026-10-06', 90002, 90003, 2),
('2026-10-06', 1, 90003, 5),
('2026-10-06', 90001, 90007, 4),
('2026-10-06', 90002, 90007, 8),
('2026-10-06', 1, 90007, 5),
('2026-10-06', 1, 90007, 1),
('2026-10-06', 90001, 90010, 7),
('2026-10-06', 1, 90010, 3),
('2026-10-06', 2, 90010, 4),
('2026-10-14', 2, 90005, 4),
('2026-10-14', 90001, 90005, 4),
('2026-10-14', 1, 90005, 4),
('2026-10-14', 90003, 90005, 1),
('2026-10-14', 90003, 90008, 7),
('2026-10-14', 1, 90008, 9),
('2026-10-14', 2, 90008, 2),
('2026-10-14', 90002, 90008, 4),
('2026-10-14', 90002, 90008, 9),
('2026-10-14', 2, 90010, 3),
('2026-10-14', 90002, 90010, 3),
('2026-10-14', 90002, 90010, 3),
('2026-10-23', 90003, 90007, 5),
('2026-10-23', 90002, 90007, 2),
('2026-10-23', 90001, 90007, 2),
('2026-10-23', 1, 90007, 4),
('2026-10-23', 90003, 90007, 1),
('2026-10-23', 90001, 90007, 1),
('2026-10-23', 90003, 90010, 4),
('2026-10-23', 90003, 90010, 2),
('2026-10-23', 90003, 90010, 1),
('2026-10-23', 2, 90010, 1),
('2026-10-27', 1, 90003, 5),
('2026-10-27', 2, 90003, 3),
('2026-10-27', 90003, 90003, 3),
('2026-10-27', 90003, 90003, 1),
('2026-10-27', 1, 90005, 4),
('2026-10-27', 90003, 90005, 4),
('2026-10-27', 90001, 90005, 9),
('2026-10-27', 2, 90007, 5),
('2026-10-27', 90001, 90007, 2),
('2026-10-27', 90002, 90007, 1),
('2026-10-27', 90001, 90007, 4);
COMMIT;

