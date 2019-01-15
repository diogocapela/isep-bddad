-- tabelas
drop table ArmazemProduto;
drop table Produto;
drop table Armazem;
create table Produto(cod_produto integer primary key);
create table Armazem(cod_armazem integer primary key);
create table ArmazemProduto(
cod_armazem integer,
cod_produto integer,
stock integer default 0 not null,
stock_minimo integer default 0 not null,
corredor varchar(10),
prateleira varchar(10),
constraint pk_ArmazemProduto primary key(cod_armazem, cod_produto),
constraint fk_ArmazemProduto_Armazem foreign key (cod_armazem)
references Armazem(cod_armazem),
constraint fk_ArmazemProduto_Produto foreign key (cod_produto)
references Produto(cod_produto)
);
-- dados para teste
insert into Armazem values(1);
insert into Armazem values(2);
insert into Armazem values(3);
insert into Armazem values(4);
insert into Armazem values(5);
insert into Produto values(1);
insert into Produto values(2);
insert into Produto values(3);
insert into Produto values(4);
insert into Produto values(5);
insert into Produto values(6);
insert into Produto values(7);
insert into Produto values(8);
insert into ArmazemProduto values(1, 1, 10, 5, 'A23', '2A');
insert into ArmazemProduto values(1, 2, 18, 10, 'A81', '1S');
insert into ArmazemProduto values(1, 3, 8, 1, 'A23', '1W');
insert into ArmazemProduto values(1, 4, 121, 50, 'A81', '2A');
insert into ArmazemProduto values(1, 5, 60, 5, 'A23', '2S');
insert into ArmazemProduto values(1, 6, 154, 10, 'A23', '2B');
insert into ArmazemProduto values(1, 7, 25, 20, 'A23', '2C');
insert into ArmazemProduto values(1, 8, 113, 10, 'A23', '2S');
insert into ArmazemProduto values(2, 2, 26, 5, '2B98', '22EW');
insert into ArmazemProduto values(2, 4, 87, 10, '2B12', '22B2');
insert into ArmazemProduto values(3, 3, 44, 12, '3B15', '32B3');
insert into ArmazemProduto values(3, 1, 110, 5, '3C13', '42B2');
insert into ArmazemProduto values(4, 7, 120, 10, '4C65', '42NW');
insert into ArmazemProduto values(4, 6, 90, 5, '4B35', '42SS');