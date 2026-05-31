CREATE DATABASE IF NOT EXISTS familia_connect;

USE familia_connect;

DROP TABLE IF EXISTS `auditoria`;
DROP TABLE IF EXISTS `entrega`;
DROP TABLE IF EXISTS `pessoa`;
DROP TABLE IF EXISTS `familia`;
DROP TABLE IF EXISTS `endereco`;
DROP TABLE IF EXISTS `funcionario`;
DROP TABLE IF EXISTS `cargo_has_acesso`;
DROP TABLE IF EXISTS `cargo`;
DROP TABLE IF EXISTS `acesso`;
DROP TABLE IF EXISTS `categoria`;
DROP TABLE IF EXISTS `produto`;
DROP TABLE IF EXISTS `profissao`;
DROP TABLE IF EXISTS `estado`;

-- 
-- Tabela: acesso
-- 
CREATE TABLE `acesso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_tela` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `acesso` (nome_tela) VALUES 
('cadastrar_familias'),
('cadastrar_funcionarios'),
('cadastrar_produtos'),
('cadastrar_entregas'),
('cadastrar_acessos'),
('cadastrar_cargos'),
('cadastrar_profissoes'),

('editar_produtos'),
('editar_familias'),
('editar_funcionarios'),
('editar_entregas'),
('editar_acessos'),
('editar_cargos'),
('editar_profissoes'),

('excluir_familias'),
('excluir_produtos'),
('excluir_funcionarios'),
('excluir_entregas'),
('excluir_acessos'),
('excluir_cargos'),
('excluir_profissoes'),

('listar_familias'),
('listar_funcionarios'),
('listar_entregas'),
('listar_produtos'),
('listar_acessos'),
('listar_cargos'),
('listar_profissoes');

-- 
-- Tabela: cargo
-- 
CREATE TABLE `cargo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `cargo` VALUES (1,'Recepcionista'),(2,'Diretor');

-- 
-- Tabela: cargo_has_acesso
-- 
CREATE TABLE `cargo_has_acesso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cargo_id` int NOT NULL,
  `acesso_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cargo_id` (`cargo_id`),
  KEY `acesso_id` (`acesso_id`),
  CONSTRAINT `cargo_has_acesso_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id`),
  CONSTRAINT `cargo_has_acesso_ibfk_2` FOREIGN KEY (`acesso_id`) REFERENCES `acesso` (`id`)
);

INSERT INTO `cargo_has_acesso` (cargo_id, acesso_id)
SELECT 1, id 
FROM `acesso`;

select * from cargo_has_acesso;

-- 
-- Tabela: funcionario
-- 
CREATE TABLE `funcionario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `foto_funcionario` varchar(100) DEFAULT NULL,
  `cargo_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  KEY `cargo_id` (`cargo_id`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id`)
);

INSERT INTO `funcionario` VALUES (1,'João Silva','52437201866','$2a$10$vWlYEp1T8pbMJVL2JUgb8uhDbeFkwAOYdTtLM.Jr84kLWHLqs3BQ2',NULL,1);

-- 
-- Tabela: auditoria
-- 
CREATE TABLE `auditoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_log` varchar(45) DEFAULT NULL,
  `log` varchar(45) DEFAULT NULL,
  `dado_antigo` varchar(45) DEFAULT NULL,
  `dado_novo` varchar(45) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `funcionario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `funcionario_id` (`funcionario_id`),
  CONSTRAINT `auditoria_ibfk_1` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`)
);

-- 
-- Tabela: categoria
-- 
CREATE TABLE `categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

-- 
-- Tabela: produto
-- 
CREATE TABLE `produto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `quantidade` int NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`)
);

-- 
-- Tabela: estado
-- 
CREATE TABLE `estado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `sigla` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `estado` VALUES 
(1,'Acre','AC'),(2,'Alagoas','AL'),(3,'Amapá','AP'),(4,'Amazonas','AM'),(5,'Bahia','BA'),
(6,'Ceará','CE'),(7,'Distrito Federal','DF'),(8,'Espírito Santo','ES'),(9,'Goiás','GO'),(10,'Maranhão','MA'),
(11,'Mato Grosso','MT'),(12,'Mato Grosso do Sul','MS'),(13,'Minas Gerais','MG'),(14,'Pará','PA'),(15,'Paraíba','PB'),
(16,'Paraná','PR'),(17,'Pernambuco','PE'),(18,'Piauí','PI'),(19,'Rio de Janeiro','RJ'),(20,'Rio Grande do Norte','RN'),
(21,'Rio Grande do Sul','RS'),(22,'Rondônia','RO'),(23,'Roraima','RR'),(24,'Santa Catarina','SC'),(25,'São Paulo','SP'),
(26,'Sergipe','SE'),(27,'Tocantins','TO');

-- 
-- Tabela: endereco
-- 
CREATE TABLE `endereco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cep` varchar(8) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `logradouro` varchar(80) NOT NULL,
  `numero` int NOT NULL,
  `complemento` varchar(45) DEFAULT NULL,
  `cidade` varchar(50) NOT NULL,
  `estado_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `estado_id` (`estado_id`),
  CONSTRAINT `endereco_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`)
);

-- 
-- Tabela: familia
-- 
CREATE TABLE `familia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_cadastro` date NOT NULL,
  `endereco_id` int NOT NULL,
  `foto_familia` varchar(100) DEFAULT NULL,
  `possui_prioridade` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `endereco_id` (`endereco_id`),
  CONSTRAINT `familia_ibfk_1` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`)
);

-- 
-- Tabela: profissao
-- 
CREATE TABLE `profissao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `profissao` VALUES 
(1,'Balconista e vendedor de loja'),(2,'Condutor de automóvel, táxi e caminhonete'),(3,'Pedreiro'),(4,'Trabalhador de limpeza de interiores'),
(5,'Trabalhador de serviços domésticos'),(6,'Auxiliar administrativo'),(7,'Faxineiro'),(8,'Motorista de caminhão'),
(9,'Vendedor do comércio varejista'),(10,'Auxiliar de escritório'),(11,'Trabalhador rural'),(12,'Cozinheiro'),
(13,'Operador de caixa'),(14,'Professor de ensino fundamental'),(15,'Técnico em enfermagem'),(16,'Ajudante de obras'),
(17,'Empregado doméstico'),(18,'Segurança'),(19,'Carpinteiro'),(20,'Eletricista'),
(21,'Enfermeiro'),(22,'Garçom'),(23,'Trabalhador de produção industrial'),(24,'Contador'),
(25,'Analista administrativo'),(26,'Desenvolvedor de software'),(27,'Médico'),(28,'Professor de ensino médio'),
(29,'Técnico de manutenção'),(30,'Auxiliar de logística');

-- 
-- Tabela: pessoa
-- 
CREATE TABLE `pessoa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `rg` varchar(9) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `dt_nascimento` date NOT NULL,
  `is_trabalhando` tinyint(1) NOT NULL,
  `profissao_id` int DEFAULT NULL,
  `familia_id` int NOT NULL,
  `is_responsavel` tinyint(1) NOT NULL,
  `grau_parentesco` varchar(45) NOT NULL,
  `telefone` varchar(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profissao_id` (`profissao_id`),
  KEY `familia_id` (`familia_id`),
  CONSTRAINT `pessoa_ibfk_1` FOREIGN KEY (`profissao_id`) REFERENCES `profissao` (`id`),
  CONSTRAINT `pessoa_ibfk_2` FOREIGN KEY (`familia_id`) REFERENCES `familia` (`id`)
);

-- 
-- Tabela: entrega
-- 
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
  CONSTRAINT `entrega_ibfk_1` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`),
  CONSTRAINT `entrega_ibfk_2` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`),
  CONSTRAINT `entrega_ibfk_3` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`)
);

INSERT INTO familia (data_cadastro, endereco_id, foto_familia, possui_prioridade) VALUES
('2025-01-01', 1,  'familia_01.jpg', 1),
('2025-01-02', 1,  'familia_02.jpg', 0),
('2025-01-03', 1,  'familia_03.jpg', 1),
('2025-01-04', 1,  'familia_04.jpg', 0),
('2025-01-05', 1,  'familia_05.jpg', 1),
('2025-01-06', 1,  'familia_06.jpg', 0),
('2025-01-07', 1,  'familia_07.jpg', 1),
('2025-01-08', 1,  'familia_08.jpg', 0),
('2025-01-09', 1,  'familia_09.jpg', 1),
('2025-01-10', 1, 'familia_10.jpg', 0),
('2025-01-11', 1, 'familia_11.jpg', 1),
('2025-01-12', 1, 'familia_12.jpg', 0),
('2025-01-13', 1, 'familia_13.jpg', 1),
('2025-01-14', 1, 'familia_14.jpg', 0),
('2025-01-15', 1, 'familia_15.jpg', 1),
('2025-01-16', 1, 'familia_16.jpg', 0),
('2025-01-17', 1, 'familia_17.jpg', 1),
('2025-01-18', 1, 'familia_18.jpg', 0),
('2025-01-19', 1, 'familia_19.jpg', 1),
('2025-01-20', 1, 'familia_20.jpg', 0),
('2025-01-21', 1, 'familia_21.jpg', 1),
('2025-01-22', 1, 'familia_22.jpg', 0),
('2025-01-23', 1, 'familia_23.jpg', 1),
('2025-01-24', 1, 'familia_24.jpg', 0),
('2025-01-25', 1, 'familia_25.jpg', 1),
('2025-01-26', 1, 'familia_26.jpg', 0),
('2025-01-27', 1, 'familia_27.jpg', 1),
('2025-01-28', 1, 'familia_28.jpg', 0),
('2025-01-29', 1, 'familia_29.jpg', 1),
('2025-01-30', 1, 'familia_30.jpg', 0);

INSERT INTO endereco (
    cep,
    bairro,
    logradouro,
    numero,
    complemento,
    cidade,
    estado_id
) VALUES (
    '01310100',
    'Bela Vista',
    'Avenida Paulista',
    1578,
    'Apto 101',
    'São Paulo',
    1
);

/* POVOANDO PESSOAS NA FAMILIA X */
INSERT INTO pessoa (
    nome,
    rg,
    cpf,
    dt_nascimento,
    is_trabalhando,
    profissao_id,
    familia_id,
    is_responsavel,
    grau_parentesco,
    telefone
) VALUES('João da Silva','123456789','12345678901','1985-06-15', 1, 1, 61 ,1,'Pai', '1194002892'),
		('Maria da Silva','987654321','98765432101','1988-09-20', 1, 2, 61, 0,'Mãe','11976543210'),
		('Pedro da Silva','456789123','45678912301','2012-03-10', 0, null, 61, 0,'Filho','11965432109');
        
        
/* TRAZER DADOS DA FAMILIA PARA LISTAGEM  | SELECT * FROM FAMILIAS*/
SELECT
	f.id as idFamilia,
	p.nome as nomeResponsavel,
    SUBSTRING_INDEX(p.nome, ' ', -1) as nomeFamilia,
    p.telefone as telefoneResponsavel
    FROM familia as f
    INNER JOIN pessoa p ON
    p.familia_id = f.id
    WHERE p.is_responsavel = true;
    
/* TRAZER DADOS DOS DETALHES DA FAMILIA X COMEÇANDO PELO RESPONSÁVEL  | SELECT * FROM FAMILAI WHERE ID X*/
SELECT
	f.id as idFamilia,
	p.*,
    SUBSTRING_INDEX(p.nome, ' ', -1) as nomeFamilia
    FROM familia as f
    INNER JOIN pessoa p ON
    p.familia_id = f.id
    WHERE f.id = 61
    ORDER BY is_responsavel DESC;

/* SELECTS PARA OS DADOS DA DASHBOARD */
/* % de famílias atendidas no mês */
select * from familia;
select * from entrega;

    