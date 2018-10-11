--4.1) Mostrar, numa coluna, o título de cada CD e de cada uma das músicas;

SELECT TITULO FROM CD
UNION
SELECT TITULO FROM MUSICAS;


--4.2) Copiar e alterar o comando da alínea anterior, de modo a não mostrar os registos repetidos;

SELECT DISTINCT(TITULO) FROM CD
UNION
SELECT DISTINCT(TITULO) FROM MUSICAS;


--4.3) Copiar e alterar o comando da alínea anterior, de modo a apresentar também o comprimento de cada título e por ordem decrescente;

SELECT DISTINCT(TITULO),LENGTH(TITULO) AS "Tamanho do Título" FROM CD
UNION
SELECT DISTINCT(TITULO),LENGTH(TITULO) AS "Tamanho do Título" FROM MUSICAS
ORDER BY "Tamanho do Título" DESC;


--4.4) Mostrar a duração das músicas dos Pink Floyd que são iguais à duração de músicas de outros intérpretes;

SELECT DURACAO FROM MUSICAS
WHERE INTERPRETE LIKE 'Pink Floyd'
INTERSECT
SELECT DURACAO FROM MUSICAS
WHERE INTERPRETE NOT LIKE 'Pink Floyd';


--4.5) Alterar o comando da alínea anterior, de modo a mostrar a duração das músicas por ordem decrescente;

SELECT DURACAO FROM MUSICAS
WHERE INTERPRETE LIKE 'Pink Floyd'
INTERSECT
SELECT DURACAO FROM MUSICAS
WHERE INTERPRETE NOT LIKE 'Pink Floyd'
ORDER BY DURACAO DESC;


--4.6) Mostrar o id das editoras que não estão relacionadas com qualquer CD;

SELECT ID_EDITORA FROM EDITORAS
MINUS
SELECT ID_EDITORA FROM CD;


--4.7) Alterar o comando da alínea anterior, de modo a mostrar o resultado por ordem decrescente.

SELECT ID_EDITORA FROM EDITORAS
MINUS
SELECT ID_EDITORA FROM CD
ORDER BY ID_EDITORA DESC;


--5.1) Mostrar apenas a quantidade de CD comprados por local de compra;

SELECT COUNT(COD_CD) FROM CD
GROUP BY LOCAL_COMPRA;


--5.2) Alterar o comando da alínea anterior, de forma a não mostrar registos duplicados;

SELECT DISTINCT(COUNT(COD_CD)) FROM CD
GROUP BY LOCAL_COMPRA;


--5.3) Mostrar a quantidade de CD comprados por local de compra e o respetivo local de compra;

SELECT DISTINCT(COUNT(VALOR_PAGO)), LOCAL_COMPRA FROM CD
WHERE LOCAL_COMPRA IS NOT NULL
GROUP BY LOCAL_COMPRA;


--5.4) Copiar e alterar o comando da alínea anterior, de forma a mostrar o resultado por ordem crescente da quantidade de CD comprados;

SELECT DISTINCT(COUNT(VALOR_PAGO)), LOCAL_COMPRA FROM CD
GROUP BY LOCAL_COMPRA
ORDER BY COUNT(VALOR_PAGO) ASC;


--5.5) Copiar e alterar o comando da alínea anterior, de forma a mostrar os registos com locais de compra conhecidos;

SELECT DISTINCT(COUNT(VALOR_PAGO)), LOCAL_COMPRA FROM CD
WHERE LOCAL_COMPRA IS NOT NULL
GROUP BY LOCAL_COMPRA
ORDER BY COUNT(VALOR_PAGO) ASC;


--5.6) Copiar e alterar o comando da alínea anterior, de forma a mostrar também, para cada local de compra, o valor total pago e o maior 
--valor pago;

SELECT DISTINCT(COUNT(VALOR_PAGO)), LOCAL_COMPRA, SUM(VALOR_PAGO), MAX(VALOR_PAGO) FROM CD
WHERE LOCAL_COMPRA IS NOT NULL
GROUP BY LOCAL_COMPRA
ORDER BY COUNT(VALOR_PAGO) ASC;


--5.7) Mostrar, para cada CD e respetivos intérpretes, a quantidade de músicas do CD em que o intérprete participa. Além da quantidade 
--referida, também deve ser apresentado o código do CD e o intérprete;

SELECT COUNT(NR_MUSICA), COD_CD, INTERPRETE FROM MUSICAS
GROUP BY INTERPRETE, COD_CD;


--5.8) Copiar e alterar o comando da alínea anterior, de modo a mostrar apenas, o código do CD e o intérprete;

SELECT COD_CD, INTERPRETE FROM MUSICAS
GROUP BY INTERPRETE, COD_CD;


--5.9) Copiar e alterar o comando da alínea anterior, de modo a mostrar apenas o intérprete;

SELECT INTERPRETE FROM MUSICAS;


--5.10) Mostrar a quantidade de CD comprados em cada local de compra;

SELECT COUNT(COD_CD), LOCAL_COMPRA FROM CD
GROUP BY LOCAL_COMPRA;


--5.11) Alterar o comando da alínea anterior, de modo a mostrar apenas as quantidades superiores a 2;

SELECT COUNT(COD_CD) AS "Quantidade", LOCAL_COMPRA FROM CD
GROUP BY LOCAL_COMPRA
HAVING COUNT(COD_CD) > 2;


--5.12) Mostrar os locais de compra, cujo média do valor pago por CD é inferior a 10, juntamente com o respetivo total do valor pago.

SELECT LOCAL_COMPRA, SUM(VALOR_PAGO), AVG(VALOR_PAGO) AS "Média" FROM CD
GROUP BY LOCAL_COMPRA
HAVING AVG(VALOR_PAGO) < 10;


--5.13) Mostrar o valor total pago nos locais de compra, cuja quantidade de CD comprados é inferior a 2. O local de compra também deve 
--ser visualizado;

SELECT SUM(VALOR_PAGO) AS "Total Pago", LOCAL_COMPRA FROM CD
GROUP BY LOCAL_COMPRA
HAVING COUNT(COD_CD) < 2;


--5.14) Mostrar o intérprete e o código do CD em que o intérprete participa apenas em 1 música. O resultado deve ser apresentado por ordem 
--crescente do código do CD e, em caso de igualdade, por ordem alfabética do intérprete;

SELECT COD_CD, INTERPRETE FROM MUSICAS
GROUP BY cod_cd, interprete
HAVING COUNT (*) = 1
ORDER BY cod_cd, interprete;


--5.15) Copiar e alterar o comando da alínea anterior, de modo a mostrar apenas os intérpretes e sem duplicados;

SELECT DISTINCT(INTERPRETE) FROM MUSICAS
GROUP BY interprete
HAVING COUNT (*) = 1
ORDER BY interprete;


--5.16) Copiar e alterar o comando da alínea anterior, de modo a mostrar apenas os intérpretes começados por E ou L (letras 
--maiúsculas ou minúsculas);

SELECT DISTINCT(INTERPRETE) FROM MUSICAS
WHERE UPPER(INTERPRETE) LIKE 'E%' OR UPPER(INTERPRETE) LIKE 'L%'
GROUP BY interprete
HAVING COUNT (*) = 1
ORDER BY interprete;


--5.17) Copiar e alterar o comando da alínea 13 para não mostrar os locais de compra desconhecidos;

SELECT SUM(VALOR_PAGO) AS "Total Pago", LOCAL_COMPRA FROM CD
WHERE LOCAL_COMPRA IS NOT NULL
GROUP BY LOCAL_COMPRA
HAVING COUNT(COD_CD) < 2;


--5.18) Mostrar, para cada CD, o título e a quantidade de músicas;

SELECT C.TITULO, COUNT(C.COD_CD) FROM CD C, MUSICAS M
WHERE C.COD_CD = M.COD_CD
GROUP BY C.TITULO;


--5.19) Mostrar, para cada CD, o código, o título e a quantidade de músicas;

SELECT C.COD_CD, C.TITULO, COUNT(C.COD_CD)FROM CD C, MUSICAS M
WHERE C.COD_CD = M.COD_CD
GROUP BY C.COD_CD, C.TITULO;


--5.20) Mostrar, para cada CD, o código, o título e a quantidade de músicas cuja duração é superior a 5;

SELECT C.COD_CD, C.TITULO, COUNT(C.COD_CD) FROM CD C, MUSICAS M
WHERE C.COD_CD = M.COD_CD AND DURACAO > 5
GROUP BY C.COD_CD, C.TITULO;


--5.21) Mostrar, para cada CD com menos de 6 músicas, o código, o título e a quantidade de músicas do CD;

SELECT C.COD_CD, C.TITULO, COUNT(C.COD_CD) FROM CD C, MUSICAS M
WHERE C.COD_CD = M.COD_CD
GROUP BY C.COD_CD, C.TITULO
HAVING COUNT(C.COD_CD) < 6;


--5.22) Mostrar, para cada CD cujas músicas têm uma duração média superior a 4, o código, o título e a quantidade de músicas do CD.

SELECT C.COD_CD, C.TITULO, COUNT(C.COD_CD) FROM CD C, MUSICAS M
WHERE C.COD_CD = M.COD_CD
GROUP BY C.COD_CD, C.TITULO
HAVING AVG(M.DURACAO) < 4;