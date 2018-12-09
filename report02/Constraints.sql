--0 - a ZonaGeografica tem q ter coordenadas geográficas WGS84

ALTER TABLE ZonaGeografica ADD CONSTRAINT unique_coordenadas UNIQUE(
	coordenada_semi_major_axias_a,
	coordenada_semi_major_axias_a,
	coordenada_inverse_flattening
);

-- 1 - Capacidade do armazem tem q ser maior q zero

ALTER TABLE Zona ADD CONSTRAINT ck_zona_capacidade CHECK(
  capacidade >= 0
);



--2 - Quantidade e qnt de stock minimo dos artigos num armazem tem q ser maior q zero

ALTER TABLE Armazem_Artigo ADD CONSTRAINT ck_armazem_artigo_quantidades CHECK(
	quantidade_stock_minimo > 0 AND
	quantidade_stock > 0
);

-- 9 -  Se algum artigo, de uma dada
-- encomenda, atingiu o stock mínimo a nota de encomenda é colocada como pendente. 


ALTER TABLE NotaEncomenda ADD CONSTRAINT ck_nota_encomenda_estado CHECK(
	estado = 'pendente' OR
	estado = 'a caminho' OR
	estado = 'entregue' OR
	estado = 'cancelado'
);



--13 - KM do veiculo e capacidade nao pode ser abaixo de zero

ALTER TABLE Veiculo ADD CONSTRAINT ck_veiculo_numero_kilometros CHECK(
  numero_kilometros >= 0
);



-- 19 - a disponibilidade de um veiculo so pode ser S ou N

ALTER TABLE Veiculo ADD CONSTRAINT ck_Veiculo_disponibilidade CHECK(
	disponibilidade = 'S' OR
	disponibilidade = 'N'
);





-- 20 identificador nota de encomneda gerado automatiamente

--Check do nif Empregado

ALTER TABLE Empregado ADD CONSTRAINT ck_Empregado_nif CHECK(
	nif >= 100000000 OR
	nif <= 999999999
);

--check do nif  cliente
ALTER TABLE Cliente ADD CONSTRAINT ck_Cliente_nif CHECK(
	nif >= 100000000 OR
	nif <= 999999999
);

--check telemovel cliente

ALTER TABLE Cliente ADD CONSTRAINT ck_Cliente_telemovel CHECK(
	telemovel >= 910000000 OR
	telemovel <= 919999999 OR
	telemovel >= 930000000 OR
	telemovel <= 939999999 OR
	telemovel >= 960000000 OR
	telemovel <= 969999999
);

--check cartaoCidadao empregado

ALTER TABLE Empregado ADD CONSTRAINT ck_Empregado_cartaoCidadao CHECK(
	cartao_cidadao >= 100000000 OR
	cartao_cidadao <= 999999999
);


















-- 5 - Um supervisor é um funcionário da
-- empresa e só pode ser supervisor de tiver a mesma categoria e idade superior ao seu
-- supervisionado. 







-- 6 - No entanto, os motoristas apesar de
-- pertencerem a uma só zona geográfica podem efetuar o transporte de mercadorias
-- para as várias zonas geográficas desde que estas não distanciem da sua em mais de
-- 200 kms.  ?????????







-- 7 - tipo de cliente: Estes são ainda classificados por tipo, de acordo com o volume de
-- negócio que efetuam (por exemplo, VIP, grande cliente, pequeno cliente). - de acordo com o vol. de negocio
-- FALAR NO RELATORIO PQ O CLIENTE NAO TEM TIPO
-- https://pt.wikipedia.org/wiki/Normaliza%C3%A7%C3%A3o_de_dados#Terceira_Forma_Normal







-- 8 - Semanalmente, os clientes são visitados por vendedores da mesma zona geográfica,
-- os quais registam os artigos encomendados numa nota de encomenda, que
-- posteriormente enviam para o armazém da sua zona geográfica.






-- 9 -  Se algum artigo, de uma dada
-- encomenda, atingiu o stock mínimo a nota de encomenda é colocada como pendente. 
-- Tipos de estado que uma encomenda pode ter
-- : pendente
-- : a caminho (desse genero)
-- : entregue
-- : etc…

A primeira parte faz-se com triguer.

alter table NotaEncomenda add Constraint ck_NotaEncomenda_estado check(

	estado = 'pendente' or
	estado = 'a caminho' or
	estado = 'entregue' 
);







-- 10 - fazer um trigger para descer o stock do artigo quando ele é comprado









-- 11 - se quiser encomendar uma quantidade que faça o stock ficar abaixo do stock minimo, trigger NAO faz
-- e passa a encomenda para pendente







-- 12 - TIPOS DE VEICULO - A IsepBicolage
-- possui uma frota de veículos que são de um determinado tipo (2 eixos, 3 eixos, 4 eixos, etc.)

alter table Tipo ADD Constraint ck_numeroEixos_tipo check(

	numero_de_eixos = '2 eixos' or
	numero_de_eixos = '3 eixos' or
	numero_de_eixos = '4 eixos'

);






--13 - KM do veiculo e capacidade nao pode ser abaixo de zero

ALTER TABLE Veiculo ADD CONSTRAINT ck_veiculo_numero_kilometros CHECK(
  numero_kilometros >= 0
);









-- 14 - Na tabela das viagens, só pode existir a mesma matricula 4 vezes, na mesma semana (ir ver à data)








-- 15 - Numa viagem a mercadoria deverá ocupar toda ou quase toda a capacidade
-- do veículo
-- UMA VIAGEM, tem que ocupar mais de 90% da capaciade maxima do veiculo














-- 17 - Caso o tipo de incidente
-- seja um acidente de viação o veículo fica indisponível para uma nova entrega de
-- mercadoria.






-- 18 -Ao dia 15 de cada mês, todas as encomendas expedidas são faturadas ao cliente,
-- numa única fatura. ???????????????????????????????????













































