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

INSERT INTO automoveis VALUES('45-PD-98', 'Mercedes', 2300, 2000, 34050);
INSERT INTO automoveis VALUES('65-87-GR', 'Nissan', 1700, 2009, 23490.5);
INSERT INTO automoveis VALUES('42-90-AS', 'Kia', 1300, 2008, 20870);
INSERT INTO automoveis VALUES('BL-87-23', 'Volkswagen', 1100, 2017, 15600.75);
INSERT INTO automoveis VALUES('83-QD-27', 'BMW', 2100, 2014, 35600);
INSERT INTO automoveis VALUES('XO-65-98', 'Toyota', 2100, 2010, 15940);

INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Sérgio Conceição', 987345, 105098124, '1974-11-15');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('António Oliveira', 937587, 104052455, '1952-10-06');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Fernando Santos', NULL, 102000906, '1954-10-10');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Artur Jorge', 7098428, 100829087, '1946-02-13');
INSERT INTO clientes(nome, nr_identificacao_civil, nif, data_nascimento) VALUES('Jesualdo Ferreira', NULL, 107559969, '1946-05-24');

INSERT INTO automoveis_clientes VALUES('65-87-GR', 1);
INSERT INTO automoveis_clientes VALUES('83-QD-27', 4);
INSERT INTO automoveis_clientes VALUES('42-90-AS', 2);
INSERT INTO automoveis_clientes VALUES('45-PD-98', 4);
INSERT INTO automoveis_clientes VALUES('XO-65-98', 5);
INSERT INTO automoveis_clientes VALUES('BL-87-23', 3);

INSERT INTO revisoes VALUES('65-87-GR', TIMESTAMP '2018-10-04 09:00:00', 'N');
INSERT INTO revisoes VALUES('83-QD-27', TIMESTAMP '2018-11-04 14:45:00', 'N');
INSERT INTO revisoes VALUES('42-90-AS', TIMESTAMP '2018-10-23 10:50:00', 'N');
INSERT INTO revisoes VALUES('XO-65-98', TIMESTAMP '2018-12-01 18:30:00', 'N');
INSERT INTO revisoes VALUES('65-87-GR', TIMESTAMP '2015-06-07 10:50:00', 'S');
INSERT INTO revisoes VALUES('XO-65-98', TIMESTAMP '2016-11-22 12:20:00', 's');