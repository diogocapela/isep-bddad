------------------------------------------------------------------------------------------------------
-- Criação da Base de Dados
------------------------------------------------------------------------------------------------------

DROP TABLE Fornecedor CASCADE CONSTRAINTS PURGE;
DROP TABLE Produto CASCADE CONSTRAINTS PURGE;
DROP TABLE FornecedorProduto CASCADE CONSTRAINTS PURGE;
DROP TABLE Armazem CASCADE CONSTRAINTS PURGE;
DROP TABLE ArmazemProduto CASCADE CONSTRAINTS PURGE;
DROP TABLE Empregado CASCADE CONSTRAINTS PURGE;
DROP TABLE OrdemCompra CASCADE CONSTRAINTS PURGE;
DROP TABLE OrdemCompraProduto CASCADE CONSTRAINTS PURGE;

-- Fornecedor

CREATE TABLE Fornecedor (
	cod_fornecedor INTEGER,
	nome VARCHAR(255),
	morada VARCHAR(255),
	nif NUMBER(9) UNIQUE,
	telefone NUMBER(9)
);

ALTER TABLE Fornecedor ADD CONSTRAINT Fornecedor_pk_cod_fornecedor PRIMARY KEY(cod_fornecedor);
ALTER TABLE Fornecedor add CONSTRAINT Fornecedor_chk_nif CHECK(nif >= 100000000);

-- Produto

CREATE TABLE Produto (
	cod_produto INTEGER,
	descricao VARCHAR(255),
	unidade_medida VARCHAR(255),
	preco NUMBER(*,2)
);

ALTER TABLE Produto ADD CONSTRAINT Produto_pk_cod_produto PRIMARY KEY(cod_produto);

-- Armazem

CREATE TABLE Armazem (
	cod_armazem INTEGER,
	nome VARCHAR(255),
	morada VARCHAR(255),
	cidade VARCHAR(255)
);

ALTER TABLE Armazem ADD CONSTRAINT Armazem_pk_cod_armazem PRIMARY KEY(cod_armazem);

-- Empregado

CREATE TABLE Empregado (
	cod_empregado INTEGER,
	cod_supervisor INTEGER,
	cod_armazem INTEGER,
	nome VARCHAR(255),
	morada VARCHAR(255),
	salario_semanal NUMBER(*,2),
	formacao VARCHAR(255)
);

ALTER TABLE Empregado ADD CONSTRAINT Empregado_pk_cod_empregado PRIMARY KEY(cod_empregado);
ALTER TABLE Empregado ADD CONSTRAINT Empregado_fk_cod_supervisor FOREIGN KEY(cod_supervisor) REFERENCES Empregado(cod_empregado); -- ref ao mesmo
ALTER TABLE Empregado ADD CONSTRAINT Empregado_fk_cod_armazem FOREIGN KEY(cod_armazem) REFERENCES Armazem(cod_armazem);

-- OrdemCompra

CREATE TABLE OrdemCompra (
	nr_ordem INTEGER,
	cod_fornecedor INTEGER,
	cod_empregado INTEGER,
	data_compra DATE,
	valor_total NUMBER(*,2),
	data_entrega DATE,
	estado INTEGER
);

ALTER TABLE OrdemCompra ADD CONSTRAINT OrdemCompra_pk_nr_ordem PRIMARY KEY(nr_ordem);
ALTER TABLE OrdemCompra ADD CONSTRAINT OrdemCompra_fk_cod_fornecedor FOREIGN KEY(cod_fornecedor) REFERENCES Fornecedor(cod_fornecedor);
ALTER TABLE OrdemCompra ADD CONSTRAINT OrdemCompra_fk_cod_empregado FOREIGN KEY(cod_empregado) REFERENCES Empregado(cod_empregado);

-- OrdemCompraProduto

CREATE TABLE OrdemCompraProduto (
	linha VARCHAR(255),
	nr_ordem INTEGER,
	cod_produto INTEGER,
	quantidade_solicitada INTEGER,
	desconto_pedido NUMBER(*,2)
);

ALTER TABLE OrdemCompraProduto ADD CONSTRAINT OrdemCompraProduto_pk_linha PRIMARY KEY(linha);
ALTER TABLE OrdemCompraProduto ADD CONSTRAINT OrdemCompra_fk_nr_ordem FOREIGN KEY(nr_ordem) REFERENCES OrdemCompra(nr_ordem);
ALTER TABLE OrdemCompraProduto ADD CONSTRAINT OrdemCompra_fk_cod_produto FOREIGN KEY(cod_produto) REFERENCES Produto(cod_produto);

-- FornecedorProduto

CREATE TABLE FornecedorProduto (
	cod_fornecedor INTEGER,
	cod_produto INTEGER,
	preco_venda NUMBER(*,2),
	desconto NUMBER(*,2)
);

ALTER TABLE FornecedorProduto ADD CONSTRAINT FornecedorProduto_fk_cod_fornecedor FOREIGN KEY(cod_fornecedor) REFERENCES Fornecedor(cod_fornecedor);
ALTER TABLE FornecedorProduto ADD CONSTRAINT FornecedorProduto_fk_cod_produto FOREIGN KEY(cod_produto) REFERENCES Produto(cod_produto);

-- ArmazemProduto

CREATE TABLE ArmazemProduto (
	cod_armazem INTEGER,
	cod_produto INTEGER,
	stock INTEGER,
	stock_minimo INTEGER,
	corredor VARCHAR(255),
	prateleira VARCHAR(255)
);

ALTER TABLE ArmazemProduto ADD CONSTRAINT ArmazemProduto_fk_cod_armazem FOREIGN KEY(cod_armazem) REFERENCES Armazem(cod_armazem);
ALTER TABLE ArmazemProduto ADD CONSTRAINT ArmazemProduto_fk_cod_produto FOREIGN KEY(cod_produto) REFERENCES Produto(cod_produto);
