-- Merge

SELECT * FROM TALUNO
ORDER BY COD_ALUNO

SELECT * FROM TCONTRATO

CREATE SEQUENCE seq_con START WITH 50;
--
MERGE INTO TCONTRATO tcn
    USING (SELECT COD_ALUNO AS ALUNO
    FROM TALUNO)
    ON (tcn.COD_ALUNO = ALUNO )
    WHEN MATCHED THEN --Encontrou o registro
    UPDATE SET desconto = 44
    WHEN NOT MATCHED THEN --nao encontrou o registro
    INSERT(tcn.COD_CONTRATO, tcn.DATA, tcn.COD_ALUNO,
    tcn.desconto, tcn.total)
    VALUES( Seq_Con.NextVal, SYSDATE, ALUNO, 0, 666);
