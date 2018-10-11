--Mostrar o id, o nome e a idade dos marinheiros mais velhos (Figura 2). O comando deve usar uma 
--SNC como �operando� de um operador relacional,na cl�usula WHERE

select id_marinheiro, nome, idade 
from marinheiros
where idade=(select max(idade) from marinheiros);

--Mostrar o id e o nome dos marinheiros que n�o reservaram barcos(Figura 3).O comando deve usar uma SNC como 
--�operando�de uma condi��o NOT IN, na cl�usula WHERE. 

select id_marinheiro, nome
from marinheiros
where id_marinheiro not in(select id_marinheiro from reservas);


--Mostrar o id, o nome de cada marinheiro e a diferen�a da idade, em valor relativo,do marinheiro para a
--idade m�dia dos marinheiros. O resultado deve ser apresentadopor ordem decrescente do valor absoluto da
--diferen�aentreas idades(Figura 4).O comando deve usar uma SNCcomo �coluna�,na cl�usula SELECT,
--e a fun��o TRUNC no resultado da diferen�a.

select id_marinheiro, nome, trunc((select avg(idade) from marinheiros)-idade) as diff
from marinheiros
order by abs(diff) DESC;

--Mostrar o n�mero total de marinheiros que reservaram barcos com a cor vermelho
-- e barcos com a cor verde(Figura 5) O comando deveusar uma SNC como �tabela�,na cl�usula FROM.
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

--Mostrar as datas com mais reservas de barcos(Figura 6). O comando deve usar umaSNC como �operando� 
--de um operador relacional,na cl�usula HAVING.

select data from reservas
group by data
having count(data)=(select max(count(data)) from reservas group by data);

 --Copiar e alterar o comando da al�nea 4A1 (Figura 2) de forma a usar uma SNC como �operando� 
--de uma condi��o ALL, na cl�usula WHERE

-- ENUNCIADO DA 4A1(Mostrar o id, o nome e a idade dos marinheiros mais velhos (Figura 2). O comando deve 
-- usar uma SNC como �operando� de um operador relacional,na cl�usula WHERE)

select id_marinheiro, nome, idade 
from marinheiros
where idade= all (select max(idade) from marinheiros);

-- Mostrar  o  id,  o  nome  e  a  idade  dos  marinheiros  que  n�o  s�o  os  mais  velhos,  por  ordem 
-- decrescente  da  idade  (Figura 7).  O  comando  deve  usar  uma SNC como �operando� 
-- de  uma condi��o ANY, na cl�usula WHERE.

select id_marinheiro, nome, idade
from marinheiros
where idade < any (select max(idade) from marinheiros)
order by idade DESC;


--Mostrar  o  id,  o  nome  e  o n�mero total  de  reservas de  barcos  dos  marinheiros, 
-- por  ordem decrescente  do n�mero total  de  reservas  (Figura 8). 
-- O  comando  deve  usar  uma SC  como �coluna�, na cl�usula SELECT

select id_marinheiro, nome, (select count(id_marinheiro) from reservas res where  res.id_marinheiro=mar.id_marinheiro) nr_reservas
from marinheiros mar
order by nr_reservas DESC;


-- Mostrar o id dos marinheiros cujo n�mero total de reservas de um barco seja superior ao n�mero m�dio de 
--reservas desse barco(Figura 9). Al�m disso, o resultado deve tamb�m incluir o id do barco e o 
--n�mero total de reservas, respetivos. 
--O comando deve usar uma SC como �operando� de um operador relacional,na cl�usula HAVING.

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
-- O comando deve usar uma SC como "operando" numa condi��o NOT EXISTS, na cl�usula WHERE

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




