-- ###############################################################
-- # PROJETO: MÓDULO PRÁTICO MYSQL - GEEK UNIVERSITY (UDEMY)
-- # Foco: Manipulação e Consulta de Dados (DQL, Agregações, Joins, Subconsultas, Funções de Data/Hora)
-- ###############################################################
-- Autor: Cleverson Moura Andrade
/* Descrição: Este script SQL contém a criação de diversos bancos de dados,
 tabelas, inserção de dados e uma vasta gama de consultas (DQL)
 desenvolvidas durante o módulo prático de MySQL do curso */
-- "Bancos de Dados SQL e NoSQL do Básico ao Avançado" da Geek University.
--  Criação e gerenciamento de esquemas (DDL)
-- - Inserção de dados (DML)
-- - Filtragem básica e avançada (WHERE)
-- - Diferentes tipos de JOINS (INNER, LEFT, RIGHT, CROSS, FULL OUTER (emulado), SELF JOIN)
-- - Funções de agregação (MAX, MIN, AVG, ROUND, COUNT, SUM)
-- - Agrupamento de dados (GROUP BY)
-- - Filtragem de grupos (HAVING)
-- - Ordenação de resultados (ORDER BY)
-- - Subconsultas
-- - Manipulação de datas e horas com funções específicas
-- ###############################################################

-- ####################################################################################
-- # BANCO DE DADOS: secao05 (Exemplo de Produtos e Tipos de Produto)
-- # Foco: SELECT com WHERE, Consulta Simples em Múltiplas Tabelas (Produto Cartesiano) #
-- ####################################################################################

CREATE DATABASE secao05;
USE secao05;

-- Criação da tabela de tipos de produto
CREATE TABLE tipos_produto (
    codigo INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(30) NOT NULL,
    PRIMARY KEY (codigo)
);

-- Criação da tabela de produtos
CREATE TABLE produtos(
    codigo INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(30) NOT NULL,
    codigo_tipo INT NOT NULL,
    preco DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_tipo) REFERENCES tipos_produto(codigo)
);

-- Inserção de dados na tabela tipos_produto
INSERT INTO tipos_produto (descricao) VALUES ('Computador');
INSERT INTO tipos_produto (descricao) VALUES ('Impressora');

-- Inserção de dados na tabela produtos
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Desktop', '1200', 1);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Laptop', '1800', 1);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Impr. Jato Tinta', '300', 2);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Impr. Laser', '500', 2);

-- Consultas de seleção básica com WHERE
SELECT * FROM tipos_produto WHERE codigo = 1;
SELECT codigo, descricao FROM tipos_produto WHERE codigo = 2;
SELECT * FROM produtos WHERE descricao = 'Laptop';
SELECT codigo, descricao, codigo_tipo FROM produtos WHERE preco <= 500;

-- Consulta em múltiplas tabelas usando Produto Cartesiano (Junção Implícita)
-- Pergunta: Como listar o código, descrição e preço de todos os produtos,
-- juntamente com a descrição do tipo de produto correspondente?
SELECT
    p.codigo AS Código,
    p.descricao AS Descrição,
    p.preco AS Preço,
    tp.descricao AS 'Tipo Produto'
FROM
    produtos AS p,
    tipos_produto AS tp
WHERE
    p.codigo_tipo = tp.codigo;


-- ###########################################################################
-- # BANCO DE DADOS: juncao (Exemplo de Clientes, Profissões e Consumidores) #
-- # Foco: Diversos tipos de JOINS (INNER, LEFT, RIGHT, CROSS, FULL OUTER, SELF) #
-- ###########################################################################

CREATE DATABASE juncao;
USE juncao;

-- Criação da tabela de profissões
CREATE TABLE profissoes (
    id INT NOT NULL AUTO_INCREMENT,
    cargo VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

-- Criação da tabela de clientes
CREATE TABLE clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(10) NOT NULL,
    id_profissao INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_profissao) REFERENCES profissoes (id)
);

-- Criação da tabela de consumidor (para Self Join)
CREATE TABLE consumidor (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    contato VARCHAR(50) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    cep VARCHAR(20) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

-- Inserção de dados na tabela profissoes
INSERT INTO profissoes (cargo) VALUES ('Programador');
INSERT INTO profissoes (cargo) VALUES ('Analista de Sistemas');
INSERT INTO profissoes (cargo) VALUES ('Suporte');
INSERT INTO profissoes (cargo) VALUES ('Gerente');

-- Inserção de dados na tabela clientes
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('João Pereira', '1981-06-15', '1234-5688', 1);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Ricardo da Silva', '1973-10-10', '2234-5669', 2);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Felipe Oliveira', '1987-08-01', '4234-5640', 3);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Mario Pirez', '1991-02-05', '5234-5621', 1);

-- Inserção de dados na tabela consumidor
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Alfredo Nunes', 'Maria Nunes', 'Rua da paz, 47', 'São Paulo', '123.456-87', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Ana Trujillo', 'Guilherme Souza', 'Rua Dourada, 452', 'Goiania', '232.984-23', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Leandro Veloz', 'Pedro Siqueira', 'Rua Vazia, 72', 'São Paulo', '936.738-23', 'Brasil');

-- JUNÇÃO DE PRODUTO CARTESIANO (Junção Implícita com WHERE)
-- Pergunta: Listar ID, nome, data de nascimento, telefone de todos os clientes,
-- juntamente com o cargo de sua respectiva profissão.
SELECT
    c.id,
    c.nome AS Nome,
    c.data_nascimento AS Data_de_Nascimento,
    c.telefone AS Contato,
    p.cargo AS Profissão
FROM
    clientes AS c,
    profissoes AS p
WHERE
    c.id_profissao = p.id;

-- Pergunta: Exibir o nome dos clientes e suas datas de nascimento,
-- apenas para aqueles clientes que são 'Analistas de Sistemas'.
SELECT
    c.nome AS Nome,
    c.data_nascimento AS Data_de_Nascimento,
    p.cargo AS Profissão
FROM
    clientes AS c,
    profissoes AS p
WHERE
    c.id_profissao = p.id
    AND p.cargo = 'Analista de Sistemas';

-- Pergunta: Listar nome do cliente, telefone e cargo da profissão
-- para todos os clientes que nasceram após 1985.
SELECT
    c.nome AS Nomes,
    c.telefone AS Contato,
    p.cargo AS Profissão
FROM
    clientes AS c,
    profissoes AS p
WHERE
    c.id_profissao = p.id
    AND YEAR(c.data_nascimento) > 1985;

-- INNER JOIN (Junção Explícita)
SELECT
    c.id,
    c.nome,
    c.data_nascimento,
    c.telefone,
    p.cargo
FROM
    clientes AS c
INNER JOIN
    profissoes AS p
ON
    c.id_profissao = p.id;

-- Pergunta: Crie uma consulta que retorne o ID do cliente, o nome completo do cliente,
-- a data de nascimento, o telefone e o cargo de sua profissão, usando INNER JOIN.
SELECT
    c.id,
    c.nome AS Nomes,
    c.data_nascimento AS Data_de_Nascimento,
    c.telefone AS Contato,
    p.cargo AS Profissão
FROM
    clientes AS c
INNER JOIN
    profissoes AS p
ON
    c.id_profissao = p.id;

-- Pergunta: Mostre o nome do cliente, o telefone e o cargo da profissão,
-- apenas para aqueles clientes que possuem o cargo de 'Suporte'.
SELECT
    c.nome AS Nome,
    c.telefone AS Contato,
    p.cargo AS Profissão
FROM
    clientes AS C
INNER JOIN
    profissoes AS p
ON
    c.id_profissao = p.id
    AND p.cargo = 'Suporte';

-- Pergunta: Liste o ID do cliente, o nome do cliente e o cargo da profissão,
-- somente para os clientes que nasceram entre 1970 e 1985
-- (inclusive ambos os anos).
SELECT
    c.id,
    c.nome AS Nome,
    p.cargo AS Profissão
FROM
    clientes AS c
INNER JOIN
    profissoes AS p
ON
    c.id_profissao = p.id
    AND YEAR(c.data_nascimento) >= 1970
    AND YEAR(c.data_nascimento) <= 1985;

-- Pergunta: Exiba o nome do cliente e o cargo da profissão para todos os registros,
-- e ordene o resultado primeiramente pelo nome da profissão em ordem alfabética e,
-- em seguida, pelo nome do cliente também em ordem alfabética.
SELECT
    c.nome AS Nome,
    p.cargo AS Profissão
FROM
    clientes AS c
INNER JOIN
    profissoes AS p
ON
    c.id_profissao = p.id
ORDER BY
    p.cargo ASC,
    c.nome ASC;

-- LEFT OUTER JOIN
SELECT *
FROM clientes
LEFT OUTER JOIN profissoes
ON clientes.id_profissao = profissoes.id;

-- RIGHT OUTER JOIN
SELECT *
FROM clientes
RIGHT OUTER JOIN profissoes
ON clientes.id_profissao = profissoes.id;

-- Full Outer Join (Não funciona nativamente no MySQL - Emulação via UNION)
-- A sintaxe abaixo não é suportada diretamente no MySQL:
-- SELECT * FROM clientes FULL OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id;

-- Emulação de FULL OUTER JOIN no MySQL usando UNION de LEFT e RIGHT JOIN
SELECT *
FROM clientes
LEFT OUTER JOIN profissoes
ON clientes.id_profissao = profissoes.id
UNION
SELECT *
FROM clientes
RIGHT OUTER JOIN profissoes
ON clientes.id_profissao = profissoes.id;

-- CROSS JOIN
SELECT
    c.id,
    c.nome,
    c.data_nascimento,
    c.telefone,
    p.cargo
FROM
    clientes AS c
CROSS JOIN
    profissoes AS p;

-- SELF JOIN (Junção da tabela 'consumidor' com ela mesma)
SELECT
    a.nome AS Consumidor1,
    b.nome AS Consumidor2,
    a.cidade
FROM
    consumidor AS a
INNER JOIN
    consumidor AS b
ON
    a.id <> b.id
    AND a.cidade = b.cidade
ORDER BY
    a.cidade;


-- ###############################################################################
-- # BANCO DE DADOS: agregacao (Exemplo de Produtos e Categorias)                #
-- # Foco: Funções de Agregação (MAX, MIN, AVG, ROUND, COUNT, SUM), GROUP BY, HAVING #
-- ###############################################################################

CREATE DATABASE agregacao;
USE agregacao;

-- Criação da tabela de categorias
CREATE TABLE categorias (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

-- Criação da tabela de produtos
CREATE TABLE produtos (
    id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(60) NOT NULL,
    preco_venda DECIMAL(8,2) NOT NULL,
    preco_custo DECIMAL(8,2) NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

-- Inserção de dados na tabela categorias
INSERT INTO categorias (nome) VALUES ('Material Escolar');
INSERT INTO categorias (nome) VALUES ('Acessório Informática');
INSERT INTO categorias (nome) VALUES ('Material Escritório');
INSERT INTO categorias (nome) VALUES ('Game');

-- Inserção de dados na tabela produtos
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria) VALUES ('Caderno', '5.45', '2.30', 1);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria) VALUES ('Caneta', '1.20', '0.45', 1);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria) VALUES ('Pendrive 32GB', '120.54', '32.55', 2);
INSERT INTO produtos (descricao, preco_venda, preco_custo, id_categoria) VALUES ('Mouse', '17.00', '4.30', 2);

-- Funções de Agregação

-- Pergunta: Qual é o preço de venda mais alto entre todos os produtos cadastrados?
SELECT MAX(preco_venda)
FROM produtos;

-- Pergunta: Qual é o preço de venda mais baixo entre todos os produtos cadastrados?
SELECT MIN(preco_venda)
FROM produtos;

-- Pergunta: Calcule o preço de venda médio de todos os produtos.
SELECT AVG(preco_venda)
FROM produtos;

-- Pergunta: Calcule o preço de venda médio de todos os produtos,
-- mas arredonde o resultado para duas casas decimais.
SELECT ROUND(AVG(preco_venda), 2)
FROM produtos;

-- Pergunta: Quantos produtos estão cadastrados no total?
SELECT COUNT(preco_venda)
FROM produtos;

-- Agrupamento de Dados (GROUP BY)
-- Pergunta: Mostre o nome de cada categoria e a quantidade de produtos que pertencem a ela.
SELECT
    c.nome AS Categoria,
    COUNT(p.id) AS Quantidade_Produtos
FROM
    produtos AS p
INNER JOIN
    categorias AS c
ON
    p.id_categoria = c.id
GROUP BY
    c.nome;

-- Filtragem de Grupos (HAVING)
-- Pergunta: Liste o nome das categorias que possuem mais de 1 produto.
SELECT
    c.nome AS Categoria,
    COUNT(p.id) AS Quantidade_Produtos
FROM
    produtos AS p
INNER JOIN
    categorias AS c
ON
    p.id_categoria = c.id
GROUP BY
    c.nome
HAVING
    COUNT(p.id) > 1;


-- ##############################################################################
-- # BANCO DE DADOS: agrupamento (Exemplo de Produtos, Fabricantes e Tipos)   #
-- # Foco: GROUP BY, HAVING, Múltiplos JOINS, ORDER BY                       #
-- ##############################################################################

CREATE DATABASE agrupamento;
USE agrupamento;

-- Criação da tabela de tipos
CREATE TABLE tipos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

-- Criação da tabela de fabricantes
CREATE TABLE fabricantes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

-- Criação da tabela de produtos
CREATE TABLE produtos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    id_fabricante INT NOT NULL,
    quantidade INT NOT NULL,
    id_tipo INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id),
    FOREIGN KEY (id_tipo) REFERENCES tipos(id)
);

-- Inserção de dados na tabela tipos
INSERT INTO tipos (nome) VALUES ('Console');
INSERT INTO tipos (nome) VALUES ('Notebook');
INSERT INTO tipos (nome) VALUES ('Celular');
INSERT INTO tipos (nome) VALUES ('Smartphone');
INSERT INTO tipos (nome) VALUES ('Sofá');
INSERT INTO tipos (nome) VALUES ('Armário');
INSERT INTO tipos (nome) VALUES ('Refrigerador');

-- Inserção de dados na tabela fabricantes
INSERT INTO fabricantes (nome) VALUES ('Sony');
INSERT INTO fabricantes (nome) VALUES ('Dell');
INSERT INTO fabricantes (nome) VALUES ('Microsoft');
INSERT INTO fabricantes (nome) VALUES ('Samsung');
INSERT INTO fabricantes (nome) VALUES ('Apple');
INSERT INTO fabricantes (nome) VALUES ('Beline');
INSERT INTO fabricantes (nome) VALUES ('Magno');
INSERT INTO fabricantes (nome) VALUES ('CCE');
INSERT INTO fabricantes (nome) VALUES ('Nintendo');

-- Inserção de dados na tabela produtos
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Playstation 3', 1, 100, 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Core 2 Duo 4GB RAM 500GB HD', 2, 200, 2);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Xbox 360 120GB', 3, 350, 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('GT-I6220 Quad band', 4, 300, 3);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('iPhone 4 32GB', 5, 50, 4);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Playstation 2', 1, 100, 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Sofá Estofado', 6, 200, 5);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Armário de Serviço', 7, 50, 6);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Refrigerador 420L', 8, 200, 7);
INSERT INTO produtos (nome, id_fabricante, quantidade, id_tipo) VALUES ('Wii 120GB', 8, 250, 1);

-- Consulta de Produto Cartesiano (apenas para demonstração de junção implícita sem WHERE)
SELECT * FROM fabricantes, produtos, tipos;

-- Exercício 1: Mostre o nome de cada fabricante e a quantidade total de produtos que cada um fabrica.
SELECT
    f.nome AS Fabricante,
    SUM(p.quantidade) AS Quantidade_Total
FROM
    fabricantes AS f
INNER JOIN
    produtos AS p
ON
    f.id = p.id_fabricante
GROUP BY
    f.nome;

-- Exercício 2: Liste o nome dos fabricantes que possuem mais de 2 produtos cadastrados.
SELECT
    f.nome AS Nome
FROM
    fabricantes AS f
INNER JOIN
    produtos AS p
ON
    f.id = p.id_fabricante
GROUP BY
    f.nome
HAVING
    COUNT(p.quantidade) > 2;

-- Exercício 3: Exiba o nome de todos os produtos, o nome do seu fabricante e o nome do seu tipo,
-- ordenando os resultados pelo nome do produto em ordem alfabética crescente (A-Z).
SELECT
    p.nome AS Produto,
    f.nome AS Fabricante,
    t.nome AS Tipo
FROM
    produtos AS p
INNER JOIN
    fabricantes AS f
ON
    p.id_fabricante = f.id
INNER JOIN
    tipos AS t
ON
    p.id_tipo = t.id
ORDER BY
    p.nome ASC;

-- Exercício 4: Liste o nome dos produtos, o nome do fabricante e a quantidade em estoque.
-- Ordene os resultados pela quantidade em estoque, da maior para a menor (descrescente).
SELECT
    p.nome AS Nome,
    f.nome AS Fabricante,
    p.quantidade AS Quantidade
FROM
    produtos AS p
INNER JOIN
    fabricantes AS f
ON
    p.id_fabricante = f.id
ORDER BY
    p.quantidade DESC;


-- ######################################################################
-- # BANCO DE DADOS: subconsulta (Exemplo de Escritórios, Funcionários e Pagamentos) #
-- # Foco: Subconsultas, Funções de Data e Hora                           #
-- ######################################################################

CREATE DATABASE subconsulta;
USE subconsulta;

-- Criação da tabela de escritórios
CREATE TABLE escritorios (
    id INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

-- Criação da tabela de funcionários
CREATE TABLE funcionarios (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL,
    id_escritorio INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_escritorio) REFERENCES escritorios(id)
);

-- Criação da tabela de pagamentos
CREATE TABLE pagamentos (
    id INT NOT NULL AUTO_INCREMENT,
    id_funcionario INT NOT NULL,
    salario DECIMAL(8,2) NOT NULL,
    data DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id)
);

-- Inserção de dados na tabela escritorios
INSERT INTO escritorios (pais) VALUES ('Brasil');
INSERT INTO escritorios (pais) VALUES ('Estados Unidos');
INSERT INTO escritorios (pais) VALUES ('Alemanha');
INSERT INTO escritorios (pais) VALUES ('França');

-- Inserção de dados na tabela funcionarios
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) VALUES ('Pedro', 'Souza', 1);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) VALUES ('Sandra', 'Rubin', 2);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) VALUES ('Mikail', 'Schumer', 3);
INSERT INTO funcionarios (nome, sobrenome, id_escritorio) VALUES ('Olivier', 'Glaçon', 4);

-- Inserção de dados na tabela pagamentos
INSERT INTO pagamentos (id_funcionario, salario, data) VALUES (1, '5347.55', '2019-03-17');
INSERT INTO pagamentos (id_funcionario, salario, data) VALUES (2, '9458.46', '2019-03-17');
INSERT INTO pagamentos (id_funcionario, salario, data) VALUES (3, '4669.67', '2019-03-17');
INSERT INTO pagamentos (id_funcionario, salario, data) VALUES (4, '2770.32', '2019-03-17');

-- Subconsultas (Exemplos)

-- Exemplo 1: Selecionar funcionários que trabalham no Brasil (com subconsulta)
SELECT nome, sobrenome FROM funcionarios WHERE id_escritorio IN (SELECT id FROM escritorios WHERE pais = 'Brasil');

-- Exemplo 1 (Sem subconsulta - Usando JOIN para comparação)
SELECT nome, sobrenome FROM funcionarios, escritorios AS e WHERE id_escritorio = e.id AND e.pais = 'Brasil';

-- Exemplo 2: Funcionário com o maior salário (com subconsulta)
SELECT
    f.nome,
    f.sobrenome,
    e.pais,
    p.salario
FROM
    pagamentos AS p,
    funcionarios AS f,
    escritorios AS e
WHERE
    f.id_escritorio = e.id
    AND f.id = p.id_funcionario
    AND salario = (SELECT MAX(salario) FROM pagamentos);

-- Exemplo 3: Funcionários com salário abaixo da média (com subconsulta)
SELECT
    f.nome,
    f.sobrenome,
    e.pais,
    p.salario
FROM
    pagamentos AS p,
    funcionarios AS f,
    escritorios AS e
WHERE
    f.id_escritorio = e.id
    AND f.id = p.id_funcionario
    AND salario < (SELECT AVG(salario) FROM pagamentos);

-- Funções de Data e Hora

-- CURDATE(): Retorna a data atual
SELECT CURDATE() AS 'Data Atual';

-- CURTIME(): Retorna a hora atual
SELECT CURTIME() AS 'Hora Atual';

-- CURRENT_TIME(): Retorna a hora atual (sinônimo de CURTIME())
SELECT CURRENT_TIME() AS 'Hora Atual';

-- DATE_ADD(data, INTERVAL valor unidade): Adiciona um intervalo à data
SELECT DATE_ADD(CURDATE(), INTERVAL 3 DAY) AS 'Data de Vencimento';

-- DATE_SUB(data, INTERVAL valor unidade): Subtrai um intervalo da data
SELECT DATE_SUB(CURDATE(), INTERVAL 10 DAY) AS 'Data de Matrícula';

-- DATEDIFF(data1, data2): Retorna a diferença em dias entre duas datas
SELECT DATEDIFF(CURDATE(), DATE_SUB(CURDATE(), INTERVAL 10 DAY)) AS 'Dias em Atraso';

-- DATE_FORMAT(data, formato): Formata uma data
SELECT DATE_FORMAT(CURDATE(), '%d/%m/%Y') AS 'Data Atual Formatada';

-- DAYNAME(data): Retorna o nome do dia da semana (em inglês, se não configurado)
SELECT DAYNAME(CURDATE()) AS 'Dia da Semana';

-- DAYOFMONTH(data): Retorna o dia do mês
SELECT DAYOFMONTH(CURDATE()) AS 'Dia do Mês';

-- DAYOFWEEK(data): Retorna o dia da semana como número (1=Domingo, 2=Segunda...)
SELECT DAYOFWEEK(CURDATE()) AS 'Dia da Semana (Número)';

-- DAYOFYEAR(data): Retorna o dia do ano
SELECT DAYOFYEAR(CURDATE()) AS 'Dia do Ano';

-- FROM_DAYS(número_de_dias): Converte um número de dias para data
SELECT FROM_DAYS(780500) AS 'Data a Partir de Dias';

-- NOW(): Retorna a data e hora atuais
SELECT NOW() AS 'Data/Hora Atual';
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i:%s') AS 'Data/Hora Atual Formatada';
SELECT DATE_FORMAT(CURRENT_TIMESTAMP(), '%d/%m/%Y %H:%i:%s') AS 'Data/Hora Atual Formatada';

-- TIME(datetime): Extrai a parte da hora de um DATETIME
SELECT TIME(CURRENT_TIMESTAMP()) AS 'Hora';

-- SEC_TO_TIME(segundos): Converte segundos para formato de tempo (HH:MM:SS)
SELECT SEC_TO_TIME(2000) AS 'Tempo Total (HH:MM:SS)';

-- TIME_TO_SEC(time): Converte tempo para segundos
SELECT TIME_TO_SEC(TIME(CURRENT_TIMESTAMP())) AS 'Hora em Segundos';

-- HOUR(time), MINUTE(time), SECOND(time): Extrai partes do tempo
SELECT
    HOUR(TIME(CURRENT_TIMESTAMP())) AS Hora,
    MINUTE(TIME(CURRENT_TIMESTAMP())) AS Minutos,
    SECOND(TIME(CURRENT_TIMESTAMP())) AS Segundos;

-- PERIOD_DIFF(P1, P2): Retorna a diferença em meses entre períodos no formato YYYYMM ou YYMM
SELECT PERIOD_DIFF(201912, 201905) AS 'Meses Restantes (Exemplo)';

-- TIMEDIFF(expr1, expr2): Retorna a diferença entre duas expressões de tempo/data_hora
SELECT TIMEDIFF('12:35:34', '12:30:46') AS Diferença;

-- QUARTER(data): Retorna o trimestre do ano (1-4)
SELECT QUARTER('2019-03-17') AS 'Trimestre do Ano';

-- WEEK(data): Retorna o número da semana do ano
SELECT WEEK('2019-03-17') AS 'Semana do Ano';

-- WEEKDAY(data): Retorna o dia da semana como número (0=Segunda, 1=Terça...)
SELECT WEEKDAY('2019-03-17') AS 'Dia da Semana (MySQL - 0=Seg)';

-- YEAR(data): Retorna o ano
SELECT YEAR('2019-03-17') AS 'Ano';

-- MONTH(data): Retorna o mês
SELECT MONTH(NOW()) AS 'Mês';

-- DAY(data): Retorna o dia do mês
SELECT DAY('2019-03-17') AS 'Dia';