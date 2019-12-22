 --
SELECT * FROM TALUNO;

-- Ela junta duas colunas ou dois valores
SELECT Concat(COD_ALUNO,NOME) FROM TALUNO;

-- Dessa maneira também serve para concatenar
SELECT COD_ALUNO||' - '||NOME FROM TALUNO;

--  Transforma  a primeira letra do nome em Maiscula e o resto minusculo.    Bom para formatar
SELECT nome, InitCap(NOME) FROM TALUNO;

--   retorna, em que posica está o R em NOME. por exemplo Pedro, está no 4 caractere. Caso nao encontrado retorna 0
SELECT nome, InStr(NOME,'R') FROM TALUNO;

--   Tamanho do da coluna NOME, conta quantos caracteres tem. Valdo tem 5, pedro 5,etc
SELECT nome, Length(NOME) FROM TALUNO;

--   Transforma tudo em minusculo
SELECT nome, Lower(NOME) FROM TALUNO

--     Transforma tudo em maisculo
SELECT nome, Upper(NOME) FROM TALUNO;

-- Ta mostrando como fica tudo com initCap, no caso aqui vamos mostrar um para ver. Por isso colocamos o dual. Jose Da Silva (ele formata Primeira letra da palavra em Maisculo
SELECT InitCap('JOSE DA SILVA') FROM dual;     -- mostra no testo todo, nao em so uma palavra.

-- LPad - left, esquerda  .. Formatar na esquerda para direita. Onde passando 5, '0' no parametro, 5 é as casas 0 é o preenchimento que falta. ficando 11 = 00011
SELECT cod_aluno, LPad(COD_ALUNO,5,'0') FROM TALUNO;

-- Mais usado é o LEFT para numeros.

-- direita Right, Rpad. Mesmo exemplo de cima colocando os 0 para direita. No caso 8 no total, preenchidos por 0. Valor + os 0
SELECT nome, salario, RPad(SALARIO,8,'0') FROM TALUNO;


--  Fazendo o mesmo so que com NOME agora, colocando $ a direita.
SELECT nome, RPad(NOME,10,'$') FROM TALUNO;


-- copia parte de um texto
-- substr ( campo/texto, posicao inicial, qtde de caract )
-- Substring .. Vamos copiar do nome, a partir da coluna 1, 3 caracteres.
SELECT nome, SubStr(NOME,1,3) FROM TALUNO;

--  Copiando o primeiro caractere
SELECT SubStr(NOME,1,1) FROM TALUNO;

--   Aqui mesma coisa, a partir da 3 posicao, contando ela, ele pega 1 caractere. VALDO = L
SELECT nome, SubStr(NOME,3,1) FROM TALUNO;

--   Exemplo de upper, Aqui vamos subistutuir as letras R, por $ da caluna NOME, so para visualização, nao vai alterar. SOmente com update para alterar.
SELECT REPLACE(Upper(NOME),'R','$') FROM TALUNO;


  -- Aqui é para ver para o exemplo de baixo.
SELECT nome, SubStr(nome,5,1) FROM TALUNO;
-- Sabemos que lenght vai pegar quantidade de caracteres, entao passando length(nome), pegando caracterer 1, Vai contar quantos caracteres tem e subistituir e copiando a ultima letra.
SELECT SubStr(NOME,Length(nome),1) FROM TALUNO;

--  Vai copiar os dois ultimos, -1 da length, vai pegar 2 caractere.
SELECT nome, SubStr(NOME,Length(nome)-1, 2) FROM TALUNO;

--  Aqui é a partir da posicao 3, copiar os -3 caracteres seguintes, incluindo ele proprio.
SELECT nome, SubStr(NOME, 3, Length(nome)-3 ) FROM TALUNO;



--   Aqui vamos filtrar o nome, ele vai comparar NOME com minusculo. Ou seja, se tiver maisculo e pesquisar 'marcio' minusculo ele nao vai achar, so colocando o lower
SELECT * FROM TALUNO
WHERE Lower(NOME) = 'marcio';

-- Aqui é a mesma forma, se no caso NOME estiver minusculo e ele procurar por MARCIO maisculo ele nao vai achar, somente colocando UPPER.
SELECT * FROM TALUNO
WHERE Upper(NOME) = 'MARCIO';


-- Vamos fazer a mesma coisa mas incluindo o Substr, trabalhando com a COluna cidade, vamos trazer de cidades 3 primeiras letras começão com CAN.
-- a partir da primeira posicao, letra ele vai buscar o CAN(UPPER).   Ele vai filtrar a cidade que tem as 3 primeiras letras.
SELECT * FROM TALUNO
WHERE Upper(SubStr(CIDADE,1,3)) = 'CAN';

 -- alterando o valor salario do cOD_aluno 1. Para usarmos para proximo exemplo
UPDATE TALUNO SET
SALARIO = 633.47
WHERE COD_ALUNO = 1;

--  Selecionando salario, Replace(vamos trocar) Do salario, a virgula por vazio, ou . por vazio.
SELECT
  SALARIO,
  REPLACE(SALARIO, '.' , ''),
  RPad(SALARIO, 10,'0'),     --Zeros a direita até completar 10 casas
  LPad(SALARIO, 10,'0'),     --Zeros a esquerda até completar 10 casas
  LPad(REPLACE(SALARIO,'.',''),10,'0')    -- vamos subistuir . por vazio,  e preencher a esquerda com 0, até compeltar 10 casas.
FROM TALUNO;




------------------Data
SELECT * FROM DUAL;

--SysDate retorna data/hora do Servidor.
SELECT SYSDATE FROM DUAL;

-- Round e Trunc
SELECT Round(45.925, 2 ),  --45.93
       Trunc(45.929, 2 ),  --45.92
       Mod(10, 2) AS RESTO_DIVISAO,
       Trunc(1.99),
       Trunc(1.99, 2)
FROM DUAL;

SELECT * FROM TCONTRATO;

--Funcoes de Data/Hora
SELECT DATA, SYSDATE, DATA + 5 FROM TCONTRATO;

SELECT SYSDATE - DATA AS DIF_DIAS FROM TCONTRATO;

SELECT Trunc(SYSDATE - DATA) as DIAS FROM TCONTRATO;

--Somando horas em uma data
SELECT SYSDATE, SYSDATE + 5 / 24 as ADD_HORAS FROM TCONTRATO;

--Somar minutos
SELECT SYSDATE, SYSDATE + 15 / 1440 as ADD_MINUTOS FROM TCONTRATO;

SELECT SYSDATE, SYSDATE + 30 / (3600 * 24) as ADD_SEGUNDOS FROM TCONTRATO;


--Hora fica 00:00:00
SELECT SYSDATE, Trunc(SYSDATE) FROM DUAL;

--Diferenca de meses entre datas
SELECT Months_Between(SYSDATE, SYSDATE-90) AS DIF_MES FROM DUAL;

--Adiciona meses
SELECT Add_Months(SYSDATE, 5) AS ADICIONA_MES_DATA FROM DUAL;

--Proxima data a partir de uma dia da semana
SELECT Next_Day(SYSDATE, 'QUARTA-FEIRA') AS PROXIMA_QUARTA_DATA FROM DUAL;

--Ultimo dia do mes
SELECT Last_Day(SYSDATE) AS ULTIMO_DIA_MES FROM DUAL;

--Primeiro dia do proximo mes
--até dia 15 do mes pega o primeiro dia do mes atual
--a partir do dia 16 retorna o primeiro dia do proximo mes
SELECT Round(SYSDATE, 'MONTH') AS PRIMEIRO_DIA_PROXIMO_MES FROM DUAL;


--Primeiro dia do mes
SELECT Trunc(SYSDATE,'MONTH') AS PRIMEIRO_DIA_MES_CORRENTE FROM DUAL;


---Formatação de data

--Conversor to_char(data, formato)

--DD -> dia do mes
SELECT SYSDATE, To_Char(SYSDATE,'DD') FROM DUAL

--
SELECT To_Char(SYSDATE,'DD/MM/YYYY') DATA FROM DUAL;

SELECT To_Char(SYSDATE,'DD/MM') DIA_MES FROM DUAL;

SELECT To_Char(SYSDATE,'DD') DIA FROM DUAL;

SELECT To_Char(SYSDATE,'MM') MES FROM DUAL;

SELECT To_Char(SYSDATE,'YYYY') ANO FROM DUAL;

SELECT To_Char(SYSDATE,'YY') ANO FROM DUAL;

--
SELECT To_Char(SYSDATE,'MONTH') MES1 FROM DUAL;

--
SELECT To_Char(SYSDATE,'D') DIA_SEMANA FROM DUAL;

--
SELECT To_Char(SYSDATE,'DY') DIA_SEMANA FROM DUAL;   -- QUA

--
SELECT To_Char(SYSDATE,'DAY') DIA_SEMANA1 FROM DUAL; -- QUARTA

--
SELECT To_Char(SYSDATE,'YEAR') ANO FROM DUAL;        -- Em Ingles

--
SELECT To_Char(SYSDATE,'"NOVO HAMBURGO", fmDAY "," DD "de" fmMonth "de" YYYY') FROM DUAL;

--
SELECT To_Char(SYSDATE,'HH24:MI') HORA_MIN FROM DUAL;

--
SELECT To_Char(SYSDATE,'HH24:MI:SS') HORA_MIN_SEG FROM DUAL;

--
SELECT To_Char(SYSDATE,'DD/MM HH24:MI') DATA_HORA FROM DUAL;

--
SELECT To_Char(SYSDATE,'DD/MM/YYYY HH24:MI:SS') DATA_HORA FROM DUAL;




--L -> R$
--G -> ponto
--D -> casas decimais

SELECT * FROM TALUNO

SELECT Trim(To_Char(Salario,'L99999.99')) salario1, trim(To_Char(Salario,'L99G999D99')) salario2
FROM TALUNO;

--
SELECT 'R$ '||(Round(Salario,2)) AS salario FROM TALUNO;



-----
--NVL e NVL2
SELECT * FROM tcontrato;

SELECT Total,
       Desconto,
       Desconto+Total,
       Nvl(Desconto,0),
       Nvl(Desconto,0) + TOTAL,
       Nvl2(DESCONTO, TOTAL, 0)
FROM TContrato;

SELECT * FROM TALUNO

UPDATE TALUNO SET
NOME = NULL
WHERE COD_ALUNO = 5;

SELECT Cod_Aluno, Nvl(Nome, 'SEM NOME') FROM TALUNO

SELECT * FROM TALUNO;


UPDATE TAluno SET
Estado = 'SC'
WHERE Cod_Aluno=3;

UPDATE TAluno SET
Estado = 'RJ'
WHERE Cod_Aluno=5;

--Case
SELECT NOME, Estado,
       CASE
         WHEN Estado = 'RS' THEN 'GAUCHO'
         WHEN Estado = 'AC' THEN 'ACREANO'
         WHEN Estado = 'RJ' AND SALARIO > 500 THEN 'CARIOCA'
         ELSE 'OUTROS'
       END AS Apelido
FROM TALUNO;

--
SELECT SYSDATE AS DATA FROM DUAL

--
SELECT NOME, ESTADO,
       Decode(ESTADO,'RS','GAUCHO',
                     'AC','ACREANO',
                     'SP','PAULISTA',
                          'OUTROS' ) AS APELIDO
FROM TALUNO;



---------- Fim ----------