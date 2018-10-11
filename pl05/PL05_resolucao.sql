--A1) Mostrar o id, o nome e a idade dos marinheiros mais velhos (Figura 2). O comando deve usar uma SNC como �operando� de 
--um operador relacional, na cl�usula WHERE.

SELECT M1.ID_MARINHEIRO, M1.NOME, M1.IDADE FROM MARINHEIROS M1
WHERE M1.IDADE = (SELECT MAX(M2.IDADE) FROM MARINHEIROS M2);


--A2) Mostrar o id e o nome dos marinheiros que n�o reservaram barcos (Figura 3). O comando deve usar uma SNC como �operando� 
--de uma condi��o NOT IN, na cl�usula WHERE.

SELECT M1.ID_MARINHEIRO, M1.NOME FROM MARINHEIROS M1
WHERE M1.ID_MARINHEIRO NOT IN (SELECT ID_MARINHEIRO FROM RESERVAS)
ORDER BY ID_MARINHEIRO;


--A3) Mostrar o id, o nome de cada marinheiro e a diferen�a da idade, em valor relativo, do marinheiro para a idade m�dia dos 
--marinheiros. O resultado deve ser apresentado por ordem decrescente do valor absoluto da diferen�a entre as idades (Figura 4). O 
--comando deve usar uma SNC como �coluna�, na cl�usula SELECT, e a fun��o TRUNC no resultado da diferen�a.

SELECT M1.ID_MARINHEIRO, M1.NOME, 
        TRUNC((SELECT (AVG(M2.IDADE)) FROM MARINHEIROS M2) - M1.IDADE) AS DIFERENCA
        FROM MARINHEIROS M1
ORDER BY ABS(DIFERENCA) DESC;


--A4) Mostrar o n�mero total de marinheiros que reservaram barcos com a cor vermelho e barcos com a cor verde (Figura 5). O 
--comando deve usar uma SNC como �tabela�, na cl�usula FROM.

SELECT COUNT(*) FROM
    ((SELECT r.ID_MARINHEIRO FROM RESERVAS r
    INNER JOIN BARCOS b ON b.ID_BARCO = r.ID_BARCO
    WHERE UPPER(b.COR) = 'VERMELHO')
    INTERSECT
    (SELECT r1.ID_MARINHEIRO FROM RESERVAS r1
    INNER JOIN BARCOS b1 ON b1.ID_BARCO = r1.ID_BARCO
    WHERE UPPER(b1.COR) = 'VERDE'));

--A5) Mostrar as datas com mais reservas de barcos (Figura 6). O comando deve usar uma SNC como �operando� de um operador relacional, 
--na cl�usula HAVING.

