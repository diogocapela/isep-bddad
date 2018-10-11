--eliminar tabelas (eventualmente) existentes

DROP TABLE cd CASCADE CONSTRAINTS PURGE ;
DROP TABLE musicas CASCADE CONSTRAINTS PURGE ;
DROP TABLE editoras CASCADE CONSTRAINTS PURGE ;

--criar tabelas

CREATE TABLE editoras (
    id_editora  INTEGER     CONSTRAINT pk_editoras_id_iditora PRIMARY KEY,
    nome        VARCHAR(20) CONSTRAINT nn_editoras_nome NOT NULL 
);

CREATE TABLE cd (
    cod_cd          INTEGER     CONSTRAINT pk_cd_cod PRIMARY KEY,
    id_editora      INTEGER     CONSTRAINT fk_cd_id_editora REFERENCES editoras(id_editora),
    titulo          VARCHAR(40) CONSTRAINT nn_cd_titulo NOT NULL,
    data_compra     DATE,
    valor_pago      NUMERIC(5,2),
    local_compra    VARCHAR(20)
);

CREATE TABLE musicas (
    nr_musica   INTEGER,
    cod_cd      INTEGER,
    titulo      VARCHAR(40) CONSTRAINT nn_musicas_titulo NOT NULL,
    interprete  VARCHAR(30) CONSTRAINT nn_musicas_interprete NOT NULL,
    duracao     NUMERIC(5,2),

    CONSTRAINT pk_musicas_nr_musica_cod_cd  PRIMARY KEY (cod_cd, nr_musica),
    CONSTRAINT fk_musicas_cod_cd FOREIGN KEY (cod_cd) REFERENCES cd(cod_cd)
);

--preencher tabelas

INSERT INTO editoras VALUES (1, 'BMG');
INSERT INTO editoras VALUES (2, '4AD');
INSERT INTO editoras VALUES (3, 'Polydor');
INSERT INTO editoras VALUES (4, 'Universal Music');
INSERT INTO editoras VALUES (5, 'Warner Music');
INSERT INTO editoras VALUES (6, 'Island Records');
INSERT INTO editoras VALUES (7, 'Parlaphone');
INSERT INTO editoras VALUES (8, 'ADF');
INSERT INTO editoras VALUES (9, 'Valentim de Carvalho');

INSERT INTO cd VALUES (1, 8, 'Punkzilla', TO_DATE('22/Abril/2011','DD/MON/YY'), 55.00 , 'FNAC');
INSERT INTO cd VALUES (2, 1, 'Classic Duets', TO_DATE('21/Maio/2017','DD/MON/YY'), 30.50, 'Worten');
INSERT INTO cd VALUES (3, 7, 'The Wall', TO_DATE('22/Abril/2011','DD/MON/YY'), 25.80, 'FNAC');
INSERT INTO cd VALUES (4, 1, 'Hits 4', TO_DATE('10/Setembro/2017','DD/MON/YY'), 42.30, 'Worten');
INSERT INTO cd VALUES (5, 6, 'Songs of Experience', TO_DATE('1/Janeiro/2018','DD/MON/YY'), 10.99, NULL);
INSERT INTO cd VALUES (6, 5, 'Giesta 2', TO_DATE('15/Junho/2017','DD/MON/YY'), 9.10, NULL);
INSERT INTO cd VALUES (7, 4, 'O Mundo ao Contrário', TO_DATE('01/Janeiro/2004','DD/MON/YY'), 12.90, 'FNAC');
INSERT INTO cd VALUES (8, 3, 'Born to Die', TO_DATE('27/Janeiro/2012','DD/MON/YY'), 9.90, 'iTunes');

INSERT INTO musicas VALUES (1, 1, 'Dream of Waking', 'AFI', 3.05);
INSERT INTO musicas VALUES (2, 1, 'Still', 'Rufio', 3.02);
INSERT INTO musicas VALUES (3, 1, 'Behind the Music', 'The Vandals', 2.41);
INSERT INTO musicas VALUES (4, 1, 'Why Are You Alive', 'The Vandals', 2.34);
INSERT INTO musicas VALUES (5, 1, 'Vandals', 'The Vandals', 4.01);
INSERT INTO musicas VALUES (6, 1, 'Days of the Phoenix', 'AFI', 3.28);
INSERT INTO musicas VALUES (7, 1, 'Wester', 'AFI', 3.02);
INSERT INTO musicas VALUES (8, 1, 'Blue Jeans', 'Lana Del Rey', 3.29);

INSERT INTO musicas VALUES (1, 2, 'Bizet: Les pécheurs de perles...', 'Orquestra Filarmónica Real', 5.24);
INSERT INTO musicas VALUES (2, 2, 'Verdi: Otello/Act 2', 'Orquestra Sinfónica Chicago', 6.47);
INSERT INTO musicas VALUES (3, 2, 'Verdi: Aida/Act 4', 'Loring Maazel', 4.38);
INSERT INTO musicas VALUES (4, 2, 'Puccini: Turandot', 'Zubin Mehta', 3.08);

INSERT INTO musicas VALUES (1, 3, 'In the Flesh', 'Pink Floyd', 3.02);
INSERT INTO musicas VALUES (2, 3, 'The Thin Lee', 'Pink Floyd', 2.30);
INSERT INTO musicas VALUES (3, 3, 'Mother', 'Pink Floyd', 5.34);
INSERT INTO musicas VALUES (4, 3, 'Don''t Leave Me Now', 'Pink Floyd', 4.21);
INSERT INTO musicas VALUES (5, 3, 'Young Lust', 'Pink Floyd', 3.19);

INSERT INTO musicas VALUES (1, 4, 'It''s Alright(Baby''s Coming Back)', 'Eurythmics', 3.05);
INSERT INTO musicas VALUES (2, 4, 'Hounds of Love' , 'Kate Bush', 3.02);
INSERT INTO musicas VALUES (3, 4, 'Calling America', 'Electric Light Orchestra', 2.41);
INSERT INTO musicas VALUES (4, 4, 'Suspicious Minds', 'Fine Young Cannibals', 2.34);
INSERT INTO musicas VALUES (5, 4, 'I''m Your Man', 'Wham!', 3.28);
INSERT INTO musicas VALUES (6, 4, 'Blue Jeans', 'Lana Del Rey', 3.29);

INSERT INTO musicas VALUES (1, 5, 'Love is All We Have Left', 'U2', 2.41);
INSERT INTO musicas VALUES (2, 5, 'Lights of Home' , 'U2', 4.16);
INSERT INTO musicas VALUES (3, 5, 'You''re the Best Thing About Me', 'U2', 3.45);
INSERT INTO musicas VALUES (4, 5, 'Get Out of Your Own Way', 'U2', 3.58);
INSERT INTO musicas VALUES (5, 5, 'American Soul', 'U2', 4.21);
INSERT INTO musicas VALUES (6, 5, 'Summer of Love', 'U2', 3.24);
INSERT INTO musicas VALUES (7, 5, 'Red Flag Day', 'U2', 3.19);
INSERT INTO musicas VALUES (8, 5, 'The Showman', 'U2', 3.23);

INSERT INTO musicas VALUES (1, 6, 'Valsa em Espiral', 'Miguel Araújo', 3.34);
INSERT INTO musicas VALUES (2, 6, '1987' , 'Miguel Araújo', 4.12);
INSERT INTO musicas VALUES (3, 6, 'Meio Conto', 'Miguel Araújo', 3.13);
INSERT INTO musicas VALUES (4, 6, 'Via Norte', 'Miguel Araújo', 3.35);
INSERT INTO musicas VALUES (5, 6, 'Sangemil', 'Miguel Araújo', 4.03);
INSERT INTO musicas VALUES (6, 6, 'Lurdes Valsa Lenta', 'Miguel Araújo', 4.41);
INSERT INTO musicas VALUES (7, 6, 'Axl Rose', 'Miguel Araújo', 5.03);
INSERT INTO musicas VALUES (8, 6, '20% Mais', 'Miguel Araújo', 1.20);
INSERT INTO musicas VALUES (9, 6, 'Vândalo', 'Miguel Araújo', 4.45);
INSERT INTO musicas VALUES (10, 6, 'Aqui Dali', 'Miguel Araújo', 4.45);

INSERT INTO musicas VALUES (1, 7, 'Desejo', 'Xutos e Pontapés', 3.25);
INSERT INTO musicas VALUES (2, 7, 'Diz-me' , 'Xutos e Pontapés', 4.37);
INSERT INTO musicas VALUES (3, 7, 'Ai Se Ele Cai', 'Xutos e Pontapés', 3.12);
INSERT INTO musicas VALUES (4, 7, 'Pequeno Pormenor', 'Xutos e Pontapés', 2.58);
INSERT INTO musicas VALUES (5, 7, 'Zona Limite', 'Xutos e Pontapés', 3.27);
INSERT INTO musicas VALUES (6, 7, 'Fim de Semana', 'Xutos e Pontapés', 5.27);
INSERT INTO musicas VALUES (7, 7, 'Gota a Gota', 'Xutos e Pontapés', 2.35);
INSERT INTO musicas VALUES (8, 7, 'Teimosia', 'Xutos e Pontapés', 4.13);
INSERT INTO musicas VALUES (9, 7, 'O Mundo ao Contrário', 'Xutos e Pontapés', 4.18);
INSERT INTO musicas VALUES (10, 7, 'Sombra Colorida', 'Xutos e Pontapés', 2.38);

INSERT INTO musicas VALUES (1, 8, 'Born to Die', 'Lana Del Rey', 4.46);
INSERT INTO musicas VALUES (2, 8, 'Off the Races' , 'Lana Del Rey', 4.59);
INSERT INTO musicas VALUES (3, 8, 'Blue Jeans', 'Lana Del Rey', 3.29);
INSERT INTO musicas VALUES (4, 8, 'Video Games', 'Lana Del Rey', 4.41);
INSERT INTO musicas VALUES (5, 8, 'Diet Mountain Dew', 'Lana Del Rey', 3.42);
INSERT INTO musicas VALUES (6, 8, 'National Anthen', 'Lana Del Rey', 3.50);
INSERT INTO musicas VALUES (7, 8, 'Dark Paradise', 'Lana Del Rey', 4.03);
INSERT INTO musicas VALUES (8, 8, 'Radio', 'Lana Del Rey', 3.34);
INSERT INTO musicas VALUES (9, 8, 'Carmen', 'Lana Del Rey', 4.08);
INSERT INTO musicas VALUES (10, 8, 'Million Dollar Man', 'Lana Del Rey', 3.50);
INSERT INTO musicas VALUES (11, 8, 'Summertime Sadness', 'Lana Del Rey', 4.24);
INSERT INTO musicas VALUES (12, 8, 'This Is What Make Us Girls', 'Lana Del Rey', 4.00);






-- 1) Mostrar, numa coluna, o título de cada CD e de cada uma das músicas;

select titulo from cd
union
select titulo from musicas

-- 2) Copiar e alterar o comando da alínea anterior, de modo a não mostrar os registos repetidos;

select distinct(titulo) from cd
union
select distinct(titulo) from musicas

-- 3) Copiar e alterar o comando da alínea anterior, de modo a apresentar também o comprimento de cada título e por ordem decrescente;

select distinct(titulo), 







































































