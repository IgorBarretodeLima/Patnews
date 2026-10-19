# 📦 AssetControl Systems — Gestão de Patrimônio Corporativo

> Sistema de Gestão de Ativos e Patrimônio desenvolvido para centralizar o controle de bens, movimentações, manutenções e depreciação com alta integridade e desempenho.

---

## 📋 Sumário
- [1. Visão Geral e Domínio](#1-visão-geral-e-domínio)
- [2. Contextualização e Problemas Enfrentados](#2-contextualização-e-problemas-enfrentados)
- [3. Proposta de Melhoria](#3-proposta-de-melhoria)
- [4. Modelagem Lógica e Cardinalidades](#4-modelagem-lógica-e-cardinalidades)
- [5. Normalização (1FN a 4FN)](#5-normalização-1fn-a-4fn)
- [6. Estrutura do Banco de Dados (DDL e DML)](#6-estrutura-do-banco-de-dados-ddl-e-dml)
- [7. Hosting em Nuvem (Aiven / Azure)](#7-hosting-em-nuvem-aiven--azure)
- [8. Procedimento de Dump e Backup](#8-procedimento-de-dump-e-backup)
- [9. Front-End e Deploy](#9-front-end-e-deploy)
- [10. Estrutura do Repositório](#10-estrutura-do-repositório)

---

## 1. Visão Geral e Domínio

* **Domínio:** Gestão de Patrimônio e Ativos Corporativos
* **SGBD Utilizado:** MySQL / PostgreSQL
* **Hospedagem em Nuvem:** Aiven Cloud Platform
* **Front-End Explicativo:** HTML5, CSS3, JavaScript

O **AssetControl Systems** foi projetado para controlar todo o ciclo de vida dos ativos de uma empresa (equipamentos de TI, mobiliário, veículos e máquinas), desde a compra até a baixa por depreciação ou descarte.

---

## 2. Contextualização e Problemas Enfrentados

A empresa mantinha o controle por meio de planilhas locais por departamento, gerando:

1. **Inconsistência em Tombamentos:** Risco de duplicidade de códigos de patrimônio.
2. **Perda de Rastreabilidade:** Equipamentos movidos entre setores sem registro do responsável atual.
3. **Descontrole Financeiro:** Dificuldade em calcular a depreciação acumulada dos bens e o histórico de custos com manutenção.
4. **Ausência de Integridade:** Exclusão acidental de setores deixando ativos órfãos no sistema.

---

## 3. Proposta de Melhoria

Com o **SGBD Relacional**, foram garantidos:

* **Unicidade de Tombamento:** Restrição `UNIQUE` no número de patrimônio (`num_tombamento`).
* **Integridade Referencial:** Vínculos estritos via *Foreign Keys* entre ativos, responsáveis, departamentos e categorias.
* **Histórico Contábil e Manutenções:** Registro individualizado de manutenções e consulta de valor patrimonial atualizado em tempo real.

---

## 4. Modelagem Lógica e Cardinalidades

| Tabela Origem | Relacionamento | Tabela Destino | Cardinalidade |
| :--- | :---: | :--- | :---: |
| **Categorias** | Classifica | **Ativos** | `1:N` |
| **Departamentos** | Abriga | **Responsaveis** | `1:N` |
| **Responsaveis** | Custodia | **Ativos** | `1:N` |
| **Ativos** | Requer | **Manutencoes** | `1:N` |
| **Ativos** | Adquirido De | **Fornecedores** | `N:M` (*Via `Ativos_Fornecedores`*) |

---

## 5. Normalização (1FN a 4FN)

* **1FN:** Eliminação de campos compostos ou multivalorados.
* **2FN:** Garantia de dependência funcional total em chaves primárias compostas (`Ativos_Fornecedores`).
* **3FN:** Separação das taxas de depreciação na tabela `Categorias`.
* **4FN:** Separação de histórico de manutenções em entidade própria.

---

## 6. Estrutura do Banco de Dados

Script disponível em: 👉 [`script_patrimonio.sql`](./script_patrimonio.sql)

Contém DDL, DML (mínimo 5 registros por tabela) e **15 Consultas SQL** avançadas (`INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, `SUBQUERY`, etc.).

---

## 7. Hosting em Nuvem (Aiven)

Servidor MySQL provisionado no **Aiven Cloud**, configurado para conexões seguras (SSL) com integração remota testada e aprovada.

---

## 8. Dump e Backup

```bash
# Gerar Dump Completo
mysqldump -u root -p --databases assetcontrol_db > dump_assetcontrol.sql

# Restaurar
mysql -u root -p assetcontrol_db < dump_assetcontrol.sql