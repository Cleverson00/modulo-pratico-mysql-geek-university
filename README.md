# Módulo Prático de MySQL: Fundamentos e Operações Avançadas (Geek University)

Este repositório contém os scripts SQL desenvolvidos durante o **Módulo MySQL (Parte Prática)** do curso **"Bancos de Dados SQL e NoSQL do Básico ao Avançado"** da **Geek University** (Udemy).

O objetivo deste módulo foi aprofundar os conhecimentos em manipulação e consulta de dados (DQL), abrangendo desde operações básicas até conceitos mais complexos como JOINS, subconsultas e funções de data e hora em MySQL.

## Conteúdo Abrangente do Módulo e Scripts:

O script `modulo_pratico_mysql.sql` está estruturado em diferentes seções, cada uma focada em um conjunto específico de funcionalidades SQL:

### 1. Seção `secao05`: Exemplo de Produtos e Tipos de Produto
* **Foco:** `SELECT` com `WHERE`, consultas simples em múltiplas tabelas (Produto Cartesiano - Junção Implícita).
* **DDL:** Criação das tabelas `tipos_produto` e `produtos`.
* **DML:** Inserção de dados de exemplo.
* **DQL:** Exemplos de consultas básicas com filtros e a demonstração da junção cartesiana.

### 2. Seção `juncao`: Exemplo de Clientes, Profissões e Consumidores
* **Foco:** Diversos tipos de `JOINS` (`INNER JOIN`, `LEFT OUTER JOIN`, `RIGHT OUTER JOIN`, `CROSS JOIN`, `FULL OUTER JOIN` (emulação via `UNION`), `SELF JOIN`).
* **DDL:** Criação das tabelas `profissoes`, `clientes` e `consumidor`.
* **DML:** Inserção de dados de exemplo.
* **DQL:** Exploração detalhada de cada tipo de `JOIN` com exemplos práticos para combinar dados de diferentes tabelas, além de filtragem e ordenação de resultados.

### 3. Seção `agregacao`: Exemplo de Produtos e Categorias
* **Foco:** Funções de Agregação (`MAX`, `MIN`, `AVG`, `ROUND`, `COUNT`, `SUM`), `GROUP BY` e `HAVING`.
* **DDL:** Criação das tabelas `categorias` e `produtos`.
* **DML:** Inserção de dados de exemplo.
* **DQL:** Demonstração de como usar funções de agregação para obter resumos de dados, agrupar resultados (`GROUP BY`) e filtrar grupos (`HAVING`).

### 4. Seção `agrupamento`: Exemplo de Produtos, Fabricantes e Tipos
* **Foco:** Consolidação de `GROUP BY`, `HAVING`, múltiplos `JOINS` e `ORDER BY`.
* **DDL:** Criação das tabelas `tipos`, `fabricantes` e `produtos`.
* **DML:** Inserção de dados de exemplo.
* **DQL:** Exercícios práticos que combinam múltiplos `JOINS` com agregações e agrupamentos para responder a questões de negócio mais complexas, além de ordenação dos resultados.

### 5. Seção `subconsulta`: Exemplo de Escritórios, Funcionários e Pagamentos
* **Foco:** Subconsultas e Funções de Data e Hora.
* **DDL:** Criação das tabelas `escritorios`, `funcionarios` e `pagamentos`.
* **DML:** Inserção de dados de exemplo.
* **DQL:** Exemplos de subconsultas para filtrar e selecionar dados de forma dinâmica.
* **Funções de Data e Hora:** Demonstração de uma vasta gama de funções MySQL para manipulação e extração de informações de datas e horas (`CURDATE`, `CURTIME`, `DATE_ADD`, `DATE_SUB`, `DATEDIFF`, `DATE_FORMAT`, `DAYNAME`, `DAYOFMONTH`, `DAYOFWEEK`, `DAYOFYEAR`, `FROM_DAYS`, `NOW`, `TIME`, `SEC_TO_TIME`, `TIME_TO_SEC`, `HOUR`, `MINUTE`, `SECOND`, `PERIOD_DIFF`, `TIMEDIFF`, `QUARTER`, `WEEK`, `WEEKDAY`, `YEAR`, `MONTH`, `DAY`).

Este módulo proporcionou uma base sólida para a manipulação e consulta de dados em MySQL, essencial para qualquer desenvolvedor ou analista de dados.

---

**Autor:** Cleverson Moura Andrade
