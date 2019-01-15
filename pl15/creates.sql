DROP TABLE clientes                 CASCADE CONSTRAINTS PURGE;
DROP TABLE codigos_postais          CASCADE CONSTRAINTS PURGE;
DROP TABLE cartoes_clientes         CASCADE CONSTRAINTS PURGE;
DROP TABLE vendas                   CASCADE CONSTRAINTS PURGE;
DROP TABLE livros                   CASCADE CONSTRAINTS PURGE;
DROP TABLE categorias               CASCADE CONSTRAINTS PURGE;
DROP TABLE edicoes_livros           CASCADE CONSTRAINTS PURGE;
DROP TABLE idiomas                  CASCADE CONSTRAINTS PURGE;
DROP TABLE autores                  CASCADE CONSTRAINTS PURGE;
DROP TABLE autores_edicoes_livros   CASCADE CONSTRAINTS PURGE;
DROP TABLE nacionalidades_autores   CASCADE CONSTRAINTS PURGE;
DROP TABLE paises                   CASCADE CONSTRAINTS PURGE;
DROP TABLE editoras                 CASCADE CONSTRAINTS PURGE;
DROP TABLE precos_edicoes_livros    CASCADE CONSTRAINTS PURGE;

--criar tabelas

CREATE TABLE clientes (
    nif_cliente     NUMERIC(9)  CONSTRAINT pk_clientes_nif_cliente PRIMARY KEY,
    cod_postal      CHAR(8)     CONSTRAINT nn_clientes_cod_postal NOT NULL,    
    nome            VARCHAR(60) CONSTRAINT nn_clientes_nome NOT NULL,
    data_nascimento DATE,
    morada          VARCHAR(50) CONSTRAINT nn_clientes_morada NOT NULL,
    nr_telemovel    NUMERIC(9)  CONSTRAINT ck_clientes_nr_telemovel CHECK(REGEXP_LIKE(nr_telemovel, '^\d{9}$'))
);

CREATE TABLE codigos_postais (
    cod_postal CHAR(8)      CONSTRAINT pk_codigos_postais_cod_postal PRIMARY KEY,
    localidade VARCHAR(25)  CONSTRAINT nn_codigos_postais_localidade NOT NULL,
    CONSTRAINT ck_codigos_postais_cod_postal CHECK(REGEXP_LIKE(cod_postal, '^\d{4}-\d{3}$'))
);

CREATE TABLE cartoes_clientes (
    nr_cartao       INTEGER         CONSTRAINT pk_cartoes_clientes_nr_cartao PRIMARY KEY,
    nif_cliente     NUMERIC(9)      CONSTRAINT nn_cartoes_clientes_nif NOT NULL
                                    CONSTRAINT ck_cartoes_clientes_nif CHECK(REGEXP_LIKE(nif_cliente, '^\d{9}$'))
                                    CONSTRAINT uk_cartoes_clientes UNIQUE,
    data_adesao     DATE            CONSTRAINT nn_cartoes_clientes_data_adesao NOT NULL,
    saldo_atual     NUMERIC(5,2)    CONSTRAINT ck_cartoes_clientes_saldo_atual CHECK(saldo_atual>=0),
    saldo_acumulado NUMERIC(10,2)   CONSTRAINT ck_cartoes_clientes_saldo_acumulado CHECK(saldo_acumulado>=0)
);

CREATE TABLE vendas (
    nr_venda    INTEGER     CONSTRAINT pk_vendas_nr_venda PRIMARY KEY,
    nif_cliente INTEGER     CONSTRAINT nn_vendas_nif_cliente NOT NULL,
    isbn        CHAR(14)    CONSTRAINT nn_vendas_isbn NOT NULL,
    data_hora   DATE        CONSTRAINT nn_vendas_data_hora NOT NULL,
    quantidade  INTEGER     CONSTRAINT nn_vendas_quantidade NOT NULL
);

CREATE TABLE livros (
    id_livro        INTEGER     CONSTRAINT pk_livros_id_livro PRIMARY KEY,
    id_categoria    INTEGER     CONSTRAINT nn_livros_id_categoria NOT NULL,
    titulo          VARCHAR(50) CONSTRAINT nn_livros_titulo NOT NULL
);

CREATE TABLE categorias (
    id_categoria    INTEGER     CONSTRAINT pk_categorias_id_categoria PRIMARY KEY,
    designacao      VARCHAR(20) CONSTRAINT nn_categorias_designacao NOT NULL
);

CREATE TABLE edicoes_livros (
    isbn            CHAR(14)    CONSTRAINT pk_edicoes_livros_isbn PRIMARY KEY,
    id_livro        INTEGER     CONSTRAINT nn_edicoes_livros_id_livro NOT NULL,
    id_editora      INTEGER     CONSTRAINT nn_edicoes_livros_id_editora NOT NULL,
    nr_edicao       INTEGER     CONSTRAINT nn_edicoes_livros_nr_edicao NOT NULL
                                CONSTRAINT ck_edicoes_livros_nr_edicao CHECK(nr_edicao>0),
    cod_idioma      CHAR(2)     CONSTRAINT nn_edicoes_livros_cod_idioma NOT NULL,
    mes_edicao      NUMERIC(2)  CONSTRAINT nn_edicoes_livros_mes_edicao NOT NULL
                                CONSTRAINT ck_edicoes_livros_mes_edicao CHECK(mes_edicao BETWEEN 1 AND 12),
    ano_edicao      NUMERIC(4)  CONSTRAINT nn_edicoes_livros_ano_edicao NOT NULL,
    stock_min       INTEGER DEFAULT 10 CONSTRAINT nn_edicoes_livros_stock_min NOT NULL
                                       CONSTRAINT ck_edicoes_livros_stock_min CHECK(stock_min>=0),
    stock           INTEGER            CONSTRAINT nn_edicoes_livros_stock NOT NULL
                                       CONSTRAINT ck_edicoes_livros_stock CHECK(stock>=0),
    CONSTRAINT ck_edicoes_livros_isbn CHECK(REGEXP_LIKE(isbn, '^\d{3}-\d{10}$'))
);

CREATE TABLE idiomas (
    cod_idioma   CHAR(2)        CONSTRAINT pk_idiomas_cod_idioma PRIMARY KEY,
    designacao   VARCHAR(20)    CONSTRAINT nn_idiomas_designacao NOT NULL
);   

CREATE TABLE autores (
    id_autor   INTEGER       CONSTRAINT pk_autores_id_autor PRIMARY KEY,
    nome       VARCHAR(35)   CONSTRAINT nn_autores_nome NOT NULL
);

CREATE TABLE autores_edicoes_livros (
    isbn        CHAR(14),
    id_autor    INTEGER,
    CONSTRAINT pk_autores_edicoes_livros_isbn_id_autor PRIMARY KEY (isbn, id_autor)
);

CREATE TABLE nacionalidades_autores (
    id_autor    INTEGER,
    cod_pais    CHAR(2),
    CONSTRAINT pk_nacionalidades_autores_id_autor_cod_pais PRIMARY KEY(id_autor,cod_pais)
);

CREATE TABLE paises (
    cod_pais    CHAR(2)     CONSTRAINT pk_paises_cod_pais PRIMARY KEY,
    nome        VARCHAR(30) CONSTRAINT nn_paises_nome NOT NULL
);

CREATE TABLE editoras ( 
    id_editora  INTEGER     CONSTRAINT pk_editoras_id_editora PRIMARY KEY,
    nome        VARCHAR(35) CONSTRAINT nn_editoras_nome NOT NULL,
    cod_pais    CHAR(2)     CONSTRAINT nn_editoras_cod_pais NOT NULL
);

CREATE TABLE precos_edicoes_livros (
    isbn        CHAR(14),
    data_inicio DATE            CONSTRAINT nn_precos_edicoes_livros_data_inicio NOT NULL,
    preco       NUMERIC(5,2)    CONSTRAINT nn_precos_edicoes_livros_preco NOT NULL
                                CONSTRAINT ck_precos_edicoes_livros_preco CHECK(preco>0),
    CONSTRAINT pk_precos_edicoes_livros_isbn_data_inicio PRIMARY KEY (isbn, data_inicio)
);

-- Chaves estrangeiras

ALTER TABLE clientes                ADD CONSTRAINT fk_clientes_cod_postal               FOREIGN KEY (cod_postal)        REFERENCES codigos_postais(cod_postal);
ALTER TABLE cartoes_clientes        ADD CONSTRAINT fk_cartoes_clientes_nif_cliente      FOREIGN KEY (nif_cliente)       REFERENCES clientes(nif_cliente);
ALTER TABLE vendas                  ADD CONSTRAINT fk_vendas_nif_cliente                FOREIGN KEY (nif_cliente)       REFERENCES clientes(nif_cliente);
ALTER TABLE vendas                  ADD CONSTRAINT fk_vendas_isbn                       FOREIGN KEY (isbn)              REFERENCES edicoes_livros(isbn);
ALTER TABLE livros                  ADD CONSTRAINT fk_livros_id_categoria               FOREIGN KEY (id_categoria)      REFERENCES categorias(id_categoria);
ALTER TABLE edicoes_livros          ADD CONSTRAINT fk_edicoes_livros_id_livro           FOREIGN KEY (id_livro)          REFERENCES livros(id_livro);
ALTER TABLE edicoes_livros          ADD CONSTRAINT fk_edicoes_livros_cod_idioma         FOREIGN KEY (cod_idioma)        REFERENCES idiomas(cod_idioma);
ALTER TABLE edicoes_livros          ADD CONSTRAINT fk_edicoes_livros_id_editora         FOREIGN KEY (id_editora)        REFERENCES editoras(id_editora);
ALTER TABLE autores_edicoes_livros  ADD CONSTRAINT fk_autores_edicoes_livros_isbn       FOREIGN KEY (isbn)              REFERENCES edicoes_livros(isbn);
ALTER TABLE autores_edicoes_livros  ADD CONSTRAINT fk_autores_edicoes_livros_id_autor   FOREIGN KEY (id_autor)          REFERENCES autores(id_autor);
ALTER TABLE nacionalidades_autores  ADD CONSTRAINT fk_nacionalidades_autores_id_autor   FOREIGN KEY (id_autor)          REFERENCES autores(id_autor);
ALTER TABLE nacionalidades_autores  ADD CONSTRAINT fk_nacionalidades_autores_cod_pais   FOREIGN KEY (cod_pais)          REFERENCES paises(cod_pais);
ALTER TABLE editoras                ADD CONSTRAINT fk_editoras_cod_pais                 FOREIGN KEY (cod_pais)          REFERENCES paises(cod_pais);
ALTER TABLE precos_edicoes_livros   ADD CONSTRAINT fk_precos_edicoes_livros_isbn        FOREIGN KEY (isbn)              REFERENCES edicoes_livros(isbn);

-- Preencher tabelas

INSERT INTO autores(id_autor, nome) VALUES (100, 'John');
INSERT INTO autores(id_autor, nome) VALUES (101, 'Sofia');
INSERT INTO autores(id_autor, nome) VALUES (102, 'Sócrates');
INSERT INTO autores(id_autor, nome) VALUES (103, 'Gabriel');
INSERT INTO autores(id_autor, nome) VALUES (104, 'Judite');
INSERT INTO autores(id_autor, nome) VALUES (105, 'Steven Feuerstein');
INSERT INTO autores(id_autor, nome) VALUES (106, 'Bill Pribyl');
INSERT INTO autores(id_autor, nome) VALUES (107, 'Luís Damas');
INSERT INTO autores(id_autor, nome) VALUES (108, 'Feliz Gouveia');
INSERT INTO autores(id_autor, nome) VALUES (109, 'Thomas Connolly');
INSERT INTO autores(id_autor, nome) VALUES (110, 'Carolyn Begg');
INSERT INTO autores(id_autor, nome) VALUES (111, 'Deborah Perry Piscione');

INSERT INTO categorias(id_categoria, designacao) VALUES (1, 'Economia');
INSERT INTO categorias(id_categoria, designacao) VALUES (2, 'Filosofia');
INSERT INTO categorias(id_categoria, designacao) VALUES (3, 'História');
INSERT INTO categorias(id_categoria, designacao) VALUES (4, 'Informática');

INSERT INTO codigos_postais(cod_postal, localidade) VALUES ('4200-197', 'Porto');
INSERT INTO codigos_postais(cod_postal, localidade) VALUES ('4460-393', 'Senhora da Hora');
INSERT INTO codigos_postais(cod_postal, localidade) VALUES ('4450-282', 'Matosinhos');
INSERT INTO codigos_postais(cod_postal, localidade) VALUES ('4420-601', 'Gondomar');
INSERT INTO codigos_postais(cod_postal, localidade) VALUES ('4445-273', 'Ermesinde');
INSERT INTO codigos_postais(cod_postal, localidade) VALUES ('4444-909', 'Valongo');
INSERT INTO codigos_postais(cod_postal, localidade) VALUES ('4500-527', 'Espinho');
INSERT INTO codigos_postais(cod_postal, localidade) VALUES ('4400-129', 'Vila Nova de Gaia');

INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800100, '4200-197', 'Jose',   TO_DATE('12-12-1975', 'DD-MM-YYYY'), 'Rua Constituição 1350',   '931234561');
INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800200, '4460-393', 'Maria',  TO_DATE('02-07-1980', 'DD-MM-YYYY'), 'Rua Mendonça 137',        '911223347');
INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800300, '4400-129', 'Rui',    TO_DATE('25-10-1961', 'DD-MM-YYYY'), 'Rua Sá Carneiro 12',      '961238976');
INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800400, '4444-909', 'Joana',  TO_DATE('31-03-1970', 'DD-MM-YYYY'), 'Rua da Liberdade 328',    '931239229');
INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800500, '4450-282', 'Ana',    TO_DATE('28-02-1950', 'DD-MM-YYYY'), 'Avenida Serpa Pinto 120', '931239987');
INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800600, '4420-601', 'Sofia',  TO_DATE('30-04-1955', 'DD-MM-YYYY'), 'Rua Sport Clube 500',     '911239546');
INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800700, '4445-273', 'João',   TO_DATE('11-05-1990', 'DD-MM-YYYY'), 'Rua Cidade Ermesinde 20', '931277755');
INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800800, '4444-909', 'Paulo',  TO_DATE('06-06-1978', 'DD-MM-YYYY'), 'Rua da Liberdade 400',    '961239711');
INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel) 
VALUES (900800900, '4500-527', 'Carlos', TO_DATE('31-03-1982', 'DD-MM-YYYY'), 'Rua de Carvalhelhos 22',  '922267857');

INSERT INTO cartoes_clientes(nr_cartao, nif_cliente, data_adesao, saldo_atual, saldo_acumulado) 
VALUES (1000, 900800100, TO_DATE('04-11-2000', 'DD-MM-YYYY'), 20, 200);
INSERT INTO cartoes_clientes(nr_cartao, nif_cliente, data_adesao, saldo_atual, saldo_acumulado) 
VALUES (1100, 900800900, TO_DATE('08-04-2010', 'DD-MM-YYYY'), 10, 10);

INSERT INTO paises(cod_pais, nome) VALUES ('DE','Alemanha');
INSERT INTO paises(cod_pais, nome) VALUES ('BR','Brasil');
INSERT INTO paises(cod_pais, nome) VALUES ('US','Estados Unidos da América');
INSERT INTO paises(cod_pais, nome) VALUES ('ES','Espanha');
INSERT INTO paises(cod_pais, nome) VALUES ('FR','França');
INSERT INTO paises(cod_pais, nome) VALUES ('PT','Portugal');
INSERT INTO paises(cod_pais, nome) VALUES ('GB','Reino Unido');
INSERT INTO paises(cod_pais, nome) VALUES ('GR','Grécia');

INSERT INTO nacionalidades_autores VALUES (100, 'US');
INSERT INTO nacionalidades_autores VALUES (101, 'PT');
INSERT INTO nacionalidades_autores VALUES (102, 'GR');
INSERT INTO nacionalidades_autores VALUES (103, 'BR');
INSERT INTO nacionalidades_autores VALUES (103, 'PT');
INSERT INTO nacionalidades_autores VALUES (104, 'PT');
INSERT INTO nacionalidades_autores VALUES (105, 'US');
INSERT INTO nacionalidades_autores VALUES (106, 'US');
INSERT INTO nacionalidades_autores VALUES (107, 'PT');
INSERT INTO nacionalidades_autores VALUES (108, 'PT');
INSERT INTO nacionalidades_autores VALUES (109, 'GB');
INSERT INTO nacionalidades_autores VALUES (110, 'GB');
INSERT INTO nacionalidades_autores VALUES (111, 'US');

INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (1400, 'Livros do Brasil', 'BR');
INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (1500, 'Bertrand', 'PT');
INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (1600, 'McGraw-Hill', 'US');
INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (1700, 'Prentice Hall', 'US');
INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (1800, 'O''Reilly', 'US');
INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (1900, 'FCA', 'PT');
INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (2000, 'Pearson', 'GB');
INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (2100, 'Addison-Wesley', 'US');
INSERT INTO editoras(id_editora, nome, cod_pais) VALUES (2200, 'St. Martin''s Griffin', 'US');

INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (200, 2, 'Ética');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (201, 1, 'Secrets of Silicon Valley');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (202, 1, 'Bitcoins');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (203, 4, 'Oracle PL/SQL Programming');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (204, 2, 'Existencialismo');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (205, 4, 'Database Systems');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (206, 2, 'Lógica');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (207, 1, 'Empreendedorismo');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (208, 4, 'Fundamentos de Bases de Dados');
INSERT INTO livros(id_livro, id_categoria, titulo) VALUES (209, 4, 'SQL');

INSERT INTO idiomas(cod_idioma, designacao) VALUES ('PT', 'Português');
INSERT INTO idiomas(cod_idioma, designacao) VALUES ('EN', 'Inglês');
INSERT INTO idiomas(cod_idioma, designacao) VALUES ('FR', 'Francês');
INSERT INTO idiomas(cod_idioma, designacao) VALUES ('ES', 'Espanhol');

INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1234567891', 200, 1500,  1, 'PT',  4, 2010,  2,  5);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('978-1137279170', 201, 2200,  1, 'EN',  8, 2014, 15, 18);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1211111191', 202, 1600,  1, 'EN',  2, 2017, 30, 40);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('978-1449777452', 203, 1800,  6, 'EN',  2, 2014, 10, 12);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1234447891', 204, 1500,  2, 'PT',  2, 1999, 20, 30);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1234222891', 205, 2000,  6, 'EN',  1, 2014, 10, 15);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1234666891', 206, 1500,  2, 'PT',  2, 2015, 20, 30);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1234567991', 207, 1500,  1, 'PT',  2, 2015, 10, 12);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1234555891', 200, 1500,  2, 'PT',  2, 2015, 10, 20);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1234533891', 207, 1500,  2, 'PT',  9, 2018, 20, 40);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1234522891', 205, 2100,  2, 'EN',  2, 1999, 10, 10);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('978-0596556464', 203, 1800,  3, 'EN', 10, 2009, 30, 31);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('978-0596003814', 203, 1800,  4, 'EN', 10, 2002, 10, 12);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('500-1277777891', 207, 1500,  3, 'PT',  2, 2015, 20, 30);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('978-9727227990', 208, 1900,  1, 'PT',  9, 2014, 10, 15);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('978-9727228394', 209, 1900, 14, 'PT',  6, 2017, 20, 25);
INSERT INTO edicoes_livros(isbn, id_livro, id_editora, nr_edicao, cod_idioma, mes_edicao, ano_edicao, stock_min, stock) 
VALUES ('978-9727224432', 209, 1900,  2, 'PT',  6, 2005,  5,  5);

INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234567891', 102);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234567891', 103);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-1137279170', 111);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1211111191', 101);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-1449777452', 105);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-1449777452', 106);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-0596556464', 105);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-0596003814', 105);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-0596003814', 106);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234447891', 102);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234222891', 109);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234222891', 110);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234522891', 109);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234522891', 110);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234666891', 104);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234567991', 103);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1234533891', 103);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('500-1277777891', 103);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-9727227990', 108);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-9727228394', 107);
INSERT INTO autores_edicoes_livros(isbn, id_autor) VALUES ('978-9727224432', 107);

INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 1, 900800100, '500-1234567891', TO_DATE('2016-02-02 15:30','YYYY-MM-DD HH24:MI'),  3);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 2, 900800200, '500-1234567891', TO_DATE('2016-03-02 11:20','YYYY-MM-DD HH24:MI'), 10);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 3, 900800100, '978-1137279170', TO_DATE('2016-12-02 22:45','YYYY-MM-DD HH24:MI'),  5);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 4, 900800300, '500-1234222891', TO_DATE('2018-02-02 21:10','YYYY-MM-DD HH24:MI'),  3);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 5, 900800300, '500-1234666891', TO_DATE('2018-02-12 23:35','YYYY-MM-DD HH24:MI'),  3);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 6, 900800100, '978-1137279170', TO_DATE('2017-02-02 09:12','YYYY-MM-DD HH24:MI'),  2);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 7, 900800100, '500-1277777891', TO_DATE('2017-02-02 12:05','YYYY-MM-DD HH24:MI'),  1);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 8, 900800200, '500-1234567891', TO_DATE('2016-04-02 10:00','YYYY-MM-DD HH24:MI'),  4);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES ( 9, 900800300, '500-1234567891', TO_DATE('2016-05-02 13:00','YYYY-MM-DD HH24:MI'),  5);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES (10, 900800200, '500-1234567891', TO_DATE('2016-10-02 12:00','YYYY-MM-DD HH24:MI'),  3);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES (11, 900800300, '500-1234222891', TO_DATE('2018-09-02 22:15','YYYY-MM-DD HH24:MI'),  2);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES (12, 900800300, '500-1234666891', TO_DATE('2018-07-12 23:30','YYYY-MM-DD HH24:MI'),  1);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES (13, 900800300, '500-1234567891', TO_DATE('2016-09-02 22:15','YYYY-MM-DD HH24:MI'),  2);
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade) 
VALUES (14, 900800300, '500-1234567891', TO_DATE('2016-07-12 23:30','YYYY-MM-DD HH24:MI'),  1);

INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234555891', TO_DATE('2015-12-10','YYYY-MM-DD'), 20.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234555891', TO_DATE('2017-04-15','YYYY-MM-DD'), 25.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234567891', TO_DATE('2012-01-01','YYYY-MM-DD'), 15.80);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234567891', TO_DATE('2014-01-01','YYYY-MM-DD'), 12.50);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234567891', TO_DATE('2016-01-01','YYYY-MM-DD'), 10.90);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-1137279170', TO_DATE('2014-10-01','YYYY-MM-DD'), 20.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-1137279170', TO_DATE('2016-12-01','YYYY-MM-DD'), 15.90);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1211111191', TO_DATE('2017-04-01','YYYY-MM-DD'), 15.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-1449777452', TO_DATE('2015-06-10','YYYY-MM-DD'), 60.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-1449777452', TO_DATE('2018-09-01','YYYY-MM-DD'), 70.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-0596556464', TO_DATE('2010-10-01','YYYY-MM-DD'), 60.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco)
VALUES ('978-0596556464', TO_DATE('2014-10-01','YYYY-MM-DD'), 50.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco)
VALUES ('978-0596003814', TO_DATE('2002-11-01','YYYY-MM-DD'), 50.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco)
VALUES ('978-0596003814', TO_DATE('2005-12-11','YYYY-MM-DD'), 40.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco)
VALUES ('500-1234666891', TO_DATE('2015-04-10','YYYY-MM-DD'), 30.50);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234447891', TO_DATE('2010-12-12','YYYY-MM-DD'), 25.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234222891', TO_DATE('2016-08-12','YYYY-MM-DD'), 25.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234522891', TO_DATE('2000-07-09','YYYY-MM-DD'), 15.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234567991', TO_DATE('2015-03-09','YYYY-MM-DD'), 20.50);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1234533891', TO_DATE('2018-10-09','YYYY-MM-DD'), 25.50);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('500-1277777891', TO_DATE('2016-12-19','YYYY-MM-DD'), 25.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-9727227990', TO_DATE('2015-05-08','YYYY-MM-DD'), 30.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-9727228394', TO_DATE('2017-07-07','YYYY-MM-DD'), 30.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-9727224432', TO_DATE('2005-10-10','YYYY-MM-DD'), 20.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-9727224432', TO_DATE('2010-10-10','YYYY-MM-DD'), 15.00);
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
VALUES ('978-9727224432', TO_DATE('2015-10-10','YYYY-MM-DD'), 12.50);