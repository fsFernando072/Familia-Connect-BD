# 🗄️ Família Connect — Banco de Dados

> Script SQL de criação e população do banco de dados do sistema Família Connect, modelado para gerenciar doações de cestas básicas a famílias em situação de vulnerabilidade social.

---

## 📋 Sobre o Projeto

Este repositório contém o schema SQL do banco de dados **MySQL** utilizado pelo sistema Família Connect. Ele define toda a estrutura relacional do sistema — tabelas, relacionamentos, constraints e dados iniciais — além de consultas auxiliares para listagem e dashboard.

---

## 📁 Estrutura do Repositório

```
Familia-Connect-BD/
├── schema.sql     # Script completo: criação das tabelas, constraints e dados iniciais
├── model.mwb      # Modelo visual do banco (MySQL Workbench)
├── model.mwb.bak  # Backup do modelo
└── README.md
```

---

## 🗂️ Diagrama de Entidades

O banco de dados é composto por **13 tabelas** com os seguintes relacionamentos:

```
estado
  └── endereco
        └── familia
              └── pessoa ──── profissao

cargo ──── cargo_has_acesso ──── acesso

funcionario (cargo)
  ├── auditoria
  └── entrega ──── pessoa
                └── produto ──── categoria
```

---

## 📊 Tabelas

| Tabela | Descrição |
|---|---|
| `familia` | Famílias beneficiárias cadastradas, com data de cadastro, endereço e prioridade |
| `pessoa` | Membros de cada família, com dados pessoais, parentesco e profissão |
| `funcionario` | Funcionários do sistema com autenticação (CPF + senha bcrypt) e cargo |
| `cargo` | Cargos dos funcionários (ex: Recepcionista, Diretor) |
| `acesso` | Permissões de tela do sistema (ex: `cadastrar_familias`, `editar_entregas`) |
| `cargo_has_acesso` | Relacionamento N:N entre cargos e acessos (controle de permissões) |
| `entrega` | Registros de entregas de produtos a pessoas, feitas por funcionários |
| `produto` | Produtos doados com nome, quantidade e categoria |
| `categoria` | Categorias dos produtos |
| `endereco` | Endereços das famílias com CEP, logradouro, bairro, cidade e estado |
| `estado` | Todos os 27 estados brasileiros com sigla |
| `profissao` | 30 profissões pré-cadastradas para vínculo com as pessoas |
| `auditoria` | Log de ações dos funcionários no sistema |

---

## 🔑 Principais Relacionamentos

- Uma **família** possui um **endereço** e pode ter várias **pessoas**
- Uma **pessoa** pode ser responsável pela família (`is_responsavel`) e ter uma **profissão**
- Um **funcionário** pertence a um **cargo**, que define seus **acessos** às telas
- Uma **entrega** vincula um **funcionário**, uma **pessoa** e um **produto**
- A tabela de **auditoria** rastreia ações dos funcionários

---

## 🌱 Dados Iniciais (Seed)

O script já popula o banco com dados essenciais para o funcionamento:

- **27 estados** brasileiros
- **28 permissões de acesso** ao sistema (cadastrar, editar, excluir e listar por módulo)
- **2 cargos** padrão: `Recepcionista` e `Diretor`
- **Todas as permissões** atribuídas ao cargo Recepcionista
- **1 funcionário** padrão com senha já criptografada em bcrypt
- **30 famílias** de exemplo com prioridades variadas
- **1 endereço** de exemplo (Av. Paulista, São Paulo)
- **3 pessoas** vinculadas a uma família de exemplo (pai, mãe e filho)
- **30 profissões** comuns pré-cadastradas

---

## ⚙️ Pré-requisitos

- [MySQL 8+](https://dev.mysql.com/downloads/)
- [MySQL Workbench](https://www.mysql.com/products/workbench/) *(opcional, para visualizar o modelo `.mwb`)*

---

## 🚀 Como Executar

### Opção A — Pelo terminal MySQL

```bash
mysql -u seu_usuario -p < schema.sql
```

### Opção B — Pelo MySQL Workbench

1. Abra o MySQL Workbench e conecte-se ao seu servidor
2. Vá em **File → Open SQL Script** e selecione `schema.sql`
3. Execute o script com `Ctrl+Shift+Enter` (ou botão ⚡)

### Opção C — Pela linha de comando dentro do MySQL

```sql
SOURCE /caminho/para/schema.sql;
```

> O script já inclui `CREATE DATABASE IF NOT EXISTS familia_connect` e `USE familia_connect`, então o banco é criado automaticamente.

---

## 🔐 Credenciais do Funcionário Padrão

O script insere um funcionário inicial para acesso ao sistema:

| Campo | Valor |
|---|---|
| Nome | João Silva |
| CPF | 52437201866 |
| Senha | `$2a$10$vW...` (bcrypt) |
| Cargo | Recepcionista |

> ⚠️ **Atenção:** troque a senha padrão após o primeiro acesso em ambiente de produção.

---

## 🔎 Consultas Incluídas

O script também traz exemplos de queries úteis para o sistema:

**Listagem de famílias** (com nome do responsável e telefone):
```sql
SELECT f.id, p.nome, SUBSTRING_INDEX(p.nome, ' ', -1) AS nomeFamilia, p.telefone
FROM familia f
INNER JOIN pessoa p ON p.familia_id = f.id
WHERE p.is_responsavel = true;
```

**Detalhes de uma família específica** (responsável primeiro):
```sql
SELECT f.id, p.*, SUBSTRING_INDEX(p.nome, ' ', -1) AS nomeFamilia
FROM familia f
INNER JOIN pessoa p ON p.familia_id = f.id
WHERE f.id = 61
ORDER BY is_responsavel DESC;
```

---

## 📄 Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
