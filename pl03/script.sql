DROP TABLE Automoveis CASCADE CONSTRAINTS PURGE;
DROP TABLE Clientes CASCADE CONSTRAINTS PURGE;
DROP TABLE Automoveis_Clientes CASCADE CONSTRAINTS PURGE;
DROP TABLE Revisoes CASCADE CONSTRAINTS PURGE;


CREATE TABLE Automoveis (
	matricula		CHAR(8)			CONSTRAINT pk_automoveis_matricula PRIMARY KEY NOT NULL,
	marca 			VARCHAR(255)	CONSTRAINT nn_automoveis_marca NOT NULL,
	cilindrada		INTEGER			CONSTRAINT nn_automoveis_cilindrada NOT NULL,
	ano_fabrico		INTEGER			CONSTRAINT nn_automoveis_ano_fabrico NOT NULL,
	preco_venda		NUMERIC			CONSTRAINT nn_automoveis_preco_venda NOT NULL
);

CREATE TABLE Clientes (
	id_cliente					INTEGER GENERATED AS IDENTITY	CONSTRAINT pk_clientes_id_cliente PRIMARY KEY,
	nome 						VARCHAR(255)	                CONSTRAINT nn_clientes_nome NOT NULL,
	nr_identificacao_civil 		INTEGER			                CONSTRAINT nn_clientes_nr_identificacao_civil NOT NULL,
	nif 						INTEGER			                CONSTRAINT nn_clientes_nif NOT NULL,
	data_nascimento 			VARCHAR(255)	                CONSTRAINT nn_clientes_data_nascimento NOT NULL
);

CREATE TABLE Automoveis_Clientes (
	matricula 	CHAR(8),
	id_cliente 	INTEGER,
	CONSTRAINT pk_automoveis_clientes_matricula_id_cliente PRIMARY KEY (matricula, id_cliente)
);

CREATE TABLE Revisoes (
	data_hora_marcacao	VARCHAR(255)	CONSTRAINT pk_revisoes_data_hora_marcacao PRIMARY KEY,
	matricula 			CHAR(8)			CONSTRAINT nn_revisoes_matricula NOT NULL,
	efectuada			INTEGER			CONSTRAINT nn_revisoes_efectuada NOT NULL
);






ALTER TABLE Automoveis ADD CONSTRAINT ck_automoveis_matricula CHECK(
	REGEXP_LIKE(matricula, '^[A-Z]{2}-[0-9]{2}-[0-9]{2}$') OR
	REGEXP_LIKE(matricula, '^[0-9]{2}-[A-Z]{2}-[0-9]{2}$') OR
	REGEXP_LIKE(matricula, '^[0-9]{2}-[0-9]{2}-[A-Z]{2}$')
);

ALTER TABLE Automoveis ADD CONSTRAINT ck_automoveis_cilindrada CHECK(
	cilindrada >= 1000 AND cilindrada <= 6000
);

ALTER TABLE Automoveis ADD CONSTRAINT ck_automoveis_ano_fabrico CHECK(
	ano_fabrico >= 2000 AND ano_fabrico <= 2018
);



ALTER TABLE Automoveis_Clientes ADD CONSTRAINT fk_automoveis_clientes_matricula FOREIGN KEY(matricula) REFERENCES Automoveis(matricula);
ALTER TABLE Automoveis_Clientes ADD CONSTRAINT fk_automoveis_clientes_id_cliente FOREIGN KEY(id_cliente) REFERENCES Clientes(id_cliente);

ALTER TABLE Revisoes ADD CONSTRAINT fk_revisoes_matricula FOREIGN KEY(matricula) REFERENCES Automoveis(matricula);



ALTER TABLE Clientes ADD CONSTRAINT uk_clientes_unicos UNIQUE(nr_identificacao_civil);


ALTER TABLE Clientes ADD CONSTRAINT ck_clientes_nr_identificacao_civil CHECK (
	nr_identificacao_civil > 0 AND
	REGEXP_LIKE(nr_identificacao_civil, '^[0-9]{6}$')
);


ALTER TABLE Revisoes MODIFY efectuada DEFAULT 'S';











