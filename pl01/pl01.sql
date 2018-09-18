-- 1) Mostrar todos os dados da tabela CD;
select * from cd;

-- 2) Mostrar o título e a data de compra de todos os CD;
select titulo, data_compra from cd;

-- 3) Mostrar a data de compra de todos CD;
select titulo, data_compra from cd;

-- 4) Mostrar o resultado da alínea anterior, mas sem repetições;
select distinct data_compra from cd;

-- 5) Mostrar o código do CD e o intérprete de todas as músicas;
select cod_cd, interprete from musicas;

-- 6) Mostrar o resultado da alínea anterior, mas sem repetições;
select distinct cod_cd, interprete from musicas;

-- 7) Mostrar a data de compra de todos os CD com o resultado intitulado 'Data de Compra';
select data_compra as 'Data de Compra' from cd;

-- 8) Mostrar o título, o valor pago e o respetivo valor do IVA de todos os CD. O valor do IVA é calculado de acordo com a seguinte fórmula: valor do IVA = (valor pago * 0.23) / 1.23;
select titulo, valor_pago, (valor_pago * 0.23) from cd;

-- 9) Mostrar todos os dados de todas as músicas do CD com o código 2;
select * from musicas where cod_cd = 2;

-- 10) Mostrar todos os dados de todas as músicas que não pertencem ao CD com o código 2;
select * from musicas where cod_cd != 2;

-- 11) Mostrar todos os dados de todas as músicas do CD com o código 2 cuja duração seja superior a 5;
select * from musicas where cod_cd = 2 AND duracao > 5;

-- 12) Mostrar todos os dados das músicas do CD com o código 2 cuja duração pertença ao intervalo [4,6];
select * from musicas where cod_cd = 2 AND duracao >= 4 AND duracao <= 6;

-- 13) Mostrar todos os dados das músicas do CD com o código 2 cuja duração seja inferior a 4 ou superior a 6;
select * from musicas where cod_cd = 2 AND duracao < 4 AND duracao > 6;

-- 14) Mostrar todos os dados das músicas com os números: 1, 3, 5 ou 6;
select * from musicas where cod_cd IN (1, 3, 5, 6);

-- 15) Mostrar todos os dados das músicas com os números diferentes de 1, 3, 5 e 6;
select * from musicas where cod_cd NOT IN (1, 3, 5, 6);

-- 16) Mostrar os títulos dos CD comprados na FNAC;
select titulo from cd where local_compra LIKE 'FNAC';

-- 17) Mostrar os títulos dos CD que não foram comprados na FNAC;
select titulo from cd where local_compra NOT LIKE 'FNAC';

-- 18) Mostrar todos os dados das músicas cujo intérprete é uma orquestra;
select * from musicas where interprete LIKE 'orquestra%';

-- 19) Mostrar todos os dados das músicas cujo intérprete tem um Y;
select * from musicas where interprete LIKE '%Y%';

-- 20) Mostrar todos os dados das músicas cujo nome termina com DAL?, sendo ? qualquer caráter;
select * from musicas where titulo LIKE '%DAL_';

-- 21) Mostrar todos os dados das músicas cujo título tem o caráter %;
select * from musicas where titulo LIKE '%@%%' ESCAPE '@';

-- 22) Mostrar todos os dados das músicas cujo título é iniciado pela letra B, D ou H;
select * from musicas where titulo LIKE IN ('B%', 'D%', 'H%'); - errado

23) Mostrar todos os dados dos CD sem o local de compra registado;
24) Mostrar todos os dados dos CD com o local de compra registado.