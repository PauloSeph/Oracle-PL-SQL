
               -- CAPITULO 7 Sub-consultas.

  --
  SELECT COD_CONTRATO, DATA, TOTAL    -- consulta principal
  FROM TCONTRATO        -- vamos consultar a table consulta, pegando COD_contrato, data e o total
  WHERE TOTAL >=         --   Onde total Maior ou igual a sub consulta, que seria o que está entre parenteses ( NO caso do codigo 3, que é 1500 )
   ( SELECT VALOR FROM TCURSO
     WHERE COD_CURSO = 3 );           --<< SUB  - Vai trazer todos que forem maior que 1500 ou igual


  -- Errado (Só pode retornar 1
  -- linha na subconsulta)
  SELECT COD_CONTRATO, DATA, TOTAL
  FROM TCONTRATO
  WHERE TOTAL >=
    ( SELECT VALOR FROM TCURSO       -- Sub select so pode retornar um registro, nao de todos que estao a cima.
      WHERE VALOR > 500 );



  SELECT * from TALUNO

  --Todos os Alunos da mesma cidade do Aluno 1,        -- EXEMPLO CERTO.
  --Menos o Aluno 1

  SELECT COD_ALUNO, NOME, CIDADE             -- vai trazer os 3
  FROM TALUNO
  WHERE CIDADE = ( SELECT CIDADE FROM TALUNO    -- filtrando, cidade tem que se ser gual ao select: cidade onde aluno cod 1 está, no caso NOVO HAMBURGO
                   WHERE COD_ALUNO = 1 )        -- entao vai trazer todos que sao de novo hamburgo
  AND COD_ALUNO <> 1;               -- mais essa regra, vai trazer todos os alunos da cidade, menos o 1, o aluno 1.

  --Todos os alunos da mesma cidade e estado do aluno 1 menos o aluno 1

  -- EXemplo de duas colunas.
  SELECT COD_ALUNO, NOME, CIDADE, ESTADO      -- chamando os 4 aqui
  FROM TALUNO
  WHERE (CIDADE,ESTADO) =                      --   Resultado nao vai vim nada, já que ele comparou e nao tinha dois iguais de cada.
            ( SELECT CIDADE,ESTADO FROM TALUNO   -- por exemplo Cidade (novo Hamburgo) Estado (AC), teria que ter um igual para vim alguma coisa.
              WHERE COD_ALUNO = 1 )
  AND COD_ALUNO <> 1 ;

  SELECT * FROM TALUNO
  SELECT * FROM TCURSO
  SELECT * FROM titem






  --Soma todos os itens, e mostra somente cujo o  valor minimo seja maior que o valor medio dos cursos
  SELECT COD_CURSO, Min(VALOR),Sum(VALOR),  -- Vai pegar valor min, valor somado, quantidade
         Count(*) QTDE      -- QTDE é o nome que vai aparecer.
  FROM TITEM                  -- do T item.
  WHERE cod_curso > 0   -- COD Do curso tem que ser maior que 0 -- nao tem efeito algum.
  GROUP BY COD_CURSO
  HAVING Min(VALOR) >=   -- podemos so usar o Min, para comparar o min no having nao no where Já que min é uma funcao de grupo.
        (SELECT Avg(VALOR) FROM TCURSO)        -- Pegando o valor min, tem que ser maior ou igual a (media(AVG) do valor do curso
  ORDER BY Cod_Curso;



  -- CONTINUANDO.....

  --Soma o total de contrato por aluno e mostra  somente cujo o menor contrato seja maior que  o valor medio de curso

  SELECT COD_ALUNO, Min(TOTAL), Sum(TOTAL)    -- min total, e a soma total.
  FROM TCONTRATO
  GROUP BY COD_ALUNO
  HAVING Min(TOTAL) >
     (SELECT Avg(VALOR) FROM TCURSO);       -- MINIMO do total do contrato maior, do que o AVG(media) do valor do tcurso


  --Todos os cursos que estao na tabela de Item (Vendidos)
  SELECT COD_CURSO, NOME, VALOR
  FROM TCURSO             -- TCURSO é uma tabela de precos, dos produtos.
  WHERE COD_CURSO IN (SELECT COD_CURSO FROM TITEM)        -- Lembrando que o sub select so pode trazer 1 registro, depende do operador, se usado o > ele vai buscar somente 1.
                                                           -- ai ele retonar somente 1, no caso com IN ele retorna mais que 1.
                                                            -- ONDe o COD Curso está em Titem.
  --Todos os Cursos que nao Estao na Tabela de Item
  --(Nao Vendidos)
  SELECT COD_CURSO, NOME, VALOR                        -- da mesma forma que a cima, so que usando o NOT IN
  FROM TCURSO
  WHERE COD_CURSO NOT IN (SELECT COD_CURSO FROM TITEM)    -- vai trazer os cursos que nao estao na tabela item.
  ORDER BY NOME


  -----Codigo equivalente a subselect
  --( se os valores sao conhecidos )
  SELECT cod_curso, nome, valor
  FROM tcurso WHERE cod_curso IN (1,2,3,4) ;


  ---   Se sabemos qual é os codigos do que fizemos a cima nos SUBSELECT. no caso usando o IN
  SELECT Cod_curso, nome, valor
  FROM Tcurso
  WHERE Cod_curso = 1
  OR Cod_curso = 2
  OR Cod_curso = 3
  OR Cod_curso = 4;


  -- Todos cursos que foram vendidos
  -- pelo valor padrao
  SELECT * FROM TITEM
  WHERE (COD_CURSO, VALOR) IN                     -- Vai comparar COD_CURSO com o valor de Titem e TCurso, Tcurso onde estao os valores originais, e Titem de venda.
        (SELECT COD_CURSO, VALOR FROM TCURSO)


  --SubConsulta na clausula From  -- select de duas tabelas
  SELECT ITE.COD_CONTRATO, ITE.VALOR, ITE.COD_CURSO,
         CUR.COD_CURSO codigo, CUR.VALOR
  FROM TITEM ITE,      -- primeira   TITEM, ITE
       ( SELECT COD_CURSO, VALOR
         FROM TCURSO WHERE VALOR > 500 ) CUR     -- Segunda, subconsulta TCURSO, CUR

  WHERE CUR.COD_CURSO = ITE.COD_CURSO         -- criterio de uniao entre elas.











