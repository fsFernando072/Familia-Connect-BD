CREATE DATABASE IF NOT EXISTS familia_connect;

USE familia_connect;

/* ============================================================
   CREATES
   ============================================================ */

-- 
-- Tabela: acesso
-- 
CREATE TABLE `acesso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_tela` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

-- 
-- Tabela: cargo
-- 
CREATE TABLE `cargo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

-- 
-- Tabela: categoria arquivo
-- 
CREATE TABLE `categoria_arquivo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);

-- 
-- Tabela: arquivo
-- 
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
  CONSTRAINT `arquivo_ibfk_1` FOREIGN KEY (`categoria_arquivo_id`) REFERENCES `categoria_arquivo` (`id`),
  PRIMARY KEY (`id`)
);

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

-- 
-- Tabela: funcionario
-- 
CREATE TABLE `funcionario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `foto_id` int DEFAULT NULL,
  `cargo_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  KEY `cargo_id` (`cargo_id`),
  KEY `foto_id` (`foto_id`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id`),
  CONSTRAINT `funcionario_ibfk_2` FOREIGN KEY (`foto_id`) REFERENCES `arquivo` (`id`)
);

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
  `ativo` boolean default true not null,
  PRIMARY KEY (`id`)
);

-- 
-- Tabela: produto
-- 
CREATE TABLE `produto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  `ativo` boolean default true not null,
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

-- 
-- Tabela: endereco
-- 
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
  CONSTRAINT `endereco_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`)
);

-- 
-- Tabela: familia
-- 
CREATE TABLE `familia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_cadastro` date NOT NULL,
  `endereco_id` int NOT NULL,
  `foto_id` int DEFAULT NULL,
  `possui_prioridade` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `endereco_id` (`endereco_id`),
  KEY `foto_id` (`foto_id`),
  CONSTRAINT `familia_ibfk_1` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`),
  CONSTRAINT `familia_ibfk_2` FOREIGN KEY (`foto_id`) REFERENCES `arquivo` (`id`)
);

-- 
-- Tabela: profissao
-- 
CREATE TABLE `profissao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
);

-- 
-- Tabela: grau_parentesco
-- 
CREATE TABLE `grau_parentesco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `grau` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
);

-- 
-- Tabela: pessoa
-- 
CREATE TABLE `pessoa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `rg` varchar(9) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `dt_nascimento` date NOT NULL,
  `profissao_id` int DEFAULT NULL,
  `familia_id` int NOT NULL,
  `is_responsavel` tinyint(1) NOT NULL,
  `grau_parentesco_id` int NOT NULL,
  `telefone` varchar(11) NOT NULL,
  `sexo` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profissao_id` (`profissao_id`),
  KEY `familia_id` (`familia_id`),
  KEY `grau_parentesco_id` (`grau_parentesco_id`),
  CONSTRAINT `pessoa_ibfk_1` FOREIGN KEY (`profissao_id`) REFERENCES `profissao` (`id`),
  CONSTRAINT `pessoa_ibfk_2` FOREIGN KEY (`familia_id`) REFERENCES `familia` (`id`),
  CONSTRAINT `pessoa_ibfk_3` FOREIGN KEY (`grau_parentesco_id`) REFERENCES `grau_parentesco` (`id`)
);

-- 
-- Tabela: historico_estoque
-- 
CREATE TABLE `historico_estoque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantidade` double NOT NULL,
  `data_estoque` date NOT NULL,
  `produto_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `produto_id` (`produto_id`),
  CONSTRAINT `historico_estoque_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`)
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


/* ============================================================
   INSERTS
   ============================================================ */

-- 
-- acesso
-- 
INSERT INTO `acesso` (nome_tela) VALUES 
('cadastrar_familias'),
('cadastrar_auditorias'),
('cadastrar_funcionarios'),
('cadastrar_produtos'),
('cadastrar_entregas'),
('cadastrar_acessos'),
('cadastrar_categoria'),
('cadastrar_cargos'),
('cadastrar_profissoes'),
('cadastrar_estoques'),
('editar_produtos'),
('editar_auditorias'),
('editar_familias'),
('editar_funcionarios'),
('editar_entregas'),
('editar_acessos'),
('editar_cargos'),
('editar_profissoes'),
('editar_categorias'),
('editar_estoques'),
('excluir_familias'),
('excluir_auditorias'),
('excluir_categorias'),
('excluir_produtos'),
('excluir_funcionarios'),
('excluir_entregas'),
('excluir_acessos'),
('excluir_cargos'),
('excluir_profissoes'),
('excluir_estoques'),
('listar_familias'),
('listar-categorias'),
('listar_auditorias'),
('listar_funcionarios'),
('listar_entregas'),
('listar_produtos'),
('listar_acessos'),
('listar_cargos'),
('listar_profissoes'),
('listar_estoques'),
('visualizar_arquivos');

-- 
-- cargo
-- 
INSERT INTO `cargo` VALUES 
(1, 'Diretor'),
(2, 'Recepcionista');

-- 
-- cargo_has_acesso
-- 
INSERT INTO `cargo_has_acesso` (cargo_id, acesso_id)
SELECT 1, id FROM `acesso`;

-- 
-- funcionario
-- 
INSERT INTO `funcionario` VALUES 
(1, 'João Silva', '52437201866', '$2a$10$vWlYEp1T8pbMJVL2JUgb8uhDbeFkwAOYdTtLM.Jr84kLWHLqs3BQ2', NULL, 1),
(2, 'Ana Souza',  '24704891801', '$2a$10$xKpL9mQw2nRtVbHuJdYe5OiWzA1csFgM3kD7pN6qE4rT8vX0yZ.', NULL, 2);

-- 
-- estado
-- 
INSERT INTO `estado` VALUES 
(1,'Acre','AC'),(2,'Alagoas','AL'),(3,'Amapá','AP'),(4,'Amazonas','AM'),(5,'Bahia','BA'),
(6,'Ceará','CE'),(7,'Distrito Federal','DF'),(8,'Espírito Santo','ES'),(9,'Goiás','GO'),(10,'Maranhão','MA'),
(11,'Mato Grosso','MT'),(12,'Mato Grosso do Sul','MS'),(13,'Minas Gerais','MG'),(14,'Pará','PA'),(15,'Paraíba','PB'),
(16,'Paraná','PR'),(17,'Pernambuco','PE'),(18,'Piauí','PI'),(19,'Rio de Janeiro','RJ'),(20,'Rio Grande do Norte','RN'),
(21,'Rio Grande do Sul','RS'),(22,'Rondônia','RO'),(23,'Roraima','RR'),(24,'Santa Catarina','SC'),(25,'São Paulo','SP'),
(26,'Sergipe','SE'),(27,'Tocantins','TO');

-- 
-- endereco
-- 
INSERT INTO `endereco` (cep, bairro, logradouro, numero, complemento, cidade, estado_id) VALUES 
('01310100', 'Bela Vista',    'Avenida Paulista',       '1578', 'Apto 101',  'São Paulo',       25),
('20040020', 'Centro',        'Avenida Rio Branco',      '156', 'Sala 302',  'Rio de Janeiro',  19),
('30130110', 'Centro',        'Avenida Afonso Pena',    '1500', NULL,        'Belo Horizonte',  13),
('80010020', 'Centro',        'Rua XV de Novembro',      '800', 'Casa',      'Curitiba',        16),
('40020010', 'Comercial',     'Avenida Sete de Setembro', '220', NULL,       'Salvador',         5);

-- 
-- profissao
-- 
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
-- grau_parentesco
-- 
INSERT INTO `grau_parentesco` (grau) VALUES
('Pai/Mãe'),
('Filho/Filha'),
('Avô/Avó'),
('Tio/Tia'),
('Primo/Prima'),
('Sobrinho/Sobrinha'),
('Neto/Neta'),
('Genro/Nora');

-- 
-- categoria arquivo
-- 
INSERT INTO `categoria_arquivo` (nome) VALUES
('familias'),
('funcionarios');

-- 
-- familia
-- 
INSERT INTO `familia` (data_cadastro, endereco_id, foto_id, possui_prioridade) VALUES
('2026-01-01', 1, null, 1),
('2026-01-02', 2, null, 0),
('2026-01-03', 3, null, 1),
('2026-01-04', 4, null, 0);

-- 
-- pessoa
-- Mapeamento de grau_parentesco_id: 1 = Pai, 2 = Mãe, 3 = Filho
-- 
INSERT INTO `pessoa` (nome, rg, cpf, dt_nascimento, profissao_id, familia_id, is_responsavel, grau_parentesco_id, telefone, sexo) VALUES
('João da Silva',   '334490662', '39308870881', '1985-06-15', 1,    1, 1, 1, '11940028920', 'MASCULINO'),
('Maria da Silva',  '377685094', '27131850845', '1988-09-20', 2,    1, 0, 1, '11976543210', 'FEMININO'),
('Pedro da Silva',  '283118854', '46331122877', '2012-03-10', NULL, 1, 0, 2, '11965432109', 'MASCULINO'),
('Carla Oliveira',  '376315891', '72647130833', '1990-04-12', 5,    2, 1, 1, '11955001100', 'FEMININO'),
('Lucas Oliveira',  '278403050', '27407725802', '2015-11-08', NULL, 2, 0, 2, '11955001101', 'MASCULINO'),
('Fernanda Lima',   '439955609', '29547647830', '1978-02-25', 12,   3, 1, 1, '11933445566', 'FEMININO'),
('Rafael Lima',     '174459609', '82395800848', '1975-07-30', 8,    3, 0, 1, '11933445567', 'MASCULINO'),
('Beatriz Costa',   '275066459', '73808940808', '1995-12-01', 13,   4, 1, 1, '11922334455', 'FEMININO'),
('Henrique Costa',  '468510977', '62272437877', '2018-05-20', NULL, 4, 0, 2, '11922334456', 'MASCULINO');

-- 
-- categoria
-- 
INSERT INTO `categoria` (nome) VALUES
('Alimentos'),
('Higiene Pessoal'),
('Limpeza'),
('Vestuário'),
('Medicamentos');

-- 
-- produto
-- 
INSERT INTO `produto` (nome, descricao, categoria_id) VALUES
('Cesta Básica' , 'Cesta com itens essenciais de alimentação',      1),
('Óleo de Soja 900ml' , 'Garrafa de óleo de soja 900ml',               1),
('Arroz 5kg' , 'Pacote de arroz tipo 1 5kg',                     1),
('Feijão 1kg' , 'Pacote de feijão carioca 1kg',                   1),
('Sabonete' , 'Sabonete 90g',                                  2),
('Shampoo 350ml' , 'Shampoo neutro 350ml',                          2),
('Pasta de Dente' , 'Pasta de dente com flúor 90g',                  2),
('Detergente 500ml' , 'Detergente líquido 500ml',                      3),
('Sabão em Pó 1kg' , 'Sabão em pó multiação 1kg',                    3),
('Água Sanitária 1L' , 'Água sanitária 1 litro',                        3),
('Agasalho Adulto' , 'Agasalho adulto tamanhos variados',             4),
('Roupa Infantil' , 'Kit roupa infantil sortida',                    4),
('Dipirona 500mg' , 'Dipirona sódica 500mg caixa com 20 comprimidos', 5),
('Vitamina C 1g' , 'Vitamina C efervescente 1g caixa com 10 unidades', 5);

-- 
-- historico_estoque
-- 
INSERT INTO `historico_estoque` (quantidade, data_estoque, produto_id) VALUES
(20, '2026-02-01', 1),
(20, '2026-02-01', 2),
(20, '2026-03-01', 3),
(20, '2026-03-01', 4),
(20, '2026-03-01', 5),
(20, '2026-04-01', 6),
(20, '2026-04-01', 7),
(20, '2026-04-01', 8),
(20, '2026-04-01', 1);

-- 
-- auditoria
-- 
INSERT INTO `auditoria` (tipo_log, log, dado_antigo, dado_novo, created_at, funcionario_id) VALUES
('INSERT', 'cadastro_familia',    NULL,             'familia_id=1',  '2026-01-01', 1),
('INSERT', 'cadastro_familia',    NULL,             'familia_id=2',  '2026-01-02', 1),
('UPDATE', 'edicao_produto',      'quantidade=100', 'quantidade=80', '2026-02-10', 1),
('INSERT', 'cadastro_entrega',    NULL,             'entrega_id=1',  '2026-02-15', 1),
('DELETE', 'exclusao_produto',    'produto_id=5',   NULL,            '2026-03-01', 2),
('INSERT', 'cadastro_funcionario', NULL,            'funcionario_id=2', '2026-03-05', 2);

-- 
-- entrega
-- 
INSERT INTO `entrega` (data_entrega, funcionario_id, pessoa_id, produto_id) VALUES
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