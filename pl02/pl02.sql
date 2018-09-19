-- A. Seleções simples

-- 1) Mostrar todos os dados da tabela Equipas;
select * from equipas;

-- 2) Mostrar todos os dados da equipa com o id igual a 12;
select * from equipas where id_equipa = 2;

-- 3) Mostrar o id e o nome de todas as equipas;
select id_equipa, nome from equipas;

-- 4) Mostrar o id, o nome e a idade dos treinadores com menos de 40 anos de idade;
select id_treinador, nome, idade from treinadores where idade < 40;

-- 5) Mostrar todos os dados da tabela Experiencias relativos aos treinadores que treinaram juniores ou que tenham mais do que 10 anos de experiência;
select * from experiencias
inner join treinadores on experiencias.id_treinador = treinadores.id_treinador
and experiencias.escalao = 'juniores' or experiencias.anos > 10;

-- 6) Mostrar todos os dados dos treinadores com idade pertencente ao intervalo [45, 53] e por ordem decrescente da idade;
select * from treinadores where idade between 45, 53 order by desc;

-- 7) Mostrar todos os dados das bolas dos fabricantes Reebok e Olimpic;
select * from bolas where fabricante = 'Reebok' or fabricante = 'Olimpic';

-- 8) Mostrar todos os dados dos treinadores cujo nome começa pela letra A.
select * from treinadores where nome like 'A%';

-- B. Funções de agregação

-- 1) Mostrar a quantidade de equipas que disputam o campeonato;
select count(id_equipa) from equipas;

-- 2) Mostrar a quantidade de fabricantes distintos que produzem bolas usadas no campeonato;
select distinct count(fabricante) from bolas;

-- 3) Mostrar a quantidade de treinadores com idade superior a 40 anos;
select count(id_treinador) from treinadores where idade > 40;

-- 4) Mostrar a idade do treinador mais velho.
select max(idade) from treinadores;

-- C. Seleções em múltiplas tabelas – Junções (joins)

-- 1) Mostrar o id das equipas que utilizam bolas do fabricante Adidas;
select id_equipa from equipas
inner join bolas on equipas.id_equipa = bolas.id_equipa;

-- 2) Mostrar o resultado da alínea anterior, mas sem repetições;
select distinct id_equipa from equipas
inner join bolas on equipas.id_equipa = bolas.id_equipa;

-- 3) Mostrar a média das idades dos treinadores de juvenis;
select avg(idade) from treinadores
inner join experiencias on treinadores.id_treinador = experiencias.id_treinador
where experiencias.escalao = 'juvenis';

-- 4) Mostrar todos os dados dos treinadores que treinaram juniores durante 5 ou mais anos;
select * from treinadores
inner join experiencias on treinadores.id_treinador = experiencias.id_treinador
where experiencias.escalao = 'juniores' and experiencias.anos >= 5;

-- 5) Mostrar todos os dados dos treinadores e das equipas por eles treinadas;
select * from treinadores
inner join experiencias on treinadores.id_treinador = experiencias.id_treinador
inner join equipas on equipas.id_equipa = experiencias.id_equipa;

-- 6) Mostrar os nomes e os telefones dos treinadores e os nomes das equipas por eles treinadas;
select t.nome, t.telefone, equipas.nome from treinadores t
inner join experiencias on t.id_treinador = experiencias.id_treinador
inner join equipas on equipas.id_equipa = experiencias.id_equipa;

-- outra forma mais eficaz é sem inner join:
select t.nome, t.telefone, e.nome from treinadores t, equipas e, experiencias exp
where t.id_treinador = exp.id_treinador and exp.id_equipa = e.id_equipa;


-- 7) Mostrar todos os dados da equipa do Académico e dos respetivos treinadores;
select * from equipas
inner join experiencias on equipas.id_equipa = experiencias.id_equipa
inner join treinadores on experiencias.id_treinador = treinadores.id_treinador
where equipas.nome = 'Académico';



-- 8) Mostrar a idade do treinador mais velho do Académico;
select max(idade) from treinadores
inner join experiencias on treinadores.id_treinador = experiencias.id_treinador
inner join equipas on experiencias.id_equipa = equipas.id_equipa
where equipas.nome = 'Académico';



-- 9) Mostrar o total de anos de experiência do treinador António do Académico.

select sum(exp.anos) from experiencias exp, equipas e, treinadores t
where t.nome = 'António' and e.nome = 'Académico';

























































































