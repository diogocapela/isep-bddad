------------------------------------------------------------------------------------------------------
-- Consultas
------------------------------------------------------------------------------------------------------

-- a) Liste a média de salários e o salário anual (considerando o subsídio de férias e natal) para os empregados do armazém ‘Parafusos’.

with MediaSalariosArmazemParafusos as (
    select avg(e.salario_semanal) as media_de_salarios from Empregado e, Armazem a
    where e.cod_armazem = a.cod_armazem
    and a.nome = 'Parafusos'
)

select (e.salario_semanal * 4 * 14) as salario_anual, msap.media_de_salarios from Empregado e, Armazem a, MediaSalariosArmazemParafusos msap
where e.cod_armazem = a.cod_armazem
and a.nome = 'Parafusos';


-- b) Liste as ordens de compras satisfeitas (estado = 3) que não possuem nenhum dos produtos do fornecedor que oferece o maior desconto.

select * from OrdemCompra
where estado = 3
and cod_fornecedor not in (
    select cod_fornecedor from FornecedorProduto
    where desconto = (
        select max(desconto) from FornecedorProduto
    )
)

-- c) Liste o nome dos armazéns que têm em stock todos os produtos que foram fornecidos ao armazém que possui o maior número de empregados.

select distinct(a.nome) from Produto p, ArmazemProduto ap, Armazem a
where p.cod_produto = ap.cod_produto
and ap.cod_armazem = a.cod_armazem
and ap.stock > 0
and ap.cod_produto in (
	-- todos os produtos que foram fornecidos ao armazém que possui o maior número de empregados
	select distinct(cod_produto) from ArmazemProduto
	where cod_armazem = (
		-- armazém que possui o maior número de empregados
		select cod_armazem from (
		    select cod_armazem, count(cod_empregado) from Empregado
		    group by cod_armazem
		    having count(cod_empregado) = (
		    	-- número de maior número de empregados num armazem
		        select max(count(cod_empregado)) from Empregado
		        group by cod_armazem
		    )
		)
	)
)

-- d) Indique quais os armazéns que, no período de 01/03/2018 a 15/10/2018, têm o número total de ordens de compra
-- pendentes (estado = 2), maior do que qualquer armazém da cidade do Porto nesse período.

select a.cod_armazem, count(*) from Armazem a, ArmazemProduto ap, Produto p, OrdemCompraProduto ocp, OrdemCompra oc
where a.cod_armazem = ap.cod_armazem
and ap.cod_produto = p.cod_produto
and p.cod_produto = ocp.cod_produto
and ocp.nr_ordem = oc.nr_ordem
and oc.estado = 2
and oc.data_compra < TO_DATE('01/03/2018', 'dd/mm/yyyy')
and oc.data_entrega > TO_DATE('15/10/2018', 'dd/mm/yyyy')
group by a.cod_armazem
having count(oc.nr_ordem) > (
	-- número máximo de ordens de compra pendentes (estado = 2) nos armazéns da cidade do Porto no período de 01/03/2018 a 15/10/2018
	select max(count(*)) from Armazem a, ArmazemProduto ap, Produto p, OrdemCompraProduto ocp, OrdemCompra oc
	where a.cod_armazem = ap.cod_armazem
	and ap.cod_produto = p.cod_produto
	and p.cod_produto = ocp.cod_produto
	and ocp.nr_ordem = oc.nr_ordem
	and oc.estado = 2
	and a.cidade = 'Porto'
	and oc.data_compra < TO_DATE('01/03/2018', 'dd/mm/yyyy')
	and oc.data_entrega > TO_DATE('15/10/2018', 'dd/mm/yyyy')
	group by ap.cod_armazem
)

-- e) Liste o nome do empregado que não é supervisor e que efetuou ordens de compra em maior número do que todos os
-- supervisores que possuem um salário mensal entre 1000€ e 3000€.

select e3.nome from Empregado e3
where e3.cod_empregado = (
	select e2.cod_empregado from Empregado e2, OrdemCompra oc2
	where e2.cod_empregado = oc2.cod_empregado
	and e2.cod_empregado IS NOT NULL
	group by e2.cod_empregado
	having count(*) > (
		-- número de ordens de compra efectuadas por todos os supervisores que possuem um salário mensal entre 1000€ e 3000€
		select count(oc1.nr_ordem) from Empregado e1, OrdemCompra oc1
		where e1.cod_empregado = oc1.cod_empregado
		and e1.cod_supervisor IS NULL
		and (e1.salario_semanal * 4) >= 1000
		and (e1.salario_semanal * 4) <= 3000
	)
)

-- f) Liste o código do armazém, o número do corredor e o número da prateleira dos produtos que foram menos vezes comprados.

select a.cod_armazem, ap.corredor, ap.prateleira from Armazem a, ArmazemProduto ap, Produto p, OrdemCompraProduto ocp
where a.cod_armazem = ap.cod_armazem
and ap.cod_produto = p.cod_produto
and p.cod_produto = ocp.cod_produto
and p.cod_produto in (
	select count(ocp.nr_ordem) from Armazem a, ArmazemProduto ap, Produto p, OrdemCompraProduto ocp
	where a.cod_armazem = ap.cod_armazem
	and ap.cod_produto = p.cod_produto
	and p.cod_produto = ocp.cod_produto
	group by p.cod_produto
	having count(ocp.nr_ordem) = (
		-- menor número de compras de um produto
		select min(count(ocp.nr_ordem)) from Produto p, OrdemCompraProduto ocp
		where p.cod_produto = ocp.cod_produto
		group by p.cod_Produto
	)
)


--g) Liste todos os corredores de armazéns onde atualmente se encontram produtos que tiveram o maior número de ordens de
-- compra com desconto acima dos 20%. 

-- maior número de ordens de compra de um produto com desconto acima dos 20%
select max(count(ocp.nr_ordem)) from Produto p, FornecedorProduto fp, OrdemCompraProduto ocp
where p.cod_produto = fp.cod_produto
and p.cod_produto = ocp.cod_produto
and fp.desconto > 0.2
group by p.cod_Produto

-- h) Liste o produto e volume de compras mensal, para o ano 2018, dos produtos que estão em armazéns cujo stock está pelo menos
-- 50% acima do stock mínimo.

-- stock mínimo
select cod_produto, stock_minimo from ArmazemProduto

-- i) Liste as ordens de compra no estado satisfeito, entre o mês de Junho e Agosto de 2018, cuja hora de elaboração é inferior às 10
-- horas da manhã e com uma diferença entre a data de compra e a data da entrega superior a 10 dias

select * from OrdemCompra
where estado = 3
and data_entrega > TO_DATE('01/06/2018', 'dd/mm/yyyy')
and data_compra < TO_DATE('31/07/2018', 'dd/mm/yyyy')
and data_entrega - data_compra > 10

-- j) Liste para o empregado com o código = 1223 a percentagem de ordens de compra satisfeitas em que foi responsável face às ordens de
-- compra satisfeitas que pertencem ao armazém ‘Tintas’ e possuem um valor total compreendido entre 5.000€ e 10.000€.

select ((t1.numero / t2.numero) * 100) from (
	-- número de ordens de compra satisfeitas em que o empregado com o código = 1223 foi responsável
	select count(*) as numero from OrdemCompra oc, Empregado e
	where oc.cod_empregado = e.cod_empregado
	and oc.estado = 3
	and e.cod_empregado = 1223
) t1, (
	-- número de ordens de compra satisfeitas que pertencem ao armazém ‘Tintas’ e possuem um valor total compreendido entre 5.000€ e 10.000€
	select count(*) as numero from OrdemCompra oc, OrdemCompraProduto ocp, Produto p, ArmazemProduto ap, Armazem a
	where oc.nr_ordem = ocp.nr_ordem
	and ocp.cod_produto = p.cod_produto
	and p.cod_produto = ap.cod_produto
	and ap.cod_armazem = a.cod_armazem
	and a.nome = 'Tintas'
	and oc.estado = 3
	and oc.valor_total >= 5000
	and oc.valor_total <= 10000
) t2
