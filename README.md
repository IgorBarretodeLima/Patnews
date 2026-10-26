[readme_md.md](https://github.com/user-attachments/files/33978043/readme_md.md)
# 📦 PatNews Systems — Gestão de Patrimônio Corporativo

![MySQL](https://img.shields.io/badge/MySQL-8.0+-00758F?style=for-the-badge&logo=mysql&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.style=for-the-badge)

> **Sistema corporativo de alto desempenho** para centralização, controle do ciclo de vida de ativos, alocações de custódia, histórico de manutenções e depreciação contábil com estrita integridade relacional.

---

## 📋 Sumário

- [1. Visão Geral e Domínio](#1-visão-geral-e-domínio)
- [2. Contextualização e Problemas Enfrentados](#2-contextualização-e-problemas-enfrentados)
- [3. Proposta de Melhoria](#3-proposta-de-melhoria)
- [4. Modelagem Lógica e Cardinalidades](#4-modelagem-lógica-e-cardinalidades)
- [5. Normalização (1FN a 4FN)](#5-normalização-1fn-a-4fn)
- [6. Estrutura do Banco de Dados (DDL e DML)](#6-estrutura-do-banco-de-dados-ddl-e-dml)
- [7. Hosting em Nuvem (Aiven Cloud)](#7-hosting-em-nuvem-aiven-cloud)
- [8. Procedimento de Dump e Backup](#8-procedimento-de-dump-e-backup)
- [9. Front-End e Deploy](#9-front-end-e-deploy)
- [10. Estrutura do Repositório](#10-estrutura-do-repositório)

---

## 1. Visão Geral e Domínio

O **PatNews Systems** foi desenvolvido para administrar de forma unificada o ciclo de vida completo dos bens corporativos (equipamentos de TI, mobiliário, veículos e maquinários industriais). A solução atende desde o processo de aquisição e atribuição de custódia até o controle de manutenção preventiva/corretiva, baixa por descarte e depreciação contábil.

### 🛠️ Tech Stack & Infraestrutura
* **Domínio:** Gestão de Patrimônio e Ativos Corporativos
* **SGBD Relacional:** MySQL / PostgreSQL
* **Cloud Hosting:** Aiven Cloud Platform (com TLS/SSL ativo)
* **Interface Web:** HTML5, CSS3 e JavaScript (Vanilla ES6+)

---

## 2. Contextualização e Problemas Enfrentados

Antes da centralização proporcionada pelo PatNews Systems, o controle patrimonial era gerido por planilhas departamentais desconectadas, resultando nos seguintes gargalos operacionais:

1. 🚨 **Inconsistência em Tombamentos:** Risco e ocorrência constante de duplicidade nos números de plaquetas/patrimônio.
2. 🕵️ **Perda de Rastreabilidade:** Movimentação física de equipamentos entre setores sem a devida atualização da custódia do colaborador responsável.
3. 💸 **Descontrole Financeiro:** Ausência de histórico consolidado dos custos com manutenções e morosidade no cálculo manual da depreciação contábil.
4. ⛓️ **Ausência de Integridade Referencial:** Alocação de ativos vinculados a setores ou colaboradores já inativos/excluídos da base.

---

## 3. Proposta de Melhoria

A implementação de um **SGBD Relacional** estruturado trouxe ganhos diretos em confiabilidade e governança de dados:

* **Unicidade de Tombamento:** Garantia de código patrimonial único via restrição `UNIQUE` no atributo `num_tombamento`.
* **Integridade Referencial Rigorosa:** Aplicação de chaves estrangeiras (`FOREIGN KEY`) conectando ativos, responsáveis, departamentos e categorias.
* **Rastreabilidade de Reparos:** Registro detalhado e auditável de datas, relatórios e custos de manutenção por ativo.
* **Automação Contábil:** Consultas SQL parametrizadas para apuração de valor residual e taxas de depreciação anual em tempo real.

---

## 4. Modelagem Lógica e Cardinalidades

### Entidades do Sistema

* **`Categorias`**: Classificação dos bens e definição da taxa de depreciação anual associada.
* **`Departamentos`**: Unidades organizacionais e identificadores de localização física (blocos/salas).
* **`Responsaveis`**: Colaboradores detentores da custódia formal dos ativos.
* **`Ativos`**: Dados patrimoniais centrais (tombamento, valor de aquisição, data de entrada e status).
* **`Manutencoes`**: Histórico de intervenções técnicas com detalhamento de custos.
* **`Fornecedores`**: Empresas parceiras e fornecedoras de bens e serviços.
* **`Ativos_Fornecedores`**: Tabela associativa que gerencia a relação muitos-para-muitos (N:M) e notas fiscais de aquisição.

### Mapeamento de Cardinalidades

| Tabela Origem | Relacionamento | Tabela Destino | Cardinalidade | Descrição |
| :--- | :---: | :--- | :---: | :--- |
| **`Categorias`** | *Classifica* | **`Ativos`** | `1:N` | Uma categoria abrange múltiplos ativos; cada ativo pertence a uma única categoria. |
| **`Departamentos`** | *Abriga* | **`Responsaveis`** | `1:N` | Um departamento aloca vários colaboradores; cada colaborador pertence a um departamento. |
| **`Responsaveis`** | *Custodia* | **`Ativos`** | `1:N` | Um colaborador custodia vários ativos; cada ativo possui um único responsável direto. |
| **`Ativos`** | *Requer* | **`Manutencoes`** | `1:N` | Um ativo pode demandar várias manutenções ao longo do seu ciclo de vida. |
| **`Ativos`** | *Adquirido De* | **`Fornecedores`** | `N:M` | Gerenciado via **`Ativos_Fornecedores`** para suportar múltiplas notas fiscais/fornecedores. |

---

## 5. Normalização (1FN a 4FN)

* **1ª Forma Normal (1FN):** Garantia de atributos atômicos e indivisíveis. Eliminação completa de campos multivalorados, listas ou tuplas repetidas.
* **2ª Forma Normal (2FN):** Todos os atributos não-chave dependem integralmente da chave primária composta na tabela associativa `Ativos_Fornecedores` (`id_ativo`, `id_fornecedor`).
* **3ª Forma Normal (3FN):** Eliminação de dependências transitivas. A taxa de depreciação é mantida estritamente na entidade `Categorias`, sem duplicação na tabela `Ativos`.
* **4ª Forma Normal (4FN):** Isolamento de dependências multivaloradas independentes, alocando o histórico de manutenções e o relacionamento com fornecedores em tabelas relacionais dedicadas.

---

## 6. Estrutura do Banco de Dados (DDL e DML)

O script SQL completo está disponível no arquivo [`script_patrimonio.sql`](./script_patrimonio.sql), contemplando:

* **DDL (Data Definition Language):** Criação das tabelas com tipagem precisa, `PRIMARY KEY`, `FOREIGN KEY` com restrições referenciais e campos com cláusula `UNIQUE`.
* **DML (Data Manipulation Language):** Inserção de dados de teste consistentes (mínimo de 5 registros por entidade).
* **15 Consultas SQL Analíticas:** Consultas demonstrativas utilizando `INNER JOIN`, `LEFT JOIN`, funções de agregação (`SUM`, `AVG`, `COUNT`), filtros avançados (`HAVING`, `BETWEEN`, `LIKE`) e subconsultas (`SUBQUERY`).

---

## 7. Hosting em Nuvem (Aiven Cloud)

O banco de dados relacional foi provisionado na plataforma em nuvem gerenciada **Aiven Cloud**:

1. **Instância Gerenciada:** Provisionamento e gerenciamento do serviço MySQL na nuvem.
2. **Segurança e Criptografia:** Requisito obrigatório de conexões seguras criptografadas via **SSL/TLS**.
3. **Conectividade Externa:** Homologado com sucesso via clientes SGBD (*DBeaver*, *MySQL Workbench*) e pela camada de front-end.

---

## 8. Procedimento de Dump e Backup

Utilize os comandos abaixo no terminal para executar rotinas de backup e restauração utilizando a ferramenta `mysqldump`:

```bash
# 1. Dump Completo (Estrutura DDL + Registros DML)
mysqldump -u root -p --databases assetcontrol_db > dump_patnews.sql

# 2. Dump Apenas da Estrutura (Somente DDL)
mysqldump -u root -p --no-data assetcontrol_db > estrutura_patnews.sql

# 3. Restauração do Banco de Dados
mysql -u root -p assetcontrol_db < dump_patnews.sql
```

---

## 9. Front-End e Deploy

A interface web foi desenvolvida com foco em leveza, responsividade e facilidade de navegação, utilizando apenas tecnologias nativas (*Vanilla Stack*):

* **Interatividade em Tempo Real:** Formulários validados no client-side para cadastro de ativos e consulta de disponibilidade.
* **Comunicação com API/Banco:** Integração para listagem de relatórios e cálculo dinâmico de depreciação.
* **Deploy:** Disponível para acesso externo via ambiente de hospedagem web.

---

## 10. Estrutura do Repositório

```text
├── 📂 sql/
│   ├── script_patrimonio.sql    # DDL, DML e as 15 Consultas SQL
│   └── dump_patnews.sql          # Dump da base de dados
├── 📂 public/
│   ├── index.html               # Interface principal do front-end
│   ├── styles.css               # Estilização responsiva
│   └── app.js                   # Lógica e manipulação de DOM em JavaScript
├── .gitignore
└── README.md                    # Documentação do projeto
```

---

<p center align="center">
  Desenvolvido para gestão e governança eficiente de ativos corporativos. 🚀
</p>
