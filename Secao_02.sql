
-- estamos mostrando somente o Cod_aluno, nome e a cidade
SELECT COD_ALUNO, NOME, CIDADE
FROM TALUNO;


-- Aqui vamos fazer os nomes passado por AS ficar do jeito que nomei
-- COD_ALUNO AS "Vai ficar do jeito que eu escrever"
SELECT COD_ALUNO AS "Código", NOME AS "Nome do Aluno"
FROM TALUNO;



-- Listar todas cidades de TALUNO
SELECT CIDADE FROM TALUNO;

-- POdemos ver que Canoas tem duas vezes, mas nao queremos, entao usando o DISTINCT
--Distinct retira linhas duplicadas
SELECT DISTINCT CIDADE FROM TALUNO;


-- Nao vai fazer diferenca já que o COD_ALuno nao é igual.
-- Nao tem registro duplo. SOmente se chamasse a cidade sozinho.
--Puxamos Cidade e COD_ALUNO da tabela TALUNO
SELECT DISTINCT CIDADE, COD_ALUNO
FROM TALUNO
ORDER BY CIDADE;   -- vai ordernar por cidade.


---
SELECT NOME AS CURSO,
       VALOR,
       VALOR/CARGA_HORARIA,    -- Calculo, valor divido por carga_horaria.
       Round(VALOR/CARGA_HORARIA,2) AS VALOR_HORA      -- Round, passando o 2 é (2) casas decimais.
FROM TCURSO
ORDER BY VALOR_HORA;   -- Ordernar por valor_hora
--Apelido de coluna só funciona em ORDER BY


SELECT * FROM TCONTRATO;


UPDATE TCONTRATO SET       -- vamos alterar o Tcontrato, passar um desconto novo e ele vai receber NULL,
DESCONTO = NULL
WHERE COD_CONTRATO = 4;        --  o CODigo do COntrato que é 4.


--calculo com coluna = NULL
--resultado = NULL
SELECT COD_CONTRATO,
       TOTAL,
       DESCONTO,
       TOTAL+DESCONTO
FROM TCONTRATO;


-- Nvl trata de colunas NULL
SELECT COD_CONTRATO,
       DESCONTO,
       Nvl(DESCONTO,0) AS DESCONTO,    -- se a coluna for null, ele vai retonar 0. RENOMEI o NVL para DESCONTO.
       TOTAL,
       TOTAL + Nvl(DESCONTO,0) AS TOTAL_MAIS_DESCONTO
FROM TCONTRATO;


-- EXEMPLO DE CONCATENACAO DE CULUNAS
-- Entao COD_ALUNO vai juntar com -, mais o NOME //, mais CIDADE
SELECT COD_ALUNO || ' - ' || NOME || ' // ' || CIDADE AS ALUNO  -- Cidade AS ALUNO, ele renomeou para aparecer como ALUNO
FROM TALUNO
ORDER BY COD_ALUNO;         -- Ordernando por aluno




   INTEGER      - 1, 2 -- numero inteiro -> number(38)

   NUMBER(5,2)  - 999,99        -- 5 digitos, 2 casas decimais.
   NUMERIC(5,2) - 999,99

   DATE         - '10/03/2011 00:00:00'      -- Date tem horario.

   VARCHAR(10)  -- Sinonimo
   VARCHAR2(10) - 'MARCIO'          -- Criando com VARCHAR passando(10) seria 10 caracteres, ele ocuparia somente até o 10, mas nao pegaria tudo

   CHAR(10)     - 'MARCIO    '         -- Diferente desse que vai ocupar realmente os 10 com o espaco.
                                       -- é bom usar Char quando uma informacao for vim usada completamente os 10 caracteres por exemplo.






