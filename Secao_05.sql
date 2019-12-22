
  SELECT * FROM TALUNO;

  SELECT * FROM TCONTRATO;

  -- Produto Cartesiano -> ERRADO
  SELECT TALUNO.COD_ALUNO, TALUNO.NOME, TCONTRATO.TOTAL
  FROM TALUNO , TCONTRATO

  -- Correto
  SELECT TALUNO.COD_ALUNO, TALUNO.NOME, TCONTRATO.TOTAL
  FROM TALUNO, TCONTRATO
  WHERE TALUNO.COD_ALUNO = TCONTRATO.COD_ALUNO        -- Criterio de uniao entre elas. Essa informacao que liga as duas tabelas.

  -- Aqui mudamos o Aluno para marcos no COD_ALUNO 5.
  UPDATE TALUNO SET
  NOME = 'MARCOS'
  WHERE COD_ALUNO = 5

  -- Errado - Coluna ambigua    -- Ele nao sabe que tabela ele vai puxar, por isso da ambiguidade. Ja que COD_ALUNO tem na tabela Taluno e Tcontrato. Da conflito.
  SELECT COD_ALUNO, TALUNO.NOME, TCONTRATO.TOTAL
  FROM TALUNO, TCONTRATO
  WHERE TALUNO.COD_ALUNO = TALUNO.COD_ALUNO
  --Correto, quando uma coluna existe com mesmo nome em mais de uma tabela,
  --colocar prefixo na coluna  por exemplo: TALUNO.COD_ALUNO




  --Uniao da tabela de aluno com contrato
  SELECT ALU.COD_ALUNO, ALU.NOME AS ALUNO,
         CON.COD_CONTRATO,CON.DATA, CON.TOTAL

  FROM TALUNO ALU, TCONTRATO CON      -- colocando apelido

  WHERE CON.COD_ALUNO = ALU.COD_ALUNO    --Criterio Uniao

  AND Upper(ALU.NOME) LIKE '%'           --Filtro

  ORDER BY ALU.NOME                      --Ordenar por nome





  ------------------------------------------

  SELECT * FROM TALUNO
  SELECT * FROM TCONTRATO
  SELECT * FROM TITEM
  SELECT * FROM TCURSO

  --
  SELECT ALU.COD_ALUNO, ALU.NOME AS ALUNO,       -- Chamando COD_ALUNO, NOME,(APELIDO ALUNO)
         CON.COD_CONTRATO, CON.DATA, CON.TOTAL,   -- Chamando CON < APELIDO, COD_Contrato, A Data e o total do contrato.
         ITE.COD_CURSO, CUR.NOME AS CURSO,         -- Chamando o item. COD_CURSO,< TEm no item, chamando nome do TCURSO, passando apelido
         ITE.VALOR                                  -- ITEM. VALOR, chamando o valor do item.

  FROM TALUNO ALU, TCONTRATO CON,
       TITEM ITE, TCURSO CUR
 -- o Item adicionado a baixo so vai funcionar, mostrar se tiver contrato e o resto, se nao ele nao irá aparecer no select
 -- entao usamos(+) para mostrar ele.

  WHERE ALU.COD_ALUNO = CON.COD_ALUNO(+)  --Criterio Uniao    -- ALUNO. Tem cod ALUNO e contrato também tem cod aluno.
  AND   CON.COD_CONTRATO = ITE.COD_CONTRATO(+)                -- ASSOCIANDO OS DOIS, já que cod contrato tem em contrato e item
  AND   ITE.COD_CURSO = CUR.COD_CURSO(+)                      -- ITEM Tem codCURSO e Curso també mtem CODCURSO

  ORDER BY CON.TOTAL DESC;   -- ordenando por contrato total.
  --

  INSERT INTO TALUNO VALUES (7, 'PEEDRO', 'NOVO HAMBURGO', NULL, NULL, NULL, SYSDATE)


----------------------------------------------------
-- Criar uma tabela.
  CREATE TABLE TDESCONTO
  ( CLASSE VARCHAR(1) PRIMARY KEY,      -- 3 colunas.
    INFERIOR NUMBER(4,2),
    SUPERIOR NUMBER(4,2)
   );

  INSERT INTO TDESCONTO VALUES('A',00,10);   -- CLASSE A, INFERIOR 0 Superior 10
  INSERT INTO TDESCONTO VALUES('B',11,15);
  INSERT INTO TDESCONTO VALUES('C',16,20);
  INSERT INTO TDESCONTO VALUES('D',21,25);
  INSERT INTO TDESCONTO VALUES('E',26,30);


  SELECT * FROM TDESCONTO;


  COMMIT;


  ---------

  SELECT * FROM TCONTRATO

  UPDATE TCONTRATO SET
  DESCONTO = 27
  WHERE COD_CONTRATO = 6;

    UPDATE TCONTRATO SET
  DESCONTO = 5
  WHERE COD_CONTRATO = 3;


  UPDATE TCONTRATO SET
  DESCONTO = 10
  WHERE COD_CONTRATO = 1;

    UPDATE TCONTRATO SET
  DESCONTO = 20
  WHERE COD_CONTRATO = 2;

       UPDATE TCONTRATO SET
  DESCONTO = 10
  WHERE COD_CONTRATO = 4;


  UPDATE TCONTRATO SET
  DESCONTO = 18
  WHERE COD_CONTRATO = 5;

    UPDATE TCONTRATO SET
  DESCONTO = 20
  WHERE COD_CONTRATO = 7;



  -------------  Relacionando a tabela TDesconto com o desconto, para mostra qual classe cada um está.   Relacionamento onde nao é igual, ou a chave nao é exata.
  SELECT	CON.COD_CONTRATO AS CONTRATO, CON.DESCONTO,     -- CHamando Desconto do contrato     CON
          DES.CLASSE AS DESCONTO                         -- Chamando DESCONTO do Tdesconto     DES

  FROM	  TCONTRATO CON, TDESCONTO DES
  WHERE CON.DESCONTO BETWEEN DES.INFERIOR AND DES.SUPERIOR    -- Onde, CON -> contrato, entre DEsconto inferior e superior.

  ORDER BY CON.COD_CONTRATO;    -- ordenar por contrato


  --Mostrar cursos vendidos
  SELECT CUR.COD_CURSO, CUR.NOME, ITE.VALOR
  FROM TCURSO CUR, TITEM ITE
  WHERE CUR.COD_CURSO = ITE.COD_CURSO


  --Mostrar cursos nao vendidos
  SELECT CUR.COD_CURSO, CUR.NOME, ITE.COD_ITEM
  FROM TCURSO CUR, TITEM ITE
  WHERE CUR.COD_CURSO = ITE.COD_CURSO(+)
  AND ITE.COD_ITEM IS NULL;          -- Aqui vai trazer os cursos que COD_ITEM é NULL, aqui estamos associando para saber se o item foi vendido. Null nao foi vendido
                                      -- COD_ITEM é a venda nesse momento, ele so vai aparecer se tiver em ITEM.

  SELECT * FROM TCURSO

  INSERT INTO TCURSO VALUES (6, 'PHP', 1000, 100, 2);
  INSERT INTO TCURSO VALUES (7,'LOGICA',100,20, 2)



  -- Add coluna na tabela, com pre_requisito de integer = inteiro.
  ALTER TABLE TCURSO ADD PRE_REQ INTEGER;


  SELECT * FROM TCURSO

  UPDATE TCURSO SET PRE_REQ = 7
      WHERE COD_CURSO = 1;

  UPDATE TCURSO SET PRE_REQ = 7
      WHERE COD_CURSO = 3;

  UPDATE TCURSO SET PRE_REQ = 1
      WHERE COD_CURSO = 2;

  UPDATE TCURSO SET PRE_REQ = 3
      WHERE COD_CURSO = 4;

  UPDATE TCURSO SET PRE_REQ = 7
      WHERE COD_CURSO = 6;

     UPDATE TCURSO SET PRE_REQ = 0
      WHERE COD_CURSO = 5;

        UPDATE TCURSO SET PRE_REQ = null
      WHERE COD_CURSO = 7;





  --Select de duas tabelas (a mesma tabela)      Duas colunas da mesma tabela.
  SELECT Curso.Nome AS Curso,
         Pre_Req.Nome AS Pre_Requisito

  FROM TCURSO CURSO, TCURSO PRE_REQ       -- TCurso APELIDO TCURSO APelido
  WHERE CURSO.PRE_REQ = PRE_REQ.COD_CURSO(+)


 --Fim