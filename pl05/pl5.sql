--Mostrar o id, o nome e a idade dos marinheiros mais velhos (Figura 2). O comando deve usar uma 
--SNC como “operando” de um operador relacional,na cláusula WHERE

select id_marinheiro, nome, idade 
from marinheiros
where idade=(select max(idade) from marinheiros);

--Mostrar o id e o nome dos marinheiros que não reservaram barcos(Figura 3).O comando deve usar uma SNC como 
--“operando”de uma condição NOT IN, na cláusula WHERE. 

select id_marinheiro, nome
from marinheiros
where id_marinheiro not in(select id_marinheiro from reservas);


--Mostrar o id, o nome de cada marinheiro e a diferença da idade, em valor relativo,do marinheiro para a
--idade média dos marinheiros. O resultado deve ser apresentadopor ordem decrescente do valor absoluto da
--diferençaentreas idades(Figura 4).O comando deve usar uma SNCcomo “coluna”,na cláusula SELECT,
--e a função TRUNC no resultado da diferença.

select id_marinheiro, nome, trunc((select avg(idade) from marinheiros)-idade) as diff
from marinheiros
order by abs(diff) DESC;

--Mostrar o número total de marinheiros que reservaram barcos com a cor vermelho
-- e barcos com a cor verde(Figura 5) O comando deveusar uma SNC como “tabela”,na cláusula FROM.
select * from barcos;
select * from reservas;
select * from marinheiros;

select count(distinct id_marinheiro) as nr_total_marinheiros
from reservas
where id_barco in (select id_barco from barcos where cor='vermelho' and cor='verde');

select count(distinct id_marinheiro) as nr_total_marinheiros
from (select id_marinheiro 
from reservas 
where id_barco in (select id_barco from barcos where cor='vermelho')
intersect
select id_marinheiro 
from reservas 
where id_barco in (select id_barco from barcos where cor='verde'));

--Mostrar as datas com mais reservas de barcos(Figura 6). O comando deve usar umaSNC como “operando” 
--de um operador relacional,na cláusula HAVING.

select data from reservas
group by data
having count(data)=(select max(count(data)) from reservas group by data);

 --Copiar e alterar o comando da alínea 4A1 (Figura 2) de forma a usar uma SNC como “operando” 
--de uma condição ALL, na cláusula WHERE

-- ENUNCIADO DA 4A1(Mostrar o id, o nome e a idade dos marinheiros mais velhos (Figura 2). O comando deve 
-- usar uma SNC como “operando” de um operador relacional,na cláusula WHERE)

select id_marinheiro, nome, idade 
from marinheiros
where idade= all (select max(idade) from marinheiros);

-- Mostrar  o  id,  o  nome  e  a  idade  dos  marinheiros  que  não  são  os  mais  velhos,  por  ordem 
-- decrescente  da  idade  (Figura 7).  O  comando  deve  usar  uma SNC como “operando” 
-- de  uma condição ANY, na cláusula WHERE.

select id_marinheiro, nome, idade
from marinheiros
where idade < any (select max(idade) from marinheiros)
order by idade DESC;


--Mostrar  o  id,  o  nome  e  o número total  de  reservas de  barcos  dos  marinheiros, 
-- por  ordem decrescente  do número total  de  reservas  (Figura 8). 
-- O  comando  deve  usar  uma SC  como “coluna”, na cláusula SELECT

select id_marinheiro, nome, (select count(id_marinheiro) from reservas res where  res.id_marinheiro=mar.id_marinheiro) nr_reservas
from marinheiros mar
order by nr_reservas DESC;


-- Mostrar o id dos marinheiros cujo número total de reservas de um barco seja superior ao número médio de 
--reservas desse barco(Figura 9). Além disso, o resultado deve também incluir o id do barco e o 
--número total de reservas, respetivos. 
--O comando deve usar uma SC como “operando” de um operador relacional,na cláusula HAVING.

--mostrar quantas vezes cada marinheiro alugou um barco em especifico

select a.*
  FROM (select id_marinheiro, id_barco, count(*) as quant
from reservas 
group by id_barco, id_marinheiro) a,
(select id_barco, avg(quant) average from (select id_marinheiro, id_barco, count(*) as quant from reservas
group by id_barco, id_marinheiro)
group by id_barco) b
where a.quant>b.average and a.id_barco=b.id_barco;



-- Mostrar o nome dos marinheiros que reservaram todos os barcos com o nome Interlake(Figura 10).
-- O comando deve usar uma SC como "operando" numa condição NOT EXISTS, na cláusula WHERE

select id_marinheiro, id_barco from 
(select id_marinheiro, id_barco from reservas 
group by id_barco, id_marinheiro) a
where exists(select id_barco from barcos 
where nome='Interlake' and id_barco=a.id_barco);


select id_marinheiro, id_barco from 
(select id_marinheiro, id_barco from 
(select id_marinheiro, id_barco from reservas) a
where  exists(select id_barco from barcos 
where nome like 'Interlake' and a.id_barco=id_barco)) b
where id_barco=all(select id_barco from barcos 
where nome like 'Interlake' and b.id_barco=id_barco);

select m.nome from marinheiros m
join reservas r on r.id_marinheiro=m.id_marinheiro
join barcos b on r.id_barco=b.id_barco
where b.nome='Interlake'

select m.nome 
( select id_barco from barcos
    where b.nome='Interlake'
) all (
    
)


select id_barco from barcos 
where nome like 'Interlake';

select id_marinheiro, id_barco from reservas 
group by id_barco, id_marinheiro;

select * from reservas;


select id_barco from barcos 
where nome='Interlake';

select id_marinheiro, id_barco from reservas
group by id_barco, id_marinheiro;

select a.id_marinheiro, b.id_barco from reservas a
join reservas b
on a.id_marinheiro=b.id_marinheiro and a.id_barco!=b.id_barco;




