





SELECT COD_ALUNO, TRUNC(DATA),
       SUM(DESCONTO) DESCONTO,
       SUM(TOTAL) TOTAL
FROM   TCONTRATO
GROUP  BY ROLLUP( COD_ALUNO, TRUNC(DATA) );




--
SELECT COD_ALUNO,
       CASE
         WHEN TRUNC(DATA) IS NULL AND COD_ALUNO IS NOT NULL
             THEN 'SUB-TOTAL'
         WHEN COD_ALUNO IS NULL
             THEN 'TOTAL-GERAL'
         ELSE TO_CHAR( Trunc(DATA) )
       END DESCRICAO,
       Round(AVG(DESCONTO),2) DESCONTO,
       SUM(TOTAL) TOTAL
FROM   TCONTRATO
GROUP  BY ROLLUP(COD_ALUNO, TRUNC(DATA) );




--
SELECT COD_ALUNO, Trunc(DATA), SUM(TOTAL)
FROM TCONTRATO
GROUP BY CUBE(COD_ALUNO, Trunc(DATA));


--
SELECT * FROM TCONTRATO;

--------------------------- Identifica total geral

SELECT GROUPING(COD_ALUNO), Sum(TOTAL)
FROM TCONTRATO
GROUP BY ROLLUP(COD_ALUNO);


-------------------------
SELECT GROUPING(COD_ALUNO),
       CASE
         WHEN GROUPING(COD_ALUNO)=0 THEN TO_CHAR(COD_ALUNO)
         ELSE 'Total Geral :'
       END ALUNO,
       Sum(TOTAL)
FROM TCONTRATO
GROUP BY ROLLUP(COD_ALUNO);

--------------------------------------





--------------------------------------
SELECT Trunc(DATA),
       GROUPING_ID(Trunc(DATA)) GDT,
       COD_ALUNO,
       GROUPING_ID(COD_ALUNO) GCL,
       SUM(TOTAL)
FROM TCONTRATO
GROUP BY ROLLUP( Trunc(DATA), COD_ALUNO);

-----------------*********
SELECT Trunc(DATA),COD_ALUNO,
    CASE
     WHEN GROUPING_ID(COD_ALUNO)=1 AND
    	  GROUPING_ID(Trunc(DATA))=0 THEN 'Total do Dia : '
     WHEN GROUPING_ID(COD_ALUNO)=1 AND
        GROUPING_ID(Trunc(DATA))=1 THEN 'Total Geral  : '
    END AS DESCRICAO,
    SUM(TOTAL) TOTAL
FROM TCONTRATO
GROUP BY ROLLUP(Trunc(DATA), COD_ALUNO);

-------********* Retorna somente subtotais
SELECT COD_ALUNO, Trunc(DATA), SUM(TOTAL)
FROM TCONTRATO
GROUP BY GROUPING SETS (COD_ALUNO, Trunc(DATA) );


------------*********
--Total igual repete o rank
--   1 - 1 - 3 - 4 - 4 - 6
SELECT Trunc(DATA), COD_ALUNO, SUM(TOTAL),
       RANK() OVER (ORDER BY SUM(TOTAL) DESC) POSICAO
FROM TCONTRATO
GROUP BY (Trunc(DATA), COD_ALUNO)

-------------*********
-- rank -> 1 - 2 - 3 - 3 - 5
SELECT COD_ALUNO, SUM(TOTAL),
       RANK() OVER (ORDER BY SUM(TOTAL) DESC) POSICAO
FROM TCONTRATO
GROUP BY (COD_ALUNO);

------------**********Posicao por grupo
-- rank -> 1 - 2 - 1 - 2
SELECT Trunc(DATA),COD_ALUNO,SUM(TOTAL),
       RANK() OVER (PARTITION BY Trunc(DATA)
   		  ORDER BY SUM(TOTAL) DESC) POSICAO
FROM TCONTRATO
GROUP BY (Trunc(DATA),COD_ALUNO)
ORDER BY COD_ALUNO;

---------------------------
SELECT COD_ALUNO, TOTAL,
     RANK() OVER (ORDER BY TOTAL DESC) "RANK()",
     DENSE_RANK() OVER (ORDER BY TOTAL DESC) "DENSE_RANK()"
FROM TCONTRATO
GROUP BY COD_ALUNO, TOTAL;

---------------*********
SELECT COD_ALUNO,SUM(TOTAL) "Total do Cliente",
  ROUND(RATIO_TO_REPORT(SUM(TOTAL)) OVER()*100 ,2)"% do Total"
FROM TCONTRATO
GROUP BY COD_ALUNO;

-----------**************
SELECT COD_ALUNO,
       Trunc(DATA),
       SUM(total) "Total do Dia",
       ROUND(RATIO_TO_REPORT(SUM(total)) OVER(PARTITION BY
       Trunc(DATA)) * 100, 2) "% do Dia"
FROM TCONTRATO
GROUP BY COD_ALUNO, Trunc(DATA)
ORDER BY 2 ASC, COD_ALUNO;

-------------------------

-----------**************
SELECT Trunc(DATA), SUM(Total) total_dia,
  LAG  (SUM(Total),1) OVER (ORDER BY Trunc(DATA)) anterior,
  LEAD (SUM(Total),1) OVER (ORDER BY Trunc(DATA)) proximo
FROM TCONTRATO
GROUP BY Trunc(DATA)
ORDER BY Trunc(DATA);



TOTAL  ANT     PROX
500    NULL    600
600    500     700
700    600     800
800    700     NULL








SELECT * FROM TCONTRATO


CREATE TABLE TCONTRATO
(
cod_contrato INTEGER NOT NULL PRIMARY KEY,
data DATE,
total NUMBER,
desconto NUMBER,
cod_aluno integer
)

INSERT INTO TCONTRATO VALUES (12,SYSDATE-130,2300,10,2)