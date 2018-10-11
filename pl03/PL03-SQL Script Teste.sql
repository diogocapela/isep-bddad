--eliminar tabelas (eventualmente) existentes

DROP TABLE AUTOMOVEIS CASCADE CONSTRAINTS PURGE;
DROP TABLE AUTOMOVEIS_CLIENTES CASCADE CONSTRAINTS PURGE;
DROP TABLE CLIENTES CASCADE CONSTRAINTS PURGE;
DROP TABLE REVISOES CASCADE CONSTRAINTS PURGE;

--criar tabelas

CREATE TABLE automoveis (
    matricula       VARCHAR(20)   CONSTRAINT pk_automoveis_matricula PRIMARY KEY CHECK (REGEXP_LIKE (matricula, '([0-9]{2}-[A-Z]{2}-[0-9]{2})|([0-9]{2}-[0-9]{2}-[A-Z]{2})|([A-Z]{2}-[0-9]{2}-[0-9]{2})')),
    marca           VARCHAR(40) CONSTRAINT nn_automoveis_marca NOT NULL,
    cilindrada      INTEGER CONSTRAINT ck_automoveis_cilindrada CHECK (cilindrada BETWEEN 1000 AND 6000),
    ano_fabrico     INTEGER CONSTRAINT ck_automoveis_ano CHECK (ano_fabrico BETWEEN 2000 AND 2018),
    preco_venda     DECIMAL(10,2) CONSTRAINT ck_automoveis_preco CHECK (preco_venda >= 0)
);

CREATE TABLE clientes (
    id_cliente                  INTEGER GENERATED AS IDENTITY CONSTRAINT pk_clientes_id PRIMARY KEY CHECK (id_cliente > 0),
    nome                        VARCHAR(40) CONSTRAINT nn_clientes_nome NOT NULL,
    nr_identificacao_civil      INTEGER CONSTRAINT uk_clientes_nr_id_civil UNIQUE CONSTRAINT ck_clientes_nr_id_civil CHECK (nr_identificacao_civil > 99999),
    nif                         INTEGER CONSTRAINT uk_clientes_nif UNIQUE CONSTRAINT nn_clientes_nif NOT NULL CONSTRAINT ck_clientes_nif CHECK (nif > 99999999 AND nif <= 999999999),
    data_nascimento             DATE
);

CREATE TABLE revisoes (
    matricula                VARCHAR(20) CHECK (REGEXP_LIKE (matricula, '([0-9]{2}-[A-Z]{2}-[0-9]{2})|([0-9]{2}-[0-9]{2}-[A-Z]{2})|([A-Z]{2}-[0-9]{2}-[0-9]{2})')),
    data_hora_marcacao       TIMESTAMP CONSTRAINT pk_revisoes_data_hora PRIMARY KEY,
    efetuada                 CHAR(1) default 'N' CHECK (REGEXP_LIKE (efetuada, '[NnSs]{1}'))
);

CREATE TABLE automoveis_clientes (
    matricula        VARCHAR(20) CHECK (REGEXP_LIKE (matricula, '([0-9]{2}-[A-Z]{2}-[0-9]{2})|([0-9]{2}-[0-9]{2}-[A-Z]{2})|([A-Z]{2}-[0-9]{2}-[0-9]{2})')),
    id_cliente       INTEGER CHECK (id_cliente > 0)
);

ALTER TABLE revisoes ADD CONSTRAINT fk_revisoes_matricula FOREIGN KEY (matricula) REFERENCES automoveis(matricula);

ALTER TABLE automoveis_clientes ADD CONSTRAINT fk_automoveis_clientes_matricula FOREIGN KEY (matricula) REFERENCES automoveis(matricula);
ALTER TABLE automoveis_clientes ADD CONSTRAINT fk_automoveis_clientes_id_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

ALTER SESSION SET NLS_SORT=BINARY;


--preencher tabelas

INSERT INTO automoveis VALUES('45-9D-98', 'Mercedes', 2300, 2000, 34050);
INSERT INTO automoveis VALUES('65-87-GR', 'Nissan', 1700, 2009, 23490.5);
INSERT INTO automoveis VALUES('65-87-GR', 'Kia', 1300, 2008, 20870);
INSERT INTO automoveis VALUES(NULL, 'Volkswagen', 1100, 2017, 15600.75);
INSERT INTO automoveis VALUES('83-QD-27', NULL, 2100, 2014, 35600);
INSERT INTO automoveis VALUES('XO-65-98', 'Toyota', 6200, 2010, 15940);
INSERT INTO automoveis VALUES('45-AD-98', 'Mercedes', 2300, 1999, 34050);
INSERT INTO automoveis VALUES('43-BD-96', 'Daewoo', 2300, 2000, -33002);

INSERT INTO clientes VALUES(7, 'Sérgio Conceição', 987345, 105098124, '1974-11-15');
INSERT INTO clientes VALUES(NULL, 'António Oliveira', 937587, 104052455, '1952-10-06');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES(NULL, NULL, 102000906, '1954-10-10');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Artur Jorge', 7098428, 100829087, '1946-02-13');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Jesualdo Ferreira', 7098428, 107559969, '1946-05-24');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('José António', 12345, 107559969, '1947-02-21');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Maria Joaquina', 123456, 107559779, '1956-09-14');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Pedro Leandro', 2345667, 107559779, '1986-11-11');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Ana Filipa', 13749096, NULL, '1991-07-24');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Joana Raquel', 13749100, 10239779, '1946-05-24');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('João Luís', 146324, 219145721, '24-05-1946');

INSERT INTO automoveis_clientes VALUES('65-87-GR', 1);
INSERT INTO automoveis_clientes VALUES('65-87-GR', 1);
INSERT INTO automoveis_clientes VALUES(NULL, 2);
INSERT INTO automoveis_clientes VALUES('45-PD-98', NULL);
INSERT INTO automoveis_clientes VALUES('XO-65-98', 7);
INSERT INTO automoveis_clientes VALUES('BD-87-23', 3);

INSERT INTO revisoes VALUES('65-87-GR', TIMESTAMP '2018-10-04 09:00:00', 'N');
INSERT INTO revisoes VALUES('83-QD-27', TIMESTAMP '2018-10-04 09:00:00', 'N');
INSERT INTO revisoes VALUES('42-90-AS', NULL, 'N');
INSERT INTO revisoes VALUES('XD-65-98', TIMESTAMP '2018-12-01 18:30:00', 'N');
INSERT INTO revisoes VALUES('65-87-GR', TIMESTAMP '2015-06-07 10:50:00', 'Y');
INSERT INTO revisoes VALUES('XO-65-98', TIMESTAMP '2016-11-22 12:20:00', 'y');
INSERT INTO revisoes VALUES('XO-65-98', TIMESTAMP '2016-11-22 11:20:00', NULL)