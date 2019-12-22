

-- CAP 6 Funcoes de grupo

-- round avg,

SELECT Count(*)   AS QTDE_REGISTROS,      -- count -> contar quantidade de registro  da tabela.
       Avg(TOTAL) AS MEDIA,              -- avg --> Vai fazer a media do (Coluna TOTAL Do TCONTRATO) da tabela inteira.
       Round(Avg(TOTAL),2) AS MEDIA,    -- Aqui mesma colisa, porém passando 2, é duas casas decimais.
       Max(TOTAL) AS MAXIMO,             -- max, valor mais alto da coluna TOTAL
       Min(TOTAL) AS MINIMO,              -- min, valor mais baixo da coluna total
       Sum(TOTAL) AS SOMA,                 -- Sum, soma toda coluna.
       Max(DATA)  AS DATA_MAIOR,           -- max em DAta, vai trazer a data maior da tabela
       Min(DATA)  AS DATA_MENOR             -- min em Data, vai trazer menor data da tabela
FROM TCONTRATO;

--Proximo código sequencial tabela
SELECT Max(COD_CONTRATO) + 1 AS PROXIMO_CODIGO  -- max, entao o codigo mais alto da coluna de contrato.  Colocando +1, vai saber qual o proximo codigo será inserido.
FROM TCONTRATO;

--
SELECT * FROM TALUNO;
SELECT * FROM TCONTRATO;

--TOTAL DE CONTRATOS POR ALUNO
SELECT COD_ALUNO,            -- ja que nao passei nenhuma funcao de grupo por exemplo sum COD_ALUNO, entao obrigatoriamente no fintal tem que passar GROUP by COD
       COUNT(*) AS QTDE_CONTRATO,  -- Trazendo a quantidade do COD_ALUNO, por exemplo aluno 5 tem 3 contrato, entao vai somar os 3 aparecendo tudo junto.
       Sum(TOTAL) AS VALOR_TOTAL   -- Vai somar o total <<<<<
FROM TCONTRATO
GROUP BY COD_ALUNO


-- Vamos agrupar por data

SELECT To_Char(Trunc(SYSDATE),'DD/MM/YYYY') AS DATA FROM DUAL


--TOTAL DE CONTRATO POR DATA
-- trunc ele vai tirar a hora, para ele agrupar a data. POis com a hora ele nao organiza certo
-- to_char é para colocar a data no formato DD/MM/YYYY.
SELECT To_Char(Trunc(DATA),'DD/MM/YYYY') AS DATA,         -- Nao foi usado funcao de grupo entao... Groupy by
       Sum(TOTAL) AS SOMA, -- Vamos somar o total
       Avg(TOTAL) AS MEDIA,  --avg a media do total
       Count(*)   AS QTDE    -- quantidade dos contratos
FROM TCONTRATO
GROUP BY Trunc(DATA)    -- tem que passar o trunc(DATA) para ele nao considerar a hora.
ORDER BY DATA DESC          -- ordenando por data

-------------------------- Aula 3 group
-- vamos fazer dois updates
UPDATE TCONTRATO SET
  DESCONTO = NULL
WHERE COD_CONTRATO = 4;

UPDATE TCONTRATO SET
  DESCONTO = NULL
WHERE COD_CONTRATO = 3;

SELECT Count(*) AS QTDE_REGISTROS -- mais um vez vendo a quantidade de registro do contrato
FROM TCONTRATO;

SELECT * FROM TCONTRATO

--COUNT -> IGNORA NULOS
SELECT Count(DESCONTO)   -- Aqui vamos ver do Desconto, ele vai olhar para o DESCONTO, vai ignorar os 2 NULLS. Ele desconsidera os registros nulos
FROM TCONTRATO;

SELECT * FROM TALUNO

UPDATE TALUNO SET
ESTADO = 'MG'
WHERE COD_ALUNO = 7;

--Qtde de registros com estado informado
SELECT  Count(ESTADO)  FROM   TALUNO;      -- Quantidade de estados  = 7

--QTDE DE estados diferentes
SELECT Count(DISTINCT(ESTADO)) FROM TALUNO;     -- Vai mostra quantidades de estados diferentes no ESTADO.  DISTINCT nao vai considerar os registros repetidos.
                                                 -- vai dar 5, ja que SP ta repetindo e RS Também.

-- QUANT DE REGISTROS POR estado  -- mostrando a quantidade de registro por estado.
SELECT ESTADO, Count(*)
FROM TALUNO
GROUP BY Estado;

--  Vamos pegar da tabela toda.
SELECT Sum(DESCONTO), --   Somar
       Avg(DESCONTO),   -- Media de desconto
       Count(DESCONTO), -- Quantidade de registro do desconto.
       Round(Avg( Nvl(DESCONTO,0) ), 2) -- varias funcoes combinadas - NVL null vai considerar 0, Avg - fazer uma media do resultado,  round vai arredondar em 2 casas decimais
FROM TCONTRATO;                          -- primeiro vai somar  o desconto, pegar media e dividir pelos 5, no round vai fazer mesma coisa so que com os 7 registro, passando a media.
                                         -- ja que NULL ele nao vai calcular o count.

SELECT * FROM TCONTRATO

--TOTAL DE CONTRATO POR ESTADO E DATA
SELECT ALU.Estado, Trunc(CON.DATA) AS DATA,  -- Aqui vamos pegar Estado na tabela ALUNO, trunc para nao considerar a hora, passando do contrato(data)
       SUM(CON.Total) TOTAL, Count(*) qtde    -- somando total do contrato, e saber quantos registro tem  (count)

FROM   TALUNO ALU, TCONTRATO CON     -- passando apelidos para eles..
WHERE  ALU.COD_ALUNO = CON.COD_ALUNO    -- Do cod Aluno de ambos.
GROUP  BY  ALU.Estado, Trunc(CON.DATA)      -- GROUP by.. estado e trunc data, já nao que foi passado nenhuma funcao de grupo.
ORDER  BY  ALU.ESTADO, DATA DESC;           -- ordernado..

--TOTAL DE CONTRATO POR ESTADO        -- vamos tirar a data.
SELECT ALU.Estado,
       SUM(CON.Total) TOTAL, Count(*) qtde

FROM   TALUNO ALU, TCONTRATO CON
WHERE  ALU.COD_ALUNO = CON.COD_ALUNO
GROUP  BY  ALU.Estado
ORDER  BY  ALU.ESTADO


-- Having - filtrar coluna com funcao de grupo

SELECT COD_ALUNO,Round(AVG(TOTAL),2) MEDIA   -- FIZ UM ROUND para ele pegar duas casas decimais
FROM TCONTRATO
WHERE COD_ALUNO > 0        -- nao tera efeito nenhum. É so para ver onde ele fica.
HAVING AVG(Total) > 500     -- POis AVG nao pode colocar no where, por isso colocamos HAVING.
GROUP BY COD_ALUNO           -- Funciona como where, ele filtra.
ORDER BY COD_ALUNO

--   OUTRA FORMA DE usar o HAving
SELECT Trunc(DATA), SUM(TOTAL) TOTAL    -- trunc na data, para tirar a hora, sum para somar o total.
FROM   TCONTRATO
WHERE  COD_CONTRATO > 0
GROUP  BY Trunc(DATA)       --
HAVING SUM(TOTAL) > 500     -- soma total maior que 500,  aqui é uma condical.
ORDER  BY TOTAL desc;  -- acho que o DESC é de decrecente.        Maior para o menor.

---Media mais alta por aluno
SELECT Max(AVG(TOTAL))     -- maior media por aluno, de um aluno.
FROM TCONTRATO
GROUP BY COD_ALUNO;

--Soma dos salarios por estado
SELECT ESTADO, Sum(SALARIO) AS TOTAL
FROM TALUNO
GROUP BY ESTADO
ORDER BY TOTAL DESC

