--
SELECT * FROM TALUNO;

-- ALTER TABLE TALUNO DROP COLUMN COLUNA;

-- Acrescentar uma coluna na tabela
ALTER TABLE TALUNO ADD ESTADO CHAR(2) DEFAULT 'RS';     -- DEFAULT é o valor que ele vai assumir como padrao. ACho que CHAR = character

ALTER TABLE TALUNO ADD SALARIO NUMBER(8,2) DEFAULT 620;

-- FAzendo uma update para nao deixar todos iguais
UPDATE TALUNO SET
ESTADO = 'AC' ,
SALARIO = 250
WHERE COD_ALUNO = 1;    -- CODIGO do aluno para ser modificado.

UPDATE TALUNO SET
ESTADO = 'MT',  SALARIO = 2000
WHERE COD_ALUNO = 2;

UPDATE TALUNO SET
ESTADO = 'SP', SALARIO = 800
WHERE COD_ALUNO = 5;

SELECT * FROM TALUNO;

COMMIT;

-- Filtro     Passamos duas condicoes, tem que ser feita as duas condicoes para aparecer no filtro.
SELECT * FROM TALUNO
WHERE ESTADO <> 'RS'       -- CHAMANDO ESTADO, diferente <> de RS
AND  SALARIO <= 800   -- E salario menor ou igual a 800 .
ORDER BY SALARIO DESC;      -- ORdernando por salario

-- inserimos novos valores a tabela. Passando COD_ALUNO, NOME, CIDADE. Vai assumir null no cep, e RS e 620 que foi o DEFAULT que escrevi a cima.
INSERT INTO TALUNO (COD_ALUNO, NOME,CIDADE)
VALUES (SEQ_ALUNO.NEXTVAL,'VALDO','DOIS IRMAOS');      -- passando os valores para nova coluna

INSERT INTO TALUNO (COD_ALUNO, NOME,CIDADE)
VALUES (SEQ_ALUNO.NEXTVAL,'ALDO','QUATRO IRMAOS');

SELECT * FROM TALUNO;

-- Fazendo um update para para o ALUNO 11, alterando 3 coulunas.
UPDATE TALUNO SET
ESTADO = 'SP',
SALARIO = 900,
NOME = 'PEDRO'
WHERE COD_ALUNO = 11;

-- fazendo um select na coluna estado, salario e nome
SELECT ESTADO, SALARIO, NOME FROM TALUNO
ORDER BY ESTADO, SALARIO DESC;     -- vamos ordernar por ESTADO, SALARIO, as segundas vao olhando para os primeiros grupos e ordernando.

-- 31/12/1899 - DATA Zero
-- 01/01/1900 - DATA 1
--  Vamos acrescentar mais colunas a tabela de ALUNO, com data. PEgando a data de hoje - 1000 dias
ALTER TABLE TALUNO ADD NASCIMENTO DATE DEFAULT SYSDATE - 1000;
--

-- Pegando a data do servidor, SYSDATE. Fazendo DAta de hoje Subtraindo(-) data de hoje.
SELECT SYSDATE - SYSDATE - 10 FROM DUAL;


--
SELECT * FROM TALUNO

-- aqui é um script do site que muda o formato. Do mes dia e ano
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
--
UPDATE TALUNO SET
NASCIMENTO = '10/10/2001'
WHERE COD_ALUNO=1;

--
UPDATE TALUNO SET
NASCIMENTO='10/08/2000'
WHERE COD_ALUNO=2;


--
SELECT * FROM TALUNO
--
-- Filtrar por data
SELECT COD_ALUNO, NASCIMENTO, Trunc(NASCIMENTO) AS nascimento, NOME           -- trunc arredonda numeros, se usado no DATA, ele tira a hora.
FROM TALUNO
WHERE Trunc(NASCIMENTO) = '20/01/2017';          -- quero trazer os alunos que nasceram nessa data, 20/01/2017, trunc vai ignorar a hora.

--  Buscando por hora e data.
SELECT COD_ALUNO, NASCIMENTO, Trunc(NASCIMENTO), NOME
FROM TALUNO
WHERE NASCIMENTO
 BETWEEN TO_DATE('25/08/2010 22:00','DD/MM/YYYY HH24:MI')  -- between -> entre to date, e to date.
  AND TO_DATE('25/08/2017 23:55','DD/MM/YYYY HH24:MI')


-- calculando com a formula where
SELECT COD_CONTRATO, DATA, TOTAL,                      -- Selecionando COD_contrato, data, total, desconto e desconto + 1000 que será o calculo
       DESCONTO, DESCONTO + 1000 AS CALCULO           -- vai pegar o desconto que está em percentual no caso 18 vai para 1018.
FROM TCONTRATO
WHERE TOTAL <= DESCONTO + 1000;                        -- fazendo uma condicao, onde total seja menor ou igual a desconto + 1000, se o total for 1500 nao vai, tem que ser a baixo ou igual

--
SELECT * FROM TCONTRATO;

--  alterando desconto do COD_contrato = 2
UPDATE TCONTRATO SET
DESCONTO = NULL
WHERE COD_CONTRATO = 2;

--     Aqui vamos filtrar somente quero os registro da tabela contrato  onde o DESCONTO é NULL  (NULO)
SELECT * FROM TCONTRATO
WHERE DESCONTO IS NULL;

--     Aqui fazendo ao contrario. Onde nao é null ele vai filtrar
SELECT * FROM TCONTRATO
WHERE DESCONTO IS NOT NULL;
--
--      Aqui vamos filtrar onde o desconto esteja entre 0 e 18
SELECT * FROM TCONTRATO
WHERE DESCONTO BETWEEN 0 AND 18;


--Nvl 0> Colunar com valor null       -- TRATA o NULL.
--BETWEEN -> Entre
SELECT COD_CONTRATO, TOTAL, DESCONTO, NVL(DESCONTO,0) -- Se o desconto for null ele vai receber 0
FROM TCONTRATO
WHERE NVL(DESCONTO,0) BETWEEN 0 AND 18;    -- podemos usar NVL no where, passando o parametro e condicoes.


--mesmo efeito do between
SELECT * FROM TCONTRATO
WHERE DESCONTO >= 0
AND DESCONTO <= 18
OR DESCONTO IS NULL;



--  IN  /// NOT IN            -- T item , foi a ultima tabela que criamos
SELECT * FROM TITEM            -- retorno 8 registros
WHERE COD_CURSO IN (1, 2, 4);    -- vamos pegar o COD_CUrso do 1, 2 e o 4.

SELECT * FROM TITEM
WHERE COD_CURSO NOT IN (1, 2, 4);       --ao contrario de cima, os COD_CURSO nao esteja entre 1, 2, 4

SELECT * FROM tcurso

--  vamos iserir o COD_CURSO, NOME, valor, carga_horaria. Passado por parametros ( )
INSERT INTO TCURSO VALUES (5, 'WINDOWS', 1000, 50 );   -- vamos acrescentar mais um curso

--CURSOS NAO VENDIDOS
SELECT * FROM TCURSO
WHERE COD_CURSO NOT IN (SELECT COD_CURSO FROM TITEM)


--CURSOS VENDIDOS
SELECT * FROM TCURSO
WHERE COD_CURSO IN (SELECT COD_CURSO FROM TITEM)


--equivalente ao SELECT IN
SELECT * FROM TITEM
WHERE COD_CURSO = 1
OR COD_CURSO    = 2
OR COD_CURSO    = 4;

-- Usando filtro.
--somente onde a segunda letra seja A
SELECT * FROM TCURSO WHERE NOME LIKE 'W%'     -- vai trazer os Registros que inicia com W
SELECT * FROM TCURSO WHERE NOME LIKE '%JAVA%'  -- de TCURSO no nome onde tenha o O JAVA, ele vai procurar no nome todo da frase. por exemplo Arroz JAVA, ele vai achar.
SELECT * FROM TCURSO WHERE NOME LIKE '%FACES'    -- onde termina com a palavra


SELECT * FROM TCURSO;

COMMIT;


 -- Adicionar mais uma coluna na tabela de curso, pre_req é para informar os requisitos, no caso é so para entrar numeros integer = inteiro.
ALTER TABLE TCURSO ADD PRE_REQ INTEGER;

-- entao o pre requisito para o curso 2 é o curso 1
UPDATE TCURSO SET
PRE_REQ = 1
WHERE COD_CURSO = 2;

-- pre requisito para o curso 4 é o 3
UPDATE TCURSO SET
PRE_REQ = 3
WHERE COD_CURSO = 4;

--Vai filtrar cursos sem pre requisito
SELECT * FROM TCURSO WHERE PRE_REQ IS NULL

-- Vai filtrar cursos com pre-requisitos
SELECT * FROM TCURSO WHERE PRE_REQ IS NOT NULL
--


--Precedencia de operadores
-- ()
-- AND
-- OR
SELECT * FROM tcurso                 -- ter cuidado na hora de usar and e or juntos, pois no filtro ele nao puxa os dois as vezes
WHERE valor > 750
OR valor < 1000                     -- erro bem comum  colocar em uma ordem invertida ou esquecer os paranteses
AND carga_horaria = 25                   -- aqui ele executa o and ou o or. que está errado.
--

SELECT * FROM tcurso                      -- por exemplo aqui temos parenteses, vai puxar primeiro o que está dentro () depois o and, fazendo a condicao.
WHERE (valor > 750                     -- valor maior que 750 ou menor que 1000 e carga horaria = 25
or valor < 1000)
and carga_horaria = 25;                       -- JEITO CORRETO.


-- Ordem de execução
-- 1 - Paranteses
-- 2 - AND
-- 3 - OR
