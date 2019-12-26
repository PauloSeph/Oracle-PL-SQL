--
CREATE OR REPLACE FUNCTION CONSULTA_PRECO
(pCod_Curso NUMBER) RETURN NUMBER
AS
  vValor NUMBER;
BEGIN
  SELECT valor INTO vValor FROM TCurso
  WHERE cod_curso = pCod_Curso;

  RETURN(vValor);
END;
/
--Teste | Usando function
DECLARE
  vCod NUMBER := &codigo;
  vValor NUMBER;
BEGIN
  vValor := consulta_preco(vCod);
  Dbms_Output.Put_Line('Preco do curso: '||vValor);
  
  
  
  ------------
  
CREATE OR REPLACE FUNCTION existe_aluno2
( pCod_Aluno IN tAluno.cod_aluno%TYPE)
RETURN BOOLEAN
IS
    vAluno NUMBER(10);
BEGIN
    SELECT cod_Aluno
    INTO vAluno
    FROM taluno
    WHERE cod_aluno = pCod_aluno;
  return (true);
EXCEPTION
 WHEN others THEN
  RETURN ( false ); 
END;
  
  
  
DECLARE
  vCodigo INTEGER := 1;
BEGIN
  if existe_aluno2(vCodigo) then
  Dbms_output.put_line('Codigo encontrado');
  else
   Dbms_output.put_line ('Codigo nao encontrado');
   end if;
end;


   
CREATE OR REPLACE PROCEDURE cadastra_aluno
(pCod_Aluno IN taluno.cod_aluno%type,
 pNome IN taluno.nome%type,
 pCidade In taluno.cidade%type,
 pEstado in Taluno.estado%type)
IS
BEGIN
    IF ( NOT existe_aluno2(pCod_aluno) ) THEN
    INSERT INTO TALUNO(cod_aluno, nome, cidade, estado)
    Values (pCod_aluno, pnome, pCidade, pEstado);
    dbms_output.put_line('Aluno Cadastro com sucesso');
    ELSE dbms_output.put_line('codigo j� existe');
    END IF;
END;

 
DECLARE -- nao � necessario colocar DECLARE, 
--         j� que nao h� nenhuma variavel nele.
BEGIN
    cadastra_aluno(25, 'PAULO', 'CUIABA', 'MT');
    
END; 
  
  
Select * from taluno
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
END;


--Conectado como System
GRANT CREATE ANY TYPE TO MARCIO;

--Registro - Array
DROP TYPE TABLE_REG_ALUNO;

CREATE OR REPLACE TYPE REG_ALUNO AS OBJECT
( CODIGO INTEGER,
  NOME VARCHAR2(30),
  CIDADE VARCHAR(30)  );


--Matriz
CREATE OR REPLACE TYPE TABLE_REG_ALUNO AS TABLE OF REG_ALUNO;


-- Array
  [0][1][2][3][4]

-- Matriz
   [0][1][2][3][4]
   [1][1][2][3][4]
   [2][][][][]
   
--Function que retorna registros
CREATE OR REPLACE FUNCTION GET_ALUNO(pCODIGO NUMBER)
RETURN TABLE_REG_ALUNO PIPELINED
IS
 outLista REG_ALUNO;
 CURSOR CSQL IS
   SELECT ALU.COD_ALUNO, ALU.NOME, ALU.CIDADE
   FROM TALUNO ALU
   WHERE ALU.COD_ALUNO = pCODIGO;
 REG CSQL%ROWTYPE;
BEGIN
  OPEN CSQL;
  FETCH CSQL INTO REG;
  outLista := REG_ALUNO(REG.COD_ALUNO, REG.NOME, REG.CIDADE);
  PIPE ROW(outLista); --Escreve a linha
  CLOSE CSQL;
  RETURN;
END;
--usando
SELECT * FROM TABLE(GET_ALUNO(1));


--Usando
SELECT ALU.*, CON.total
FROM TABLE(GET_ALUNO(1)) ALU, TCONTRATO CON
WHERE CON.COD_ALUNO = ALU.CODIGO


CREATE OR REPLACE FUNCTION GET_ALUNOS
RETURN TABLE_REG_ALUNO PIPELINED
IS
 outLista REG_ALUNO;
 CURSOR CSQL IS
   SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO;
 REG CSQL%ROWTYPE;
BEGIN
 FOR REG IN CSQL
 LOOP   ----------.......
   outLista := REG_ALUNO(REG.COD_ALUNO,REG.NOME,REG.CIDADE);
   PIPE ROW(outLista);
 END LOOP; ------........
 RETURN;
END;

--Usando
SELECT * FROM TABLE(GET_ALUNOS);



1) Criar uma FUNCTION que retorne o valor total de contrato
   por aluno (receber como parametro o codigo do aluno)
   Cod_Aluno, NomeAluno, TotalContrato
   (Retorna somente 1 linha)
   usando cursor

   SELECT ALU.COD_ALUNO, ALU.NOME, Sum(CON.TOTAL) TOTAL
   FROM TCONTRATO CON, TALUNO ALU
   WHERE CON.COD_ALUNO = ALU.COD_ALUNO
   AND ALU.COD_ALUNO = pCodigo
   GROUP BY ALU.COD_ALUNO, ALU.NOME;



2) Criar uma FUNCTION que retorne
   NomeAluno, DataContrato,  TotalContrato
   ( Usar FOR LOOP )






CREATE OR REPLACE TYPE REG_TOTALALUNO AS OBJECT
( COD_ALUNO INTEGER,
  NOME VARCHAR2(30),
  TOTAL NUMERIC(8,2)  );

--Matriz
CREATE OR REPLACE TYPE TABLE_REG_TOTALALUNO AS
  TABLE OF REG_TOTALALUNO;

--Function que retorna registros
CREATE OR REPLACE FUNCTION GET_TOTALALUNO(PCODIGO NUMBER)
RETURN TABLE_REG_TOTALALUNO PIPELINED
IS
 outLista REG_TOTALALUNO;
 CURSOR CSQL IS
   SELECT ALU.COD_ALUNO, ALU.NOME, Sum(CON.TOTAL) TOTAL
   FROM TCONTRATO CON, TALUNO ALU
   WHERE CON.COD_ALUNO = ALU.COD_ALUNO AND ALU.COD_ALUNO=PCODIGO
   GROUP BY ALU.COD_ALUNO, ALU.NOME;
 REG CSQL%ROWTYPE;
BEGIN
  OPEN CSQL;
  FETCH CSQL INTO REG;
  outLista:=REG_TOTALALUNO(REG.COD_ALUNO, REG.NOME, REG.TOTAL);
  PIPE ROW(outLista);
  CLOSE CSQL;
  RETURN;
END;

SELECT * FROM TABLE(GET_TOTALALUNO(1));

2) Criar uma FUNCTION que retorne
 Cod_Contrato, Data, NomeAluno, Total
 ( Usar FOR LOOP )

DROP TYPE TABLE_REG_LISTAALUNO;
CREATE OR REPLACE TYPE REG_LISTAALUNO AS OBJECT
( DATA DATE,  NOME VARCHAR(20), TOTAL NUMERIC(8,2) );

--Matriz
CREATE OR REPLACE TYPE TABLE_REG_LISTAALUNO AS
  TABLE OF REG_LISTAALUNO;

CREATE OR REPLACE FUNCTION GET_LISTAALUNO
RETURN TABLE_REG_LISTAALUNO PIPELINED
IS
 outLista REG_LISTAALUNO;
 CURSOR CSQL IS
   SELECT Trunc(CON.DATA) DATA, ALU.NOME, Sum(CON.TOTAL) TOTAL
   FROM TALUNO ALU, TCONTRATO CON
   WHERE CON.COD_ALUNO = ALU.COD_ALUNO
   GROUP BY Trunc(CON.DATA), ALU.NOME;
 REG CSQL%ROWTYPE;
BEGIN
  FOR REG IN CSQL
  LOOP      ----------.......
    outLista := REG_LISTAALUNO(REG.DATA,REG.NOME, REG.TOTAL);
    PIPE ROW(outLista);
  END LOOP; ------........
  RETURN;
END;

SELECT * FROM TABLE(GET_LISTAALUNO);




