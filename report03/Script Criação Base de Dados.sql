


DROP TABLE Armazem CASCADE CONSTRAINTS;
DROP TABLE Armazem_Artigo CASCADE CONSTRAINTS;
DROP TABLE Artigo CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE CodigoPostal CASCADE CONSTRAINTS;
DROP TABLE Empregado CASCADE CONSTRAINTS;
DROP TABLE Etapa CASCADE CONSTRAINTS;
DROP TABLE Fatura CASCADE CONSTRAINTS;
DROP TABLE GuiaSaida CASCADE CONSTRAINTS;
DROP TABLE GuiaTransporte CASCADE CONSTRAINTS;
DROP TABLE Incidente CASCADE CONSTRAINTS;
DROP TABLE Marca CASCADE CONSTRAINTS;
DROP TABLE Modelo CASCADE CONSTRAINTS;
DROP TABLE NotaEncomenda CASCADE CONSTRAINTS;
DROP TABLE NotaEncomenda_Zona_Artigo CASCADE CONSTRAINTS;
DROP TABLE NotificacaoFimServico CASCADE CONSTRAINTS;
DROP TABLE Pagamento CASCADE CONSTRAINTS;
DROP TABLE PrecoArtigo CASCADE CONSTRAINTS;
DROP TABLE TipoCliente CASCADE CONSTRAINTS;
DROP TABLE TipoVeiculo CASCADE CONSTRAINTS;
DROP TABLE UnidadeRepresentacao CASCADE CONSTRAINTS;
DROP TABLE Veiculo CASCADE CONSTRAINTS;
DROP TABLE Viagem CASCADE CONSTRAINTS;
DROP TABLE Zona CASCADE CONSTRAINTS;
DROP TABLE Zona_Artigo CASCADE CONSTRAINTS;
DROP TABLE ZonaGeografica CASCADE CONSTRAINTS;




CREATE TABLE Armazem (
  cod_armazem         number(10) GENERATED AS IDENTITY, 
  cod_zona_geografica number(10) NOT NULL, 
  nome                varchar2(255) NOT NULL, 
  morada              varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_armazem));
CREATE TABLE Armazem_Artigo (
  cod_armazem             number(10) NOT NULL, 
  cod_artigo              number(10) NOT NULL, 
  quantidade_stock_minimo number(10) NOT NULL, 
  PRIMARY KEY (cod_armazem, 
  cod_artigo));
CREATE TABLE Artigo (
  cod_artigo number(10) GENERATED AS IDENTITY, 
  nome       varchar2(255) NOT NULL, 
  descricao  varchar2(255), 
  PRIMARY KEY (cod_artigo));
CREATE TABLE Cliente (
  cod_cliente           number(10) GENERATED AS IDENTITY, 
  cod_zona_geografica   number(10) NOT NULL, 
  cod_codigo_postal     varchar2(255) NOT NULL, 
  cod_tipo_cliente      number(10) NOT NULL, 
  nome                  varchar2(255) NOT NULL, 
  morada                varchar2(255) NOT NULL, 
  telemovel             number(9) NOT NULL, 
  nif                   number(9) NOT NULL UNIQUE, 
  data_ultima_alteracao date, 
  PRIMARY KEY (cod_cliente));
CREATE TABLE CodigoPostal (
  cod_codigo_postal varchar2(255) NOT NULL, 
  localidade        varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_codigo_postal));
CREATE TABLE Empregado (
  cod_empregado  number(10) GENERATED AS IDENTITY, 
  cod_supervisor number(10), 
  cod_armazem    number(10) NOT NULL, 
  tipo           nvarchar2(255) NOT NULL, 
  cartao_cidadao number(9) NOT NULL UNIQUE, 
  nome           varchar2(255) NOT NULL, 
  morada         varchar2(255) NOT NULL, 
  nif            number(9) NOT NULL UNIQUE, 
  salario_mensal number(10, 2) NOT NULL, 
  idade          number(3) NOT NULL, 
  PRIMARY KEY (cod_empregado));
CREATE TABLE Etapa (
  cod_etapa           number(10) GENERATED AS IDENTITY, 
  cod_viagem          number(10) NOT NULL, 
  cod_cliente_origem  number(10) NOT NULL, 
  cod_cliente_destino number(10) NOT NULL, 
  PRIMARY KEY (cod_etapa));
CREATE TABLE Fatura (
  cod_fatura    number(10) GENERATED AS IDENTITY, 
  cod_cliente   number(10) NOT NULL, 
  cod_empregado number(10) NOT NULL, 
  data_fatura   date NOT NULL, 
  estado        varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_fatura));
CREATE TABLE GuiaSaida (
  cod_guia_saida number(10) NOT NULL, 
  PRIMARY KEY (cod_guia_saida));
CREATE TABLE GuiaTransporte (
  cod_guia_transporte number(10) GENERATED AS IDENTITY, 
  cod_viagem          number(10) NOT NULL, 
  PRIMARY KEY (cod_guia_transporte));
CREATE TABLE Incidente (
  cod_incidente number(10) GENERATED AS IDENTITY, 
  tipo          varchar2(255) NOT NULL, 
  descricao     varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_incidente));
CREATE TABLE Marca (
  cod_marca  number(10) GENERATED AS IDENTITY, 
  nome_marca varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_marca));
CREATE TABLE Modelo (
  cod_modelo        number(10) GENERATED AS IDENTITY, 
  cod_marca         number(10) NOT NULL, 
  cod_tipo          number(10) NOT NULL, 
  nome_modelo       varchar2(255) NOT NULL, 
  capacidade_peso   number(10, 2) NOT NULL, 
  capacidade_volume number(10, 2) NOT NULL, 
  PRIMARY KEY (cod_modelo));
CREATE TABLE NotaEncomenda (
  cod_nota_encomenda  number(10) GENERATED AS IDENTITY, 
  cod_empregado       number(10) NOT NULL, 
  cod_cliente         number(10) NOT NULL, 
  cod_fatura          number(10), 
  cod_guia_transporte number(10), 
  data_nota_encomenda date NOT NULL, 
  estado              varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_nota_encomenda));
CREATE TABLE NotaEncomenda_Zona_Artigo (
  cod_nota_encomenda   number(10) NOT NULL, 
  cod_artigo           number(10) NOT NULL, 
  cod_zona             number(10) NOT NULL, 
  cod_guia_saida       number(10), 
  quantidade_encomenda number(10) NOT NULL, 
  iva                  number(10, 2) NOT NULL, 
  desconto             number(10, 2), 
  PRIMARY KEY (cod_nota_encomenda, 
  cod_artigo, 
  cod_zona));
CREATE TABLE NotificacaoFimServico (
  cod_viagem    number(10) NOT NULL, 
  cod_incidente number(10), 
  PRIMARY KEY (cod_viagem));
CREATE TABLE Pagamento (
  cod_pagamento  number(10) GENERATED AS IDENTITY, 
  cod_fatura     number(10) NOT NULL, 
  data_pagamento date NOT NULL, 
  quantia        number(10, 2) NOT NULL, 
  metodo         varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_pagamento));
CREATE TABLE PrecoArtigo (
  cod_artigo   number(10) NOT NULL, 
  data_inicio  date NOT NULL, 
  data_fim     date NOT NULL, 
  preco_venda  number(10, 2) NOT NULL, 
  preco_compra number(10, 2) NOT NULL, 
  PRIMARY KEY (cod_artigo, 
  data_inicio));
CREATE TABLE TipoCliente (
  cod_tipo_cliente number(10), 
  lim_min          number(10, 2) NOT NULL, 
  lim_max          number(10, 2), 
  tipo             varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_tipo_cliente));
CREATE TABLE TipoVeiculo (
  cod_tipo        number(10) GENERATED AS IDENTITY, 
  numero_de_eixos number(2) NOT NULL, 
  PRIMARY KEY (cod_tipo));
CREATE TABLE UnidadeRepresentacao (
  cod_artigo number(10) NOT NULL, 
  volume     number(10) NOT NULL, 
  peso       number(10) NOT NULL);
CREATE TABLE Veiculo (
  matricula             varchar2(255) NOT NULL, 
  cod_modelo            number(10) NOT NULL, 
  numero_apolice_seguro varchar2(255) NOT NULL, 
  numero_kilometros     number(10, 2) NOT NULL, 
  disponibilidade       char(255) NOT NULL, 
  PRIMARY KEY (matricula));
CREATE TABLE Viagem (
  cod_viagem                number(10) GENERATED AS IDENTITY, 
  cod_empregado             number(10) NOT NULL, 
  cod_armazem_origem        number(10) NOT NULL, 
  matricula                 varchar2(255) NOT NULL, 
  data_partida              date NOT NULL, 
  data_chegada              date NOT NULL, 
  capacidade_peso_ocupada   number(10, 2) NOT NULL, 
  capacidade_volume_ocupada number(10, 2) NOT NULL, 
  PRIMARY KEY (cod_viagem));
CREATE TABLE Zona (
  cod_zona    number(10) GENERATED AS IDENTITY, 
  cod_armazem number(10) NOT NULL, 
  capacidade  number(10) NOT NULL, 
  PRIMARY KEY (cod_zona));
CREATE TABLE Zona_Artigo (
  cod_artigo number(10) NOT NULL, 
  cod_zona   number(10) NOT NULL, 
  quantidade number(10) NOT NULL, 
  PRIMARY KEY (cod_artigo, 
  cod_zona));
CREATE TABLE ZonaGeografica (
  cod_zona_geografica           number(10) GENERATED AS IDENTITY, 
  coordenada_semi_major_axis_a  number(10, 4) NOT NULL, 
  coordenada_semi_major_axis_b  number(10, 4) NOT NULL, 
  coordenada_inverse_flattening number(10, 4) NOT NULL, 
  PRIMARY KEY (cod_zona_geografica));


ALTER TABLE Zona ADD CONSTRAINT FKZona299567 FOREIGN KEY (cod_armazem) REFERENCES Armazem (cod_armazem);
ALTER TABLE Zona_Artigo ADD CONSTRAINT FKZona_Artig925519 FOREIGN KEY (cod_artigo) REFERENCES Artigo (cod_artigo);
ALTER TABLE Zona_Artigo ADD CONSTRAINT FKZona_Artig624574 FOREIGN KEY (cod_zona) REFERENCES Zona (cod_zona);
ALTER TABLE Armazem_Artigo ADD CONSTRAINT FKArmazem_Ar546241 FOREIGN KEY (cod_armazem) REFERENCES Armazem (cod_armazem);
ALTER TABLE Armazem_Artigo ADD CONSTRAINT FKArmazem_Ar965924 FOREIGN KEY (cod_artigo) REFERENCES Artigo (cod_artigo);
ALTER TABLE PrecoArtigo ADD CONSTRAINT FKPrecoArtig60569 FOREIGN KEY (cod_artigo) REFERENCES Artigo (cod_artigo);
ALTER TABLE Empregado ADD CONSTRAINT FKEmpregado270397 FOREIGN KEY (cod_armazem) REFERENCES Armazem (cod_armazem);
ALTER TABLE Armazem ADD CONSTRAINT FKArmazem901526 FOREIGN KEY (cod_zona_geografica) REFERENCES ZonaGeografica (cod_zona_geografica);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente746533 FOREIGN KEY (cod_zona_geografica) REFERENCES ZonaGeografica (cod_zona_geografica);
ALTER TABLE NotaEncomenda ADD CONSTRAINT FKNotaEncome867331 FOREIGN KEY (cod_cliente) REFERENCES Cliente (cod_cliente);
ALTER TABLE NotaEncomenda_Zona_Artigo ADD CONSTRAINT FKNotaEncome509242 FOREIGN KEY (cod_nota_encomenda) REFERENCES NotaEncomenda (cod_nota_encomenda);
ALTER TABLE Viagem ADD CONSTRAINT FKViagem703870 FOREIGN KEY (matricula) REFERENCES Veiculo (matricula);
ALTER TABLE Viagem ADD CONSTRAINT FKViagem922866 FOREIGN KEY (cod_armazem_origem) REFERENCES Armazem (cod_armazem);
ALTER TABLE Etapa ADD CONSTRAINT FKEtapa603481 FOREIGN KEY (cod_viagem) REFERENCES Viagem (cod_viagem);
ALTER TABLE Etapa ADD CONSTRAINT FKEtapa879482 FOREIGN KEY (cod_cliente_origem) REFERENCES Cliente (cod_cliente);
ALTER TABLE NotificacaoFimServico ADD CONSTRAINT FKNotificaca249239 FOREIGN KEY (cod_viagem) REFERENCES Viagem (cod_viagem);
ALTER TABLE NotificacaoFimServico ADD CONSTRAINT FKNotificaca548387 FOREIGN KEY (cod_incidente) REFERENCES Incidente (cod_incidente);
ALTER TABLE Fatura ADD CONSTRAINT FKFatura77681 FOREIGN KEY (cod_cliente) REFERENCES Cliente (cod_cliente);
ALTER TABLE NotaEncomenda ADD CONSTRAINT FKNotaEncome46586 FOREIGN KEY (cod_fatura) REFERENCES Fatura (cod_fatura);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente676409 FOREIGN KEY (cod_codigo_postal) REFERENCES CodigoPostal (cod_codigo_postal);
ALTER TABLE NotaEncomenda_Zona_Artigo ADD CONSTRAINT FKNotaEncome556479 FOREIGN KEY (cod_artigo, cod_zona) REFERENCES Zona_Artigo (cod_artigo, cod_zona);
ALTER TABLE Modelo ADD CONSTRAINT FKModelo698288 FOREIGN KEY (cod_marca) REFERENCES Marca (cod_marca);
ALTER TABLE Veiculo ADD CONSTRAINT FKVeiculo712884 FOREIGN KEY (cod_modelo) REFERENCES Modelo (cod_modelo);
ALTER TABLE Pagamento ADD CONSTRAINT FKPagamento522534 FOREIGN KEY (cod_fatura) REFERENCES Fatura (cod_fatura);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente488635 FOREIGN KEY (cod_tipo_cliente) REFERENCES TipoCliente (cod_tipo_cliente);
ALTER TABLE Empregado ADD CONSTRAINT FKEmpregado984498 FOREIGN KEY (cod_supervisor) REFERENCES Empregado (cod_empregado);
ALTER TABLE Viagem ADD CONSTRAINT FKViagem915295 FOREIGN KEY (cod_empregado) REFERENCES Empregado (cod_empregado);
ALTER TABLE Fatura ADD CONSTRAINT FKFatura790470 FOREIGN KEY (cod_empregado) REFERENCES Empregado (cod_empregado);
ALTER TABLE NotaEncomenda ADD CONSTRAINT FKNotaEncome236107 FOREIGN KEY (cod_empregado) REFERENCES Empregado (cod_empregado);
ALTER TABLE UnidadeRepresentacao ADD CONSTRAINT FKUnidadeRep927216 FOREIGN KEY (cod_artigo) REFERENCES Artigo (cod_artigo);
ALTER TABLE NotaEncomenda ADD CONSTRAINT FKNotaEncome528765 FOREIGN KEY (cod_guia_transporte) REFERENCES GuiaTransporte (cod_guia_transporte);
ALTER TABLE GuiaTransporte ADD CONSTRAINT FKGuiaTransp783331 FOREIGN KEY (cod_viagem) REFERENCES Viagem (cod_viagem);
ALTER TABLE Etapa ADD CONSTRAINT FKEtapa133398 FOREIGN KEY (cod_cliente_destino) REFERENCES Cliente (cod_cliente);
ALTER TABLE Modelo ADD CONSTRAINT FKModelo738831 FOREIGN KEY (cod_tipo) REFERENCES TipoVeiculo (cod_tipo);
ALTER TABLE NotaEncomenda_Zona_Artigo ADD CONSTRAINT FKNotaEncome792319 FOREIGN KEY (cod_guia_saida) REFERENCES GuiaSaida (cod_guia_saida);



-- /////////////////////////////////////////////////////////
-- Incidente
-- /////////////////////////////////////////////////////////

insert into Incidente (tipo, descricao) values ('Vanellus chilensis', 'Diversified Electronic Products');
insert into Incidente (tipo, descricao) values ('Nyctereutes procyonoides', 'Real Estate Investment Trusts');
insert into Incidente (tipo, descricao) values ('Dusicyon thous', 'Building Materials');
insert into Incidente (tipo, descricao) values ('Spermophilus tridecemlineatus', 'n/a');
insert into Incidente (tipo, descricao) values ('Rhabdomys pumilio', 'Television Services');
insert into Incidente (tipo, descricao) values ('unavailable', 'Property-Casualty Insurers');
insert into Incidente (tipo, descricao) values ('Cordylus giganteus', 'Biotechnology: Laboratory Analytical Instruments');
insert into Incidente (tipo, descricao) values ('Dasyurus viverrinus', 'Broadcasting');
insert into Incidente (tipo, descricao) values ('Dacelo novaeguineae', 'Marine Transportation');
insert into Incidente (tipo, descricao) values ('Geochelone radiata', 'n/a');
insert into Incidente (tipo, descricao) values ('Bettongia penicillata', 'n/a');
insert into Incidente (tipo, descricao) values ('Crotalus adamanteus', 'Radio And Television Broadcasting And Communications Equipment');
insert into Incidente (tipo, descricao) values ('Felis rufus', 'Rental/Leasing Companies');
insert into Incidente (tipo, descricao) values ('Hyaena hyaena', 'Industrial Machinery/Components');
insert into Incidente (tipo, descricao) values ('Naja haje', 'Mining Quarrying of Nonmetallic Minerals (No Fuels)');
insert into Incidente (tipo, descricao) values ('Bubo sp.', 'Building Materials');
insert into Incidente (tipo, descricao) values ('Cracticus nigroagularis', 'n/a');
insert into Incidente (tipo, descricao) values ('Thylogale stigmatica', 'Mining Quarrying of Nonmetallic Minerals (No Fuels)');
insert into Incidente (tipo, descricao) values ('Lemur fulvus', 'Biotechnology: Biological Products (No Diagnostic Substances)');
insert into Incidente (tipo, descricao) values ('Larus fuliginosus', 'Property-Casualty Insurers');
insert into Incidente (tipo, descricao) values ('Cygnus buccinator', 'Business Services');
insert into Incidente (tipo, descricao) values ('Laniarius ferrugineus', 'n/a');
insert into Incidente (tipo, descricao) values ('Agkistrodon piscivorus', 'Major Banks');
insert into Incidente (tipo, descricao) values ('Lepus townsendii', 'Investment Bankers/Brokers/Service');
insert into Incidente (tipo, descricao) values ('Anas punctata', 'Containers/Packaging');

-- /////////////////////////////////////////////////////////
-- TipoCliente
-- /////////////////////////////////////////////////////////

insert into TipoCliente (cod_tipo_cliente,lim_min, lim_max, tipo) values (3,50001, null, 'VIP');
insert into TipoCliente (cod_tipo_cliente,lim_min, lim_max, tipo) values (2,30000, 50000, 'Grande Cliente');
insert into TipoCliente (cod_tipo_cliente,lim_min, lim_max, tipo) values (1,0, 29999, 'Pequeno Cliente');

-- /////////////////////////////////////////////////////////
-- Marca
-- /////////////////////////////////////////////////////////

insert into Marca (nome_marca) values ('Entelea');
insert into Marca (nome_marca) values ('Broom Dalea');
insert into Marca (nome_marca) values ('Thread Linanthus');
insert into Marca (nome_marca) values ('Young''s Snowbell');
insert into Marca (nome_marca) values ('Island Ceanothus');
insert into Marca (nome_marca) values ('Scott''s Clematis');
insert into Marca (nome_marca) values ('Lost Hills Saltbush');
insert into Marca (nome_marca) values ('Plains Snakecotton');
insert into Marca (nome_marca) values ('Fountainbush');
insert into Marca (nome_marca) values ('French Broom');
insert into Marca (nome_marca) values ('Beet');
insert into Marca (nome_marca) values ('Thinleaf Pea');
insert into Marca (nome_marca) values ('Yellow And Purple Monkeyflower');
insert into Marca (nome_marca) values ('Spotted Felt Lichen');
insert into Marca (nome_marca) values ('Rim Lichen');
insert into Marca (nome_marca) values ('Hybrid Oak');
insert into Marca (nome_marca) values ('Wyeth''s Lupine');
insert into Marca (nome_marca) values ('Ellesmereland Whitlowgrass');
insert into Marca (nome_marca) values ('Pacific Lovegrass');
insert into Marca (nome_marca) values ('Scarlet Oak');
insert into Marca (nome_marca) values ('Chaff Flower');
insert into Marca (nome_marca) values ('Boswellia');
insert into Marca (nome_marca) values ('Graceful Peperomia');
insert into Marca (nome_marca) values ('Clavel De Muerto');
insert into Marca (nome_marca) values ('Oakes'' Eyebright');

-- /////////////////////////////////////////////////////////
-- TipoVeiculo
-- /////////////////////////////////////////////////////////

insert into TipoVeiculo (numero_de_eixos) values (9);
insert into TipoVeiculo (numero_de_eixos) values (3);
insert into TipoVeiculo (numero_de_eixos) values (11);
insert into TipoVeiculo (numero_de_eixos) values (11);
insert into TipoVeiculo (numero_de_eixos) values (9);
insert into TipoVeiculo (numero_de_eixos) values (7);
insert into TipoVeiculo (numero_de_eixos) values (5);
insert into TipoVeiculo (numero_de_eixos) values (4);
insert into TipoVeiculo (numero_de_eixos) values (14);
insert into TipoVeiculo (numero_de_eixos) values (1);
insert into TipoVeiculo (numero_de_eixos) values (11);
insert into TipoVeiculo (numero_de_eixos) values (2);
insert into TipoVeiculo (numero_de_eixos) values (9);
insert into TipoVeiculo (numero_de_eixos) values (5);
insert into TipoVeiculo (numero_de_eixos) values (6);
insert into TipoVeiculo (numero_de_eixos) values (5);
insert into TipoVeiculo (numero_de_eixos) values (11);
insert into TipoVeiculo (numero_de_eixos) values (3);
insert into TipoVeiculo (numero_de_eixos) values (2);
insert into TipoVeiculo (numero_de_eixos) values (9);
insert into TipoVeiculo (numero_de_eixos) values (10);
insert into TipoVeiculo (numero_de_eixos) values (7);
insert into TipoVeiculo (numero_de_eixos) values (1);
insert into TipoVeiculo (numero_de_eixos) values (5);
insert into TipoVeiculo (numero_de_eixos) values (13);

-- /////////////////////////////////////////////////////////
-- Modelo
-- /////////////////////////////////////////////////////////

insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (1, 1, 'Dingo', 61, 62);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (2, 2, 'Dove, galapagos', 49, 17);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (3, 3, 'Trumpeter swan', 73, 57);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (4, 4, 'Kudu, greater', 36, 52);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (5, 5, 'Common seal', 51, 60);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (6, 6, 'Vulture, turkey', 73, 55);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (7, 7, 'Mongoose, small indian', 21, 27);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (8, 8, 'Puma, south american', 18, 17);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (9, 9, 'South American meadowlark (unidentified)', 78, 56);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (10, 10, 'Warthog', 69, 6);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (11, 11, 'Swan, black', 13, 84);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (12, 12, 'Cereopsis goose', 32, 54);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (13, 13, 'Common langur', 64, 90);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (14, 14, 'Francolin, coqui', 49, 71);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (15, 15, 'Civet (unidentified)', 41, 60);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (16, 16, 'Elk, Wapiti', 75, 68);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (17, 17, 'Wood pigeon', 54, 24);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (18, 18, 'Egyptian cobra', 63, 94);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (19, 19, 'Emerald green tree boa', 44, 62);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (20, 20, 'Banded mongoose', 89, 47);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (21, 21, 'Possum, pygmy', 49, 27);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (22, 22, 'Arctic ground squirrel', 73, 50);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (23, 23, 'Bleu, blue-breasted cordon', 50, 78);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (24, 24, 'Stork, greater adjutant', 73, 72);
insert into Modelo (cod_marca, cod_tipo, nome_modelo, capacidade_peso, capacidade_volume) values (25, 25, 'Pale-throated three-toed sloth', 87, 59);

-- /////////////////////////////////////////////////////////
-- Veiculo
-- /////////////////////////////////////////////////////////

insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('AA-BB-CC', 1, 'CBMXW', 5, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('DD-EE-FF', 2, 'JHD', 20, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('GMC', 3, 'JSM', 7, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Mercedes 22 Benz', 4, 'ALQA', 4, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Ford 2', 5, 'NODK', 5, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Honda', 6, 'GLMD', 1, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Hyundai', 7, 'PLUG', 1, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Volkswagen', 8, 'PSET', 13, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Chevrolet 3', 9, 'TOO^B', 19, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Hummer', 10, 'MSCI', 15, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Toyota 2', 11, 'VET', 4, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Pontiac', 12, 'NEE^R', 6, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Cadillac', 13, 'CBM', 14, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Toyota', 14, 'ABC', 2, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Kia', 15, 'WG', 8, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Ford 3', 16, 'DYN', 6, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Volvo', 17, 'TA', 7, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Mazda', 18, 'TPL', 15, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Chevrolet 2', 19, 'MHN', 2, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Subaru', 20, 'GDS', 1, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Ford 4', 21, 'LKSD', 17, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Mercedes-Benz', 22, 'SBRA', 4, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Nissan', 23, 'MYCC', 11, '1');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Chevrolet 1', 24, 'BWINA', 12, '0');
insert into Veiculo (matricula, cod_modelo, numero_apolice_seguro, numero_kilometros, disponibilidade) values ('Ford 5', 25, 'EE', 11, '1');


-- /////////////////////////////////////////////////////////
-- ZonaGeografica
-- /////////////////////////////////////////////////////////

insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (99.8, 98.6, 30.1);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (93.8, 69.8, 34.0);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (29.8, 89.0, 46.8);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (55.0, 54.2, 40.3);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (21.1, 84.0, 13.1);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (82.2, 37.7, 91.1);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (38.9, 21.8, 13.9);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (39.0, 55.4, 12.8);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (71.8, 14.4, 27.3);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (25.9, 17.6, 40.3);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (89.1, 44.9, 78.6);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (78.2, 58.8, 34.9);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (52.5, 20.4, 33.3);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (61.6, 44.5, 31.0);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (51.3, 71.3, 56.3);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (48.9, 32.4, 64.1);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (24.6, 95.7, 16.4);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (9.7, 65.7, 69.1);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (37.4, 71.6, 96.1);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (77.4, 39.3, 67.8);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (80.7, 82.9, 97.2);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (78.4, 83.1, 88.6);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (35.0, 24.6, 89.9);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (82.8, 86.7, 82.0);
insert into ZonaGeografica (coordenada_semi_major_axis_a, coordenada_semi_major_axis_b, coordenada_inverse_flattening) values (91.6, 88.8, 58.7);

-- /////////////////////////////////////////////////////////
-- CodigoPostal
-- /////////////////////////////////////////////////////////

insert into CodigoPostal (cod_codigo_postal, localidade) values ('1370', 'Fuwen');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('2145', 'Heka');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('1285', 'KwaMbonambi');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('4271', 'Pingshui');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('4217', 'Nesterovskaya');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('8225', 'Nangewer');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('1147', 'Al ‘Awjā');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('8230', 'Yangtan');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('2779', 'Ma’an');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('3861', 'Baganha');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('9687', 'Wissous');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('9382', 'Kauditan');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('5035', 'Nanterre');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('6684', 'Sambongmulyo');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('8730', 'Khon Buri');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('2588', 'Ladário');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('5683', 'Marale');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('5446', 'El Lolo');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('8242', 'Ijebu-Ife');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('4845', 'Machalí');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('1329', 'Donduşeni');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('7393', 'Lupao');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('8954', 'Mellieħa');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('1436', 'San Juan');
insert into CodigoPostal (cod_codigo_postal, localidade) values ('2540', 'Uujim');

-- /////////////////////////////////////////////////////////
-- Artigo
-- /////////////////////////////////////////////////////////


insert into Artigo (nome, descricao) values ('Carrots - Mini Red Organic', 'Ridgetop Schiedea');
insert into Artigo (nome, descricao) values ('Wine - Conde De Valdemar', 'Rockcress');
insert into Artigo (nome, descricao) values ('Bandage - Finger Cots', 'Heartleaf Nettle');
insert into Artigo (nome, descricao) values ('Longan', 'Engelmann Spruce');
insert into Artigo (nome, descricao) values ('Pastry - Carrot Muffin - Mini', 'Sarvis Holly');
insert into Artigo (nome, descricao) values ('Cheese - Perron Cheddar', 'Negra Lora');
insert into Artigo (nome, descricao) values ('Creme De Cacao White', 'Nevada Gilia');
insert into Artigo (nome, descricao) values ('Quinoa', 'Navajo Saltbush');
insert into Artigo (nome, descricao) values ('Bagel - 12 Grain Preslice', 'Sierra Biscuitroot');
insert into Artigo (nome, descricao) values ('Cookies - Englishbay Oatmeal', 'Texas Indian Paintbrush');
insert into Artigo (nome, descricao) values ('Chicken - Thigh, Bone In', 'Showy Whitetop');
insert into Artigo (nome, descricao) values ('Chocolate - Chips Compound', 'Dusty Miller');
insert into Artigo (nome, descricao) values ('Iced Tea - Lemon, 460 Ml', 'Missouri Goldenrod');
insert into Artigo (nome, descricao) values ('Wine - Segura Viudas Aria Brut', 'Widelip Orchid');
insert into Artigo (nome, descricao) values ('Pear - Halves', 'Pointed Sandmat');
insert into Artigo (nome, descricao) values ('Sprouts - Pea', 'Xerophytic Limestone Moss');
insert into Artigo (nome, descricao) values ('Carbonated Water - Blackberry', 'Hawai''i Nutrush');
insert into Artigo (nome, descricao) values ('Soup - Campbells, Spinach Crm', 'Tackstem');
insert into Artigo (nome, descricao) values ('Pepper - Chipotle, Canned', 'Mexican Yellow Star-grass');
insert into Artigo (nome, descricao) values ('Broccoli - Fresh', 'Passionflower');
insert into Artigo (nome, descricao) values ('Sauce - Oyster', 'Alpine Fescue');
insert into Artigo (nome, descricao) values ('Wine - Red, Mosaic Zweigelt', 'Haleakala Spleenwort');
insert into Artigo (nome, descricao) values ('Island Oasis - Wildberry', 'Handsome Harry');
insert into Artigo (nome, descricao) values ('Wine - Spumante Bambino White', 'Thelidium Lichen');
insert into Artigo (nome, descricao) values ('Prunes - Pitted', 'Alkali Sacaton');

-- /////////////////////////////////////////////////////////
-- UnidadeRepresentacao
-- /////////////////////////////////////////////////////////

insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (1, 93, 379);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (2, 176, 219);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (3, 193, 308);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (4, 73, 253);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (5, 195, 41);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (6, 135, 321);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (7, 87, 34);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (8, 200, 245);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (9, 50, 161);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (10, 82, 18);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (11, 71, 339);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (12, 134, 120);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (13, 53, 97);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (14, 131, 272);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (15, 58, 106);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (16, 55, 82);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (17, 128, 206);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (18, 49, 380);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (19, 43, 399);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (20, 44, 280);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (21, 58, 13);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (22, 34, 222);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (23, 52, 116);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (24, 168, 359);
insert into UnidadeRepresentacao (cod_artigo, volume, peso) values (25, 97, 390);

-- /////////////////////////////////////////////////////////
-- Armazem
-- /////////////////////////////////////////////////////////

insert into Armazem (cod_zona_geografica, nome, morada) values (1, 'Wunsch-Olson', '534 Novick Drive');
insert into Armazem (cod_zona_geografica, nome, morada) values (2, 'Lubowitz, Armstrong and Barrows', '7 Debra Parkway');
insert into Armazem (cod_zona_geografica, nome, morada) values (3, 'Labadie-Moen', '9891 Delladonna Terrace');
insert into Armazem (cod_zona_geografica, nome, morada) values (4, 'Labadie-Wuckert', '536 Vermont Way');
insert into Armazem (cod_zona_geografica, nome, morada) values (5, 'Thompson Inc', '41291 Carpenter Avenue');
insert into Armazem (cod_zona_geografica, nome, morada) values (6, 'Yost-Wunsch', '6528 Grover Plaza');
insert into Armazem (cod_zona_geografica, nome, morada) values (7, 'Medhurst LLC', '2763 Haas Junction');
insert into Armazem (cod_zona_geografica, nome, morada) values (8, 'Bechtelar-Deckow', '669 Northwestern Park');
insert into Armazem (cod_zona_geografica, nome, morada) values (9, 'Harvey-Cartwright', '101 Summer Ridge Pass');
insert into Armazem (cod_zona_geografica, nome, morada) values (10, 'Stokes Group', '4063 Rutledge Street');
insert into Armazem (cod_zona_geografica, nome, morada) values (11, 'Murphy Group', '29 Fuller Avenue');
insert into Armazem (cod_zona_geografica, nome, morada) values (12, 'Schoen-Senger', '43711 David Way');
insert into Armazem (cod_zona_geografica, nome, morada) values (13, 'Waters-Nicolas', '876 Merchant Trail');
insert into Armazem (cod_zona_geografica, nome, morada) values (14, 'Ebert Inc', '589 Crescent Oaks Circle');
insert into Armazem (cod_zona_geografica, nome, morada) values (15, 'Paucek and Sons', '3946 Schiller Way');
insert into Armazem (cod_zona_geografica, nome, morada) values (16, 'Cruickshank LLC', '2 Lyons Circle');
insert into Armazem (cod_zona_geografica, nome, morada) values (17, 'Weissnat-Nitzsche', '26693 Hoard Center');
insert into Armazem (cod_zona_geografica, nome, morada) values (18, 'Adams and Sons', '2 Sherman Circle');
insert into Armazem (cod_zona_geografica, nome, morada) values (19, 'Purdy Inc', '7 Warner Court');
insert into Armazem (cod_zona_geografica, nome, morada) values (20, 'Stroman Inc', '85205 Center Drive');
insert into Armazem (cod_zona_geografica, nome, morada) values (21, 'Spinka Group', '3 Union Avenue');
insert into Armazem (cod_zona_geografica, nome, morada) values (22, 'Sawayn, Hermiston and Sanford', '872 Surrey Crossing');
insert into Armazem (cod_zona_geografica, nome, morada) values (23, 'Walter Inc', '8 Bobwhite Pass');
insert into Armazem (cod_zona_geografica, nome, morada) values (24, 'Skiles, Ferry and Schuppe', '076 Schiller Plaza');
insert into Armazem (cod_zona_geografica, nome, morada) values (25, 'Kozey, Koss and Feil', '696 Fairview Junction');

-- /////////////////////////////////////////////////////////
-- Zona
-- /////////////////////////////////////////////////////////

insert into Zona (cod_armazem, capacidade) values (1, 5376);
insert into Zona (cod_armazem, capacidade) values (2, 6932);
insert into Zona (cod_armazem, capacidade) values (3, 1655);
insert into Zona (cod_armazem, capacidade) values (4, 2548);
insert into Zona (cod_armazem, capacidade) values (5, 2727);
insert into Zona (cod_armazem, capacidade) values (6, 5695);
insert into Zona (cod_armazem, capacidade) values (7, 3903);
insert into Zona (cod_armazem, capacidade) values (8, 2127);
insert into Zona (cod_armazem, capacidade) values (9, 2964);
insert into Zona (cod_armazem, capacidade) values (10, 6573);
insert into Zona (cod_armazem, capacidade) values (11, 2553);
insert into Zona (cod_armazem, capacidade) values (12, 6261);
insert into Zona (cod_armazem, capacidade) values (13, 2302);
insert into Zona (cod_armazem, capacidade) values (14, 2195);
insert into Zona (cod_armazem, capacidade) values (15, 4601);
insert into Zona (cod_armazem, capacidade) values (16, 1857);
insert into Zona (cod_armazem, capacidade) values (17, 5114);
insert into Zona (cod_armazem, capacidade) values (18, 7378);
insert into Zona (cod_armazem, capacidade) values (19, 6600);
insert into Zona (cod_armazem, capacidade) values (20, 4533);
insert into Zona (cod_armazem, capacidade) values (21, 7129);
insert into Zona (cod_armazem, capacidade) values (22, 3982);
insert into Zona (cod_armazem, capacidade) values (23, 3252);
insert into Zona (cod_armazem, capacidade) values (24, 2063);
insert into Zona (cod_armazem, capacidade) values (25, 687);

-- /////////////////////////////////////////////////////////
-- Empregado
-- /////////////////////////////////////////////////////////

insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 24, 'Fiel de Armazem', 210222379, 'Jule', '523 Stang Street', 617091310, 683, 30);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 23, 'Fiel de Armazem', 483204136, 'Giraldo', '364 Oxford Avenue', 897268428, 6753, 46);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 11, 'Fiel de Armazem', 856062916, 'Nicol', '75770 Killdeer Court', 841135398, 531, 31);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 1, 'Fiel de Armazem', 300900569, 'Lonnie', '63616 Claremont Court', 313777033, 2359, 54);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 13, 'Fiel de Armazem', 458274808, 'Ransell', '31169 Butterfield Hill', 255616146, 4760, 62);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 7, 'Fiel de Armazem', 837072522, 'Marcello', '1 Bowman Trail', 689018725, 5604, 50);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 7, 'Fiel de Armazem', 950655357, 'Arabella', '314 Browning Road', 325359156, 3665, 55);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 12, 'Fiel de Armazem', 456103447, 'Melloney', '069 Rusk Road', 590299516, 1606, 50);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 1, 'Fiel de Armazem', 781230615, 'Felic', '219 Sunfield Court', 788216751, 4438, 24);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 14, 'Fiel de Armazem', 360433729, 'Kristopher', '989 4th Hill', 404819047, 6882, 43);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 19, 'Fiel de Armazem', 333335458, 'Heath', '0 Goodland Park', 622313109, 2508, 27);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 13, 'Fiel de Armazem', 225530802, 'Timofei', '4677 Dahle Hill', 616926528, 4997, 56);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 21, 'Motorista', 624610394, 'Vaclav', '993 Dixon Trail', 474822569, 2005, 37);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 14, 'Motorista', 120430090, 'Robinson', '0 Colorado Junction', 213755908, 2167, 47);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 24, 'Motorista', 992303370, 'Zeb', '9164 Bowman Terrace', 781386367, 6621, 49);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 1, 'Motorista', 671720681, 'Aurelea', '47449 Macpherson Alley', 779518875, 1189, 39);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 16, 'Motorista', 224934512, 'Hernando', '4 Browning Alley', 671017510, 5014, 56);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 10, 'Motorista', 506981081, 'Nerty', '63204 Tennessee Trail', 394848473, 3165, 63);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 12, 'Motorista', 126894395, 'Crista', '4991 Center Terrace', 596095543, 1368, 34);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 19, 'Motorista', 956248742, 'Wilbert', '0033 Del Mar Court', 768695215, 6347, 51);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 17, 'Motorista', 840038453, 'Pen', '76176 Heath Hill', 528228025, 4463, 41);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 24, 'Motorista', 748370690, 'Hailee', '70 Surrey Court', 651925284, 3452, 24);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 23, 'Motorista', 763818825, 'Diarmid', '73 Warrior Terrace', 301730469, 3003, 28);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 3, 'Motorista', 195672958, 'Consuelo', '98490 Mitchell Hill', 357901566, 3146, 25);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 17, 'Motorista', 827731515, 'Deeyn', '6669 Sage Pass', 386396166, 2963, 44);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 25, 'Vendedor', 724442899, 'Zilvia', '4 Ilene Hill', 164053110, 5875, 43);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 23, 'Vendedor', 664790515, 'Rosella', '0 Sheridan Pass', 513103331, 989, 50);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 20, 'Vendedor', 311374430, 'Munroe', '9 Morningstar Place', 512108380, 6543, 39);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 9, 'Vendedor', 689254167, 'Jackquelin', '853 Clarendon Lane', 326675552, 5603, 57);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 4, 'Vendedor', 372900589, 'Kori', '13 Moose Hill', 975106752, 949, 24);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 14, 'Vendedor', 527064568, 'Alvira', '49102 Shelley Circle', 533998490, 7475, 61);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 7, 'Vendedor', 486702069, 'Rickert', '34 Straubel Place', 144272192, 1174, 59);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 12, 'Vendedor', 637094010, 'Kile', '426 Talmadge Way', 822257654, 4490, 57);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 18, 'Vendedor', 867104771, 'Julia', '641 Macpherson Road', 293347123, 747, 44);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 14, 'Vendedor', 458276554, 'Deane', '6 Division Alley', 538457225, 1551, 65);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 22, 'Vendedor', 838805100, 'Clerc', '3367 Pepper Wood Alley', 448547022, 1545, 41);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 9, 'Vendedor', 186899840, 'Claudette', '84515 Manley Lane', 972709669, 956, 47);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 9, 'Fiel de Armazem', 783220286, 'Zara', '28151 East Junction', 490387835, 1848, 36);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 10, 'Fiel de Armazem', 827528349, 'Worthington', '5731 Stephen Parkway', 649355194, 4509, 62);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 8, 'Fiel de Armazem', 446973456, 'Franzen', '8845 Fordem Junction', 508828595, 2361, 65);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 22, 'Fiel de Armazem', 585404640, 'Emmet', '4 Fulton Lane', 745332971, 2123, 51);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 24, 'Fiel de Armazem', 561051261, 'Enrika', '8 Superior Plaza', 235254833, 2729, 61);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 1, 'Fiel de Armazem', 457107968, 'Merilee', '8 Annamark Street', 380838688, 2743, 40);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 21, 'Fiel de Armazem', 356995308, 'Reggie', '41 Maple Wood Crossing', 346970111, 3097, 30);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 20, 'Fiel de Armazem', 135315016, 'Babara', '0 Del Mar Place', 932725909, 7133, 48);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 14, 'Fiel de Armazem', 121369597, 'Stevie', '0 Karstens Trail', 965691520, 1985, 39);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 13, 'Fiel de Armazem', 999207371, 'Erena', '06 Warrior Lane', 620450584, 4845, 28);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 24, 'Fiel de Armazem', 868668436, 'Swen', '4655 Messerschmidt Place', 629262849, 5930, 55);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 15, 'Fiel de Armazem', 696291222, 'Jere', '2 Darwin Crossing', 529556433, 5354, 43);
insert into Empregado (cod_supervisor, cod_armazem, tipo, cartao_cidadao, nome, morada, nif, salario_mensal, idade) values (null, 10, 'Fiel de Armazem', 118249958, 'Lynelle', '61137 Twin Pines Center', 162076896, 3322, 61);

-- /////////////////////////////////////////////////////////
-- Cliente
-- /////////////////////////////////////////////////////////

insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (8, '3861', 1, 'Eldin', '8 Golden Leaf Parkway', 100000000, 335680816,  TO_DATE('04/10/2017', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (9, '3861', 1, 'Jillie', '9 Cambridge Terrace', 100000000, 993818370, TO_DATE('04/10/2017', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (6, '3861', 3, 'Clim', '2427 Sherman Parkway', 100000000, 999211690, TO_DATE('04/10/2017', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (15, '3861', 3, 'Adrien', '76486 Gina Hill', 100000000, 227469022, TO_DATE('04/10/2017', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (7, '3861', 1, 'Curcio', '5 Forest Drive', 100000000, 734177773, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (18, '3861', 2, 'Tedie', '998 Lillian Court', 100000000, 842652864, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (18, '3861', 1, 'Maison', '66747 Calypso Drive', 100000000, 336648296, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (8, '3861', 1, 'Evan', '9 Moose Drive', 100000000, 788071470, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (11, '3861', 2, 'Daphne', '129 Talisman Hill', 100000000, 533912361, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (25, '9382', 3, 'Ezra', '18810 Hansons Pass', 100000000, 826290406, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (23, '9382', 3, 'Albertina', '115 Oakridge Crossing', 100000000, 881175362, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (16, '9382', 3, 'Friederike', '7 Oriole Way', 100000000, 302202611, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (2, '9382', 2, 'Steven', '5 Dottie Drive', 100000000, 889405808, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (13, '9382', 1, 'Sasha', '39 Stoughton Center', 100000000, 209672391, TO_DATE('04/10/2018', 'DD/MM/YYYY'));
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (25, '9382', 1, 'Shay', '5034 Kedzie Trail', 100000000, 643704386, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (12, '9382', 1, 'Murial', '212 Tomscot Park', 100000000, 175929006, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (5, '9382', 2, 'Ardith', '60 Sachs Center', 100000000, 187536481, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (21, '9382', 2, 'Shannon', '24 Dottie Park', 100000000, 388512377, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (4, '9382', 2, 'Biddie', '526 Graceland Circle', 100000000, 387118042, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (11, '9382', 3, 'Marnia', '14047 Butterfield Junction', 100000000, 664580007, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (21, '9382', 3, 'Ainsley', '9 Sachs Terrace', 100000000, 582572525, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (22, '9382', 3, 'Linnie', '10254 Clemons Street', 100000000, 896789526, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (1, '9382', 1, 'Layton', '7 Almo Park', 100000000, 931092141, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (1, '9382', 1, 'Thoma', '9663 Bartillon Trail', 100000000, 632430918, null);
insert into Cliente (cod_zona_geografica, cod_codigo_postal, cod_tipo_cliente, nome, morada, telemovel, nif, data_ultima_alteracao) values (10, '9382', 1, 'Donetta', '56913 Randy Hill', 100000000, 283037022, null);

-- /////////////////////////////////////////////////////////
-- Armazem_Artigo
-- /////////////////////////////////////////////////////////

insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 3, 5840);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (8, 17, 2301);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (5, 21, 1712);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (19, 10, 3244);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (22, 1, 3663);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (2, 8, 4374);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (14, 17, 5296);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (9, 13, 2142);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (11, 10, 4404);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (22, 3, 3060);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (11, 15, 4514);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (25, 13, 6222);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (24, 12, 5202);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (11, 14, 6099);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (3, 16, 5673);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (14, 13, 1187);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (3, 2, 6034);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (8, 18, 2330);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (17, 18, 2649);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (10, 5, 4821);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (10, 8, 1332);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 20, 3464);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (8, 19, 3076);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (4, 9, 1516);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (8, 5, 4410);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (2, 4, 3073);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (22, 13, 2574);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (19, 22, 6666);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (10, 25, 4914);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (4, 1, 5950);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 11, 5693);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (15, 14, 1278);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (8, 21, 1643);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (16, 12, 5949);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (1, 4, 3362);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (20, 13, 6828);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (14, 16, 4512);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (5, 20, 1313);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (23, 18, 4353);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (4, 7, 6479);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (15, 6, 4482);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 18, 2150);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (7, 21, 4948);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (13, 25, 5461);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (23, 2, 2659);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 10, 3453);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (22, 5, 5492);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (22, 15, 2875);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (15, 12, 104);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (18, 23, 1588);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (18, 20, 7140);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (4, 23, 338);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (7, 20, 2348);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (3, 24, 5504);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (20, 12, 6436);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (24, 11, 1104);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (23, 11, 543);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (18, 10, 1291);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (6, 3, 2454);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (7, 1, 7388);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (25, 22, 1404);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (4, 17, 2612);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (25, 10, 3749);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (11, 17, 2813);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (11, 12, 1752);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 4, 514);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (19, 15, 936);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (7, 16, 6525);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (21, 9, 1470);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (8, 14, 3693);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (25, 1, 6765);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (23, 4, 5229);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (20, 11, 3619);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (11, 2, 5782);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (6, 24, 4283);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (16, 7, 7318);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (19, 21, 4231);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (22, 10, 6212);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (7, 25, 911);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 21, 5445);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (18, 16, 121);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (24, 10, 139);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (18, 7, 7476);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (13, 16, 1250);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (8, 13, 2248);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (7, 24, 4925);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 1, 1577);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (17, 14, 1519);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (1, 13, 5611);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (8, 6, 1284);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (4, 13, 7277);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (19, 12, 1376);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (3, 23, 1972);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (22, 25, 865);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (12, 12, 4925);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (21, 24, 384);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (9, 23, 1184);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (9, 18, 4568);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (24, 8, 1061);
insert into Armazem_Artigo (cod_armazem, cod_artigo, quantidade_stock_minimo) values (24, 17, 7468);

-- /////////////////////////////////////////////////////////
-- Fatura
-- /////////////////////////////////////////////////////////

insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (1, 1, TO_DATE('19/05/2018', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (2, 2, TO_DATE('26/02/2018', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (3, 3, TO_DATE('06/05/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (4, 4, TO_DATE('22/05/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (5, 5, TO_DATE('05/06/2018', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (6, 6, TO_DATE('10/10/2018', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (7, 7, TO_DATE('30/03/2018', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (8, 8, TO_DATE('12/05/2018', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (9, 9, TO_DATE('16/12/2017', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (10, 10, TO_DATE('25/02/2018', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (11, 11, TO_DATE('23/08/2018', 'DD/MM/YYYY'), 'nao liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (12, 12, TO_DATE('21/12/2017', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (13, 13, TO_DATE('20/08/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (14, 14, TO_DATE('11/10/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (15, 15, TO_DATE('06/05/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (16, 16, TO_DATE('30/09/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (17, 17, TO_DATE('14/07/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (18, 18, TO_DATE('01/09/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (19, 19, TO_DATE('24/05/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (20, 20, TO_DATE('20/03/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (21, 21, TO_DATE('18/07/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (22, 22, TO_DATE('25/02/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (23, 23, TO_DATE('07/01/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (24, 24, TO_DATE('03/02/2018', 'DD/MM/YYYY'), 'liquidada');
insert into Fatura (cod_cliente, cod_empregado, data_fatura, estado) values (1, 12, TO_DATE('17/11/2018', 'DD/MM/YYYY'), 'liquidada');




-- /////////////////////////////////////////////////////////
-- Pagamento
-- /////////////////////////////////////////////////////////


insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (1, TO_DATE('19/09/2018', 'DD/MM/YYYY'), 76, 'Geochelone radiata');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (2, TO_DATE('10/10/2018', 'DD/MM/YYYY'), 64, 'Papio ursinus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (3, TO_DATE('19/09/2018', 'DD/MM/YYYY'), 10, 'Alopex lagopus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (4, TO_DATE('24/01/2018', 'DD/MM/YYYY'), 21, 'Amblyrhynchus cristatus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (5, TO_DATE('07/12/2017', 'DD/MM/YYYY'), 97, 'Mycteria leucocephala');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (6, TO_DATE('03/06/2018', 'DD/MM/YYYY'), 10, 'Gyps bengalensis');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (7, TO_DATE('09/11/2018', 'DD/MM/YYYY'), 70, 'Ovis ammon');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (8, TO_DATE('01/04/2018', 'DD/MM/YYYY'), 55, 'Lamprotornis superbus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (9, TO_DATE('09/03/2018', 'DD/MM/YYYY'), 26, 'Cervus elaphus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (10, TO_DATE('22/08/2018', 'DD/MM/YYYY'), 37, 'Spilogale gracilis');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (11, TO_DATE('08/07/2018', 'DD/MM/YYYY'), 59, 'Felis concolor');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (12, TO_DATE('21/03/2018', 'DD/MM/YYYY'), 99, 'Ephippiorhynchus mycteria');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (13, TO_DATE('26/09/2018', 'DD/MM/YYYY'), 10, 'Ursus americanus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (14, TO_DATE('03/02/2018', 'DD/MM/YYYY'), 54, 'unavailable');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (15, TO_DATE('19/11/2018', 'DD/MM/YYYY'), 40, 'Graspus graspus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (16, TO_DATE('23/01/2018', 'DD/MM/YYYY'), 72, 'Aonyx cinerea');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (17, TO_DATE('28/11/2018', 'DD/MM/YYYY'), 76, 'Phoeniconaias minor');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (18, TO_DATE('10/08/2018', 'DD/MM/YYYY'), 67, 'Connochaetus taurinus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (19, TO_DATE('18/11/2018', 'DD/MM/YYYY'), 71, 'Phalacrocorax albiventer');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (20, TO_DATE('27/01/2018', 'DD/MM/YYYY'), 61, 'Eremophila alpestris');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (21, TO_DATE('28/03/2018', 'DD/MM/YYYY'), 76, 'Crotalus cerastes');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (22, TO_DATE('21/05/2018', 'DD/MM/YYYY'), 43, 'Bugeranus caruncalatus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (23, TO_DATE('31/05/2018', 'DD/MM/YYYY'), 94, 'Lemur fulvus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (24, TO_DATE('25/06/2018', 'DD/MM/YYYY'), 21, 'Seiurus aurocapillus');
insert into Pagamento (cod_fatura, data_pagamento, quantia, metodo) values (25, TO_DATE('07/12/2017', 'DD/MM/YYYY'), 32, 'Varanus sp.');

-- /////////////////////////////////////////////////////////
-- Viagem
-- /////////////////////////////////////////////////////////

insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (1, 1, 'AA-BB-CC', TO_DATE('04/10/2017', 'DD/MM/YYYY'), TO_DATE('01/03/2018', 'DD/MM/YYYY'), 82, 88);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (2, 2, 'AA-BB-CC', TO_DATE('01/05/2017', 'DD/MM/YYYY'), TO_DATE('06/05/2018', 'DD/MM/YYYY'), 12, 54);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (3, 3, 'AA-BB-CC', TO_DATE('15/09/2017', 'DD/MM/YYYY'), TO_DATE('06/02/2018', 'DD/MM/YYYY'), 87, 62);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (4, 4, 'AA-BB-CC', TO_DATE('04/09/2017', 'DD/MM/YYYY'), TO_DATE('08/09/2018', 'DD/MM/YYYY'), 60, 95);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (5, 5, 'AA-BB-CC', TO_DATE('17/02/2017', 'DD/MM/YYYY'), TO_DATE('12/01/2018', 'DD/MM/YYYY'), 24, 28);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (6, 6, 'AA-BB-CC', TO_DATE('01/05/2017', 'DD/MM/YYYY'), TO_DATE('03/05/2018', 'DD/MM/YYYY'), 40, 42);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (7, 7, 'AA-BB-CC', TO_DATE('17/07/2017', 'DD/MM/YYYY'), TO_DATE('22/10/2018', 'DD/MM/YYYY'), 63, 20);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (8, 8, 'AA-BB-CC', TO_DATE('29/07/2017', 'DD/MM/YYYY'), TO_DATE('08/08/2018', 'DD/MM/YYYY'), 41, 58);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (9, 9, 'AA-BB-CC', TO_DATE('17/02/2017', 'DD/MM/YYYY'), TO_DATE('24/01/2018', 'DD/MM/YYYY'), 55, 23);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (10, 10, 'AA-BB-CC', TO_DATE('17/12/2016', 'DD/MM/YYYY'), TO_DATE('17/02/2018', 'DD/MM/YYYY'), 19, 76);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (11, 11, 'AA-BB-CC', TO_DATE('03/05/2017', 'DD/MM/YYYY'), TO_DATE('22/03/2018', 'DD/MM/YYYY'), 35, 73);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (12, 12, 'AA-BB-CC', TO_DATE('12/06/2017', 'DD/MM/YYYY'), TO_DATE('20/01/2018', 'DD/MM/YYYY'), 48, 90);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (13, 13, 'DD-EE-FF', TO_DATE('20/11/2017', 'DD/MM/YYYY'), TO_DATE('22/06/2018', 'DD/MM/YYYY'), 26, 97);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (14, 14, 'DD-EE-FF', TO_DATE('28/09/2017', 'DD/MM/YYYY'), TO_DATE('05/03/2018', 'DD/MM/YYYY'), 33, 41);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (15, 15, 'DD-EE-FF', TO_DATE('30/06/2017', 'DD/MM/YYYY'), TO_DATE('05/03/2018', 'DD/MM/YYYY'), 38, 17);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (16, 16, 'DD-EE-FF', TO_DATE('02/07/2017', 'DD/MM/YYYY'), TO_DATE('06/12/2017', 'DD/MM/YYYY'), 39, 63);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (17, 17, 'DD-EE-FF', TO_DATE('03/05/2017', 'DD/MM/YYYY'), TO_DATE('26/06/2018', 'DD/MM/YYYY'), 33, 98);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (18, 18, 'DD-EE-FF', TO_DATE('20/01/2017', 'DD/MM/YYYY'), TO_DATE('16/02/2018', 'DD/MM/YYYY'), 28, 69);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (19, 19, 'DD-EE-FF', TO_DATE('17/06/2017', 'DD/MM/YYYY'), TO_DATE('05/09/2018', 'DD/MM/YYYY'), 47, 89);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (20, 20, 'DD-EE-FF', TO_DATE('14/11/2017', 'DD/MM/YYYY'), TO_DATE('27/05/2018', 'DD/MM/YYYY'), 43, 13);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (21, 21, 'DD-EE-FF', TO_DATE('25/01/2017', 'DD/MM/YYYY'), TO_DATE('21/09/2018', 'DD/MM/YYYY'), 42, 66);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (22, 22, 'DD-EE-FF', TO_DATE('21/12/2016', 'DD/MM/YYYY'), TO_DATE('19/11/2018', 'DD/MM/YYYY'), 41, 83);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (23, 23, 'DD-EE-FF', TO_DATE('30/06/2017', 'DD/MM/YYYY'), TO_DATE('09/04/2018', 'DD/MM/YYYY'), 99, 38);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (24, 24, 'DD-EE-FF', TO_DATE('05/11/2017', 'DD/MM/YYYY'), TO_DATE('08/07/2018', 'DD/MM/YYYY'), 34, 71);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (25, 25, 'DD-EE-FF', TO_DATE('09/09/2017', 'DD/MM/YYYY'), TO_DATE('12/11/2018', 'DD/MM/YYYY'), 65, 47);


-- /////////////////////////////////////////////////////////
-- Etapa
-- /////////////////////////////////////////////////////////

insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (10, 5, 7);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (13, 8, 22);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (25, 12, 3);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (15, 6, 12);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (21, 15, 1);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (12, 5, 18);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (7, 9, 11);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (12, 16, 2);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (24, 5, 9);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (20, 17, 6);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (7, 1, 15);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (25, 7, 23);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (24, 10, 6);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (19, 18, 8);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (19, 4, 23);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (17, 4, 7);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (1, 4, 23);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (10, 9, 15);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (4, 11, 4);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (16, 1, 18);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (14, 13, 9);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (3, 16, 9);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (19, 18, 14);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (15, 5, 13);
insert into Etapa (cod_viagem, cod_cliente_origem, cod_cliente_destino) values (9, 22, 15);

-- /////////////////////////////////////////////////////////
-- PrecoArtigo
-- /////////////////////////////////////////////////////////

insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (1, TO_DATE('28/03/2017', 'DD/MM/YYYY'), TO_DATE('29/10/2018', 'DD/MM/YYYY'), 4, 26);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (2, TO_DATE('21/10/2017', 'DD/MM/YYYY'), TO_DATE('04/08/2018', 'DD/MM/YYYY'), 33, 55);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (3, TO_DATE('16/12/2016', 'DD/MM/YYYY'), TO_DATE('04/07/2018', 'DD/MM/YYYY'), 54, 61);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (4, TO_DATE('07/05/2017', 'DD/MM/YYYY'), TO_DATE('21/01/2018', 'DD/MM/YYYY'), 31, 34);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (5, TO_DATE('25/01/2017', 'DD/MM/YYYY'), TO_DATE('16/01/2018', 'DD/MM/YYYY'), 80, 23);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (6, TO_DATE('06/09/2017', 'DD/MM/YYYY'), TO_DATE('16/08/2018', 'DD/MM/YYYY'), 48, 27);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (7, TO_DATE('14/06/2017', 'DD/MM/YYYY'), TO_DATE('04/01/2018', 'DD/MM/YYYY'), 52, 86);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (8, TO_DATE('09/08/2017', 'DD/MM/YYYY'), TO_DATE('11/12/2017', 'DD/MM/YYYY'), 56, 57);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (9, TO_DATE('06/10/2017', 'DD/MM/YYYY'), TO_DATE('18/06/2018', 'DD/MM/YYYY'), 38, 18);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (10, TO_DATE('05/07/2017', 'DD/MM/YYYY'), TO_DATE('30/11/2018', 'DD/MM/YYYY'), 38, 66);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (11, TO_DATE('23/12/2016', 'DD/MM/YYYY'), TO_DATE('28/04/2018', 'DD/MM/YYYY'), 70, 74);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (12, TO_DATE('29/06/2017', 'DD/MM/YYYY'), TO_DATE('12/09/2018', 'DD/MM/YYYY'), 11, 40);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (13, TO_DATE('14/04/2017', 'DD/MM/YYYY'), TO_DATE('26/07/2018', 'DD/MM/YYYY'), 24, 19);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (14, TO_DATE('10/09/2017', 'DD/MM/YYYY'), TO_DATE('15/04/2018', 'DD/MM/YYYY'), 18, 25);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (15, TO_DATE('23/03/2017', 'DD/MM/YYYY'), TO_DATE('07/03/2018', 'DD/MM/YYYY'), 97, 43);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (16, TO_DATE('09/06/2017', 'DD/MM/YYYY'), TO_DATE('31/01/2018', 'DD/MM/YYYY'), 22, 23);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (17, TO_DATE('29/05/2017', 'DD/MM/YYYY'), TO_DATE('02/01/2018', 'DD/MM/YYYY'), 10, 96);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (18, TO_DATE('01/06/2017', 'DD/MM/YYYY'), TO_DATE('20/07/2018', 'DD/MM/YYYY'), 8, 82);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (19, TO_DATE('09/08/2017', 'DD/MM/YYYY'), TO_DATE('23/07/2018', 'DD/MM/YYYY'), 6, 8);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (20, TO_DATE('27/05/2017', 'DD/MM/YYYY'), TO_DATE('12/08/2018', 'DD/MM/YYYY'), 67, 22);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (21, TO_DATE('18/04/2017', 'DD/MM/YYYY'), TO_DATE('17/07/2018', 'DD/MM/YYYY'), 10, 33);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (22, TO_DATE('02/01/2017', 'DD/MM/YYYY'), TO_DATE('30/10/2018', 'DD/MM/YYYY'), 90, 73);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (23, TO_DATE('01/01/2017', 'DD/MM/YYYY'), TO_DATE('21/09/2018', 'DD/MM/YYYY'), 2, 25);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (24, TO_DATE('15/08/2017', 'DD/MM/YYYY'), TO_DATE('02/08/2018', 'DD/MM/YYYY'), 20, 18);
insert into PrecoArtigo (cod_artigo, data_inicio, data_fim, preco_venda, preco_compra) values (25, TO_DATE('18/11/2017', 'DD/MM/YYYY'), TO_DATE('20/05/2018', 'DD/MM/YYYY'), 94, 89);

-- /////////////////////////////////////////////////////////
-- Zona_Artigo
-- /////////////////////////////////////////////////////////

insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (1, 1, 6750);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (2, 2, 7044);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (3, 3, 6475);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (4, 4, 14720);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (5, 5, 6404);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (6, 6, 3611);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (7, 7, 14798);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (8, 8, 3437);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (9, 9, 841);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (10, 10, 11994);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (11, 11, 14976);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (12, 12, 11586);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (13, 13, 11228);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (14, 14, 2667);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (15, 15, 10610);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (16, 16, 9750);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (17, 17, 3410);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (18, 18, 12026);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (19, 19, 7780);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (20, 20, 5838);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (21, 21, 1875);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (22, 22, 981);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (23, 23, 951);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (24, 24, 13796);
insert into Zona_Artigo (cod_artigo, cod_zona, quantidade) values (25, 25, 10774);

-- /////////////////////////////////////////////////////////
-- GuiaSaida
-- /////////////////////////////////////////////////////////

insert into GuiaSaida (cod_guia_saida) values (1);
insert into GuiaSaida (cod_guia_saida) values (2);
insert into GuiaSaida (cod_guia_saida) values (3);
insert into GuiaSaida (cod_guia_saida) values (4);
insert into GuiaSaida (cod_guia_saida) values (5);
insert into GuiaSaida (cod_guia_saida) values (6);
insert into GuiaSaida (cod_guia_saida) values (7);
insert into GuiaSaida (cod_guia_saida) values (8);
insert into GuiaSaida (cod_guia_saida) values (9);
insert into GuiaSaida (cod_guia_saida) values (10);
insert into GuiaSaida (cod_guia_saida) values (11);
insert into GuiaSaida (cod_guia_saida) values (12);
insert into GuiaSaida (cod_guia_saida) values (13);
insert into GuiaSaida (cod_guia_saida) values (14);
insert into GuiaSaida (cod_guia_saida) values (15);
insert into GuiaSaida (cod_guia_saida) values (16);
insert into GuiaSaida (cod_guia_saida) values (17);
insert into GuiaSaida (cod_guia_saida) values (18);
insert into GuiaSaida (cod_guia_saida) values (19);
insert into GuiaSaida (cod_guia_saida) values (20);
insert into GuiaSaida (cod_guia_saida) values (21);
insert into GuiaSaida (cod_guia_saida) values (22);
insert into GuiaSaida (cod_guia_saida) values (23);
insert into GuiaSaida (cod_guia_saida) values (24);
insert into GuiaSaida (cod_guia_saida) values (25);

-- /////////////////////////////////////////////////////////
-- GuiaTransporte
-- /////////////////////////////////////////////////////////

insert into GuiaTransporte (cod_viagem) values (1);
insert into GuiaTransporte (cod_viagem) values (2);
insert into GuiaTransporte (cod_viagem) values (3);
insert into GuiaTransporte (cod_viagem) values (4);
insert into GuiaTransporte (cod_viagem) values (5);
insert into GuiaTransporte (cod_viagem) values (6);
insert into GuiaTransporte (cod_viagem) values (7);
insert into GuiaTransporte (cod_viagem) values (8);
insert into GuiaTransporte (cod_viagem) values (9);
insert into GuiaTransporte (cod_viagem) values (10);
insert into GuiaTransporte (cod_viagem) values (11);
insert into GuiaTransporte (cod_viagem) values (12);
insert into GuiaTransporte (cod_viagem) values (13);
insert into GuiaTransporte (cod_viagem) values (14);
insert into GuiaTransporte (cod_viagem) values (15);
insert into GuiaTransporte (cod_viagem) values (16);
insert into GuiaTransporte (cod_viagem) values (17);
insert into GuiaTransporte (cod_viagem) values (18);
insert into GuiaTransporte (cod_viagem) values (19);
insert into GuiaTransporte (cod_viagem) values (20);
insert into GuiaTransporte (cod_viagem) values (21);
insert into GuiaTransporte (cod_viagem) values (22);
insert into GuiaTransporte (cod_viagem) values (23);
insert into GuiaTransporte (cod_viagem) values (24);
insert into GuiaTransporte (cod_viagem) values (25);

-- /////////////////////////////////////////////////////////
-- NotaEncomenda_Zona_Artigo
-- /////////////////////////////////////////////////////////

insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (1, 1, 1, 1, TO_DATE('21/12/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (2, 2, 2, 2, TO_DATE('16/08/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (3, 3, 3, 3, TO_DATE('08/01/2017', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (4, 4, 4, 4, TO_DATE('18/04/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (5, 5, 5, 5, TO_DATE('18/10/2017', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (6, 6, 6, 6, TO_DATE('17/01/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (7, 7, 7, 7, TO_DATE('10/03/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (8, 8, 8, 8, TO_DATE('18/11/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (9, 9, 9, 9, TO_DATE('12/06/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (10, 10, 10, 10, TO_DATE('08/10/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (11, 11, 11, 11, TO_DATE('10/11/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (12, 12, 12, 12, TO_DATE('24/09/2017', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (13, 13, 13, 13, TO_DATE('14/09/2017', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (14, 14, 14, 14, TO_DATE('20/08/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (15, 15, 15, 15, TO_DATE('28/09/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (16, 16, 16, 16, TO_DATE('08/01/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (17, 17, 17, 17, TO_DATE('10/02/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (18, 18, 18, 18, TO_DATE('13/05/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (19, 19, 19, 19, TO_DATE('28/07/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (20, 20, 20, 20, TO_DATE('21/06/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (21, 21, 21, 21, TO_DATE('02/03/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (22, 22, 22, 22, TO_DATE('16/02/2018', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (23, 23, 23, 23, TO_DATE('25/05/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (24, 24, 24, 24, TO_DATE('02/09/2016', 'DD/MM/YYYY'), 'pendente');
insert into NotaEncomenda (cod_empregado, cod_cliente, cod_fatura, cod_guia_transporte, data_nota_encomenda, estado) values (1, 2, 3, 4, TO_DATE('14/10/2016', 'DD/MM/YYYY'), 'pendente');

-- /////////////////////////////////////////////////////////
-- NotaEncomenda_Zona_Artigo
-- /////////////////////////////////////////////////////////

insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (1, 1, 1, 1, 3163, 43, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (2, 2, 2, 2, 4707, 2, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (3, 3, 3, 3, 6877, 14, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (4, 4, 4, 4, 4080, 36, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (5, 5, 5, 5, 6675, 40, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (6, 6, 6, 6, 6764, 23, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (7, 7, 7, 7, 2753, 29, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (8, 8, 8, 8, 1157, 16, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (9, 9, 9, 9, 1117, 18, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (10, 10, 10, 10, 5398, 20, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (11, 11, 11, 11, 3819, 4, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (12, 12, 12, 12, 2865, 10, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (13, 13, 13, 13, 1903, 20, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (14, 14, 14, 14, 2699, 16, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (15, 15, 15, 15, 5044, 42, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (16, 16, 16, 16, 5023, 15, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (17, 17, 17, 17, 7349, 20, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (18, 18, 18, 18, 2125, 3, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (19, 19, 19, 19, 1035, 37, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (20, 20, 20, 20, 1971, 50, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (21, 21, 21, 21, 5982, 28, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (22, 22, 22, 22, 1229, 20, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (23, 23, 23, 23, 1653, 49, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (24, 24, 24, 24, 3536, 48, null);
insert into NotaEncomenda_Zona_Artigo (cod_nota_encomenda, cod_artigo, cod_zona, cod_guia_saida, quantidade_encomenda, iva, desconto) values (2, 25, 25, 25, 4258, 16, null);

-- /////////////////////////////////////////////////////////
-- NotificacaoFimServico
-- /////////////////////////////////////////////////////////

insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (1, 1);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (2, 2);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (3, 3);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (4, 4);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (5, 5);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (6, 6);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (7, 7);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (8, 8);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (9, 9);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (10, 10);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (11, 11);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (12, 12);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (13, 13);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (14, 14);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (15, 15);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (16, 16);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (17, 17);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (18, 18);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (19, 19);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (20, 20);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (21, 21);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (22, 22);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (23, 23);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (24, 24);
insert into NotificacaoFimServico (cod_viagem, cod_incidente) values (25, 25);


