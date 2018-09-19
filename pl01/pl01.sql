-- A. Seleções simples
---------------------------------------------------------

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
select * from musicas where cod_cd not between 4 and 6;

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

-- 23) Mostrar todos os dados dos CD sem o local de compra registado;
select * from cd where local_compra IS null;

-- 24) Mostrar todos os dados dos CD com o local de compra registado.
select * from cd where local_compra is not null;



-- B. Ordenações
---------------------------------------------------------

-- 1) Mostrar o título e a data de compra dos CD, por ordem alfabética do título do CD;
select titulo, data_compra from cd order by titulo;

-- 2) Mostrar o título e a data de compra dos CD, por ordem descendente da data de compra do CD;
select titulo, data_compra from cd order by data_compra desc;

-- 3) Mostrar o título e o local de compra dos CD, por ordem ascendente do local de compra do CD;
select titulo, local_compra from cd order by local_compra;

-- 4) Mostrar o resultado da alínea anterior, mas por ordem descendente do local de compra do CD;
select titulo, local_compra from cd order by local_compra desc;

-- 5) Mostrar o título, o valor pago e o respetivo valor do IVA dos CD, por ordem decrescente do IVA;
select titulo, valor_pago, (valor_pago * 0.23) from cd order by (valor_pago * 0.23) desc;

-- 6) Mostrar o título do CD por ordem descendente da data de compra e, no caso da igualdade de datas, por ordem alfabética do título.
select * from cd order by data_compra, titulo;


-- C. Funções de agregação
---------------------------------------------------------

-- 1) Mostrar a quantidade de músicas;
select count(nr_musica) from musicas;

-- 2) Mostrar a quantidade de locais de compra distintos;
select distinct count(local_compra) from cd;

-- 3) Mostrar o total gasto com a compra de todos os CD;
select sum(valor_pago) from cd;

-- 4) Mostrar o maior valor pago por um CD;
select max(valor_pago) from cd;

-- 5) Mostrar o menor valor pago por um CD;
select min(valor_pago) from cd;

-- 6) Mostrar a média da duração de todas as músicas.
select avg(duracao) from musicas;



-- D. Seleções em múltiplas tabelas – Junções (joins)
---------------------------------------------------------

-- 1) Mostrar o título do CD e o título das músicas de todos os CD;
select cd.titulo, musicas.titulo from cd inner join musicas on cd.cod_cd = musicas.cod_cd;

-- 2) Mostrar o título do CD e o título da música com o número 1 de cada CD;
select cd.titulo, musicas.titulo from cd inner join musicas on cd.cod_cd = musicas.cod_cd and musicas.nr_musica = 1;

-- 3) Mostrar o número, o título e a duração, de todas as músicas do CD com o título Punkzilla.
select musicas.nr_musica, musicas.titulo, musicas.duracao from musicas inner join cd on cd.cod_cd = musicas.cod_cd and cd.titulo = 'Punkzilla';
























































