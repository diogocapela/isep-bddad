DROP TABLE Armazem CASCADE CONSTRAINTS;
DROP TABLE Armazem_Artigo CASCADE CONSTRAINTS;
DROP TABLE Artigo CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE CodigoPostal CASCADE CONSTRAINTS;
DROP TABLE Empregado CASCADE CONSTRAINTS;
DROP TABLE Etapa CASCADE CONSTRAINTS;
DROP TABLE Fatura CASCADE CONSTRAINTS;
DROP TABLE FielArmazem CASCADE CONSTRAINTS;
DROP TABLE GuiaSaidaArtigos CASCADE CONSTRAINTS;
DROP TABLE GuiaTransporte CASCADE CONSTRAINTS;
DROP TABLE Incidente CASCADE CONSTRAINTS;
DROP TABLE Marca CASCADE CONSTRAINTS;
DROP TABLE Modelo CASCADE CONSTRAINTS;
DROP TABLE Motorista CASCADE CONSTRAINTS;
DROP TABLE NotaEncomenda CASCADE CONSTRAINTS;
DROP TABLE NotaEncomenda_Zona_Artigo CASCADE CONSTRAINTS;
DROP TABLE NotificacaoFimServico CASCADE CONSTRAINTS;
DROP TABLE Pagamento CASCADE CONSTRAINTS;
DROP TABLE PrecoArtigo CASCADE CONSTRAINTS;
DROP TABLE TipoCliente CASCADE CONSTRAINTS;
DROP TABLE TipoVeiculo CASCADE CONSTRAINTS;
DROP TABLE Veiculo CASCADE CONSTRAINTS;
DROP TABLE Vendedor CASCADE CONSTRAINTS;
DROP TABLE Viagem CASCADE CONSTRAINTS;
DROP TABLE Zona CASCADE CONSTRAINTS;
DROP TABLE Zona_Artigo CASCADE CONSTRAINTS;
DROP TABLE ZonaGeografica CASCADE CONSTRAINTS;

CREATE TABLE Armazem (
  cod_armazem         number(10) GENERATED AS IDENTITY, 
  cod_zona_geografica number(10) NOT NULL, 
  nome                varchar2(255) NOT NULL, 
  morada              varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_armazem)
);

CREATE TABLE Armazem_Artigo (
  cod_armazem             number(10) NOT NULL, 
  cod_artigo              number(10) NOT NULL, 
  quantidade_stock_minimo number(10) NOT NULL, 
  quantidade_stock        number(10) NOT NULL, 
  PRIMARY KEY (cod_armazem, cod_artigo)
);

CREATE TABLE Artigo (
  cod_artigo            number(10) GENERATED AS IDENTITY, 
  nome                  varchar2(255) NOT NULL, 
  descricao             varchar2(255), 
  unidade_representacao varchar2(255), 
  PRIMARY KEY (cod_artigo)
);

CREATE TABLE Cliente (
  cod_cliente         number(10) GENERATED AS IDENTITY, 
  cod_zona_geografica number(10) NOT NULL, 
  cod_codigo_postal   varchar2(255) NOT NULL, 
  cod_tipo_cliente    number(10) NOT NULL, 
  nome                varchar2(255) NOT NULL, 
  morada              varchar2(255) NOT NULL, 
  telemovel           number(9) NOT NULL, 
  nif                 number(9) NOT NULL UNIQUE, 
  PRIMARY KEY (cod_cliente)
);

CREATE TABLE CodigoPostal (
  cod_codigo_postal varchar2(255) NOT NULL, 
  localidade        varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_codigo_postal)
);

CREATE TABLE Empregado (
  cod_empregado  number(10) GENERATED AS IDENTITY, 
  cod_supervisor number(10) NOT NULL, 
  cod_armazem    number(10) NOT NULL, 
  cartao_cidado  number(9) NOT NULL UNIQUE, 
  nome           varchar2(255) NOT NULL, 
  morada         varchar2(255) NOT NULL, 
  nif            number(9) NOT NULL UNIQUE, 
  salario_mensal number(10, 2) NOT NULL, 
  idade          number(3) NOT NULL, 
  PRIMARY KEY (cod_empregado)
);

CREATE TABLE Etapa (
  cod_etapa   number(10) GENERATED AS IDENTITY, 
  cod_viagem  number(10) NOT NULL, 
  cod_cliente number(10) NOT NULL, 
  PRIMARY KEY (cod_etapa)
);

CREATE TABLE Fatura (
  cod_fatura    number(10) GENERATED AS IDENTITY, 
  cod_empregado number(10) NOT NULL, 
  cod_cliente   number(10) NOT NULL, 
  data          date NOT NULL, 
  PRIMARY KEY (cod_fatura)
);

CREATE TABLE FielArmazem (
  cod_empregado number(10) NOT NULL, 
  PRIMARY KEY (cod_empregado)
);

CREATE TABLE GuiaSaidaArtigos (
  id_guia_saida_aritgos number(10) GENERATED AS IDENTITY, 
  cod_nota_encomenda    number(10) NOT NULL, 
  cod_guia_transporte   number(10) NOT NULL, 
  PRIMARY KEY (id_guia_saida_aritgos)
);

CREATE TABLE GuiaTransporte (
  cod_guia_transporte number(10) GENERATED AS IDENTITY, 
  cod_viagem          number(10) NOT NULL, 
  PRIMARY KEY (cod_guia_transporte)
);

CREATE TABLE Incidente (
  cod_incidente number(10) GENERATED AS IDENTITY, 
  tipo          varchar2(255) NOT NULL, 
  descricao     varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_incidente)
);

CREATE TABLE Marca (
  cod_marca  number(10) GENERATED AS IDENTITY, 
  nome_marca varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_marca)
);

CREATE TABLE Modelo (
  cod_modelo        number(10) GENERATED AS IDENTITY, 
  cod_marca         number(10) NOT NULL, 
  cod_tipo          number(10) NOT NULL, 
  nome_modelo       varchar2(255) NOT NULL, 
  capacidade_peso   number(10, 2) NOT NULL, 
  capacidade_volume number(10, 2) NOT NULL, 
  PRIMARY KEY (cod_modelo)
);

CREATE TABLE Motorista (
  cod_empregado number(10) NOT NULL, 
  PRIMARY KEY (cod_empregado)
);

CREATE TABLE NotaEncomenda (
  cod_nota_encomenda number(10) GENERATED AS IDENTITY, 
  cod_cliente        number(10) NOT NULL, 
  cod_empregado      number(10), 
  cod_fatura         number(10) NOT NULL, 
  data               date NOT NULL, 
  estado             varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_nota_encomenda)
);

CREATE TABLE NotaEncomenda_Zona_Artigo (
  cod_nota_encomenda   number(10) NOT NULL, 
  cod_artigo           number(10) NOT NULL, 
  cod_zona             number(10) NOT NULL, 
  quantidade_encomenda number(10) NOT NULL, 
  iva                  number(3, 2) NOT NULL, 
  desconto             number(3, 2), 
  PRIMARY KEY (cod_nota_encomenda, 
  cod_artigo, 
  cod_zona)
);

CREATE TABLE NotificacaoFimServico (
  cod_viagem    number(10) NOT NULL, 
  cod_incidente number(10), 
  PRIMARY KEY (cod_viagem)
);

CREATE TABLE Pagamento (
  cod_pagamento number(10) GENERATED AS IDENTITY, 
  cod_fatura    number(10) NOT NULL, 
  data          date NOT NULL, 
  quantia       number(10, 2) NOT NULL, 
  metodo        varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_pagamento)
);

CREATE TABLE PrecoArtigo (
  cod_artigo   number(10) NOT NULL, 
  data_inicio  date NOT NULL, 
  data_fim     date NOT NULL, 
  preco_venda  number(10, 2) NOT NULL, 
  preco_compra number(10, 2) NOT NULL, 
  PRIMARY KEY (cod_artigo, data_inicio)
);

CREATE TABLE TipoCliente (
  cod_tipo_cliente number(10) GENERATED AS IDENTITY, 
  lim_min          number(10, 2) NOT NULL, 
  lim_max          number(10, 2) NOT NULL, 
  tipo             varchar2(255) NOT NULL, 
  PRIMARY KEY (cod_tipo_cliente)
);

CREATE TABLE TipoVeiculo (
  cod_tipo        number(10) GENERATED AS IDENTITY, 
  numero_de_eixos number(2) NOT NULL, 
  PRIMARY KEY (cod_tipo)
);

CREATE TABLE Veiculo (
  matricula             varchar2(255) NOT NULL, 
  cod_modelo            number(10) NOT NULL, 
  numero_apolice_seguro varchar2(255) NOT NULL, 
  numero_kilometros     number(10, 2) NOT NULL, 
  disponibilidade       char(255) NOT NULL, 
  PRIMARY KEY (matricula)
);

CREATE TABLE Vendedor (
  cod_empregado number(10) NOT NULL, 
  PRIMARY KEY (cod_empregado)
);

CREATE TABLE Viagem (
  cod_viagem                number(10) GENERATED AS IDENTITY, 
  cod_armazem_origem        number(10) NOT NULL, 
  cod_empregado             number(10) NOT NULL, 
  matricula                 varchar2(255) NOT NULL, 
  data_partida              date NOT NULL, 
  capacidade_peso_ocupada   number(10, 2) NOT NULL, 
  capacidade_volume_ocupada number(10, 2) NOT NULL, 
  PRIMARY KEY (cod_viagem)
);

CREATE TABLE Zona (
  cod_zona    number(10) GENERATED AS IDENTITY, 
  cod_armazem number(10) NOT NULL, 
  capacidade  number(10) NOT NULL, 
  PRIMARY KEY (cod_zona)
);

CREATE TABLE Zona_Artigo (
  cod_artigo number(10) NOT NULL, 
  cod_zona   number(10) NOT NULL, 
  quantidade number(10) NOT NULL, 
  PRIMARY KEY (cod_artigo, cod_zona)
);

CREATE TABLE ZonaGeografica (
  cod_zona_geografica           number(10) GENERATED AS IDENTITY, 
  coordenada_semi_major_axis_a  number(10, 4) NOT NULL, 
  coordenada_semi_major_axis_b  number(10, 4) NOT NULL, 
  coordenada_inverse_flattening number(10, 4) NOT NULL, 
  PRIMARY KEY (cod_zona_geografica)
);

ALTER TABLE Zona ADD CONSTRAINT FKZona299567 FOREIGN KEY (cod_armazem) REFERENCES Armazem (cod_armazem);
ALTER TABLE Zona_Artigo ADD CONSTRAINT FKZona_Artig925519 FOREIGN KEY (cod_artigo) REFERENCES Artigo (cod_artigo);
ALTER TABLE Zona_Artigo ADD CONSTRAINT FKZona_Artig624574 FOREIGN KEY (cod_zona) REFERENCES Zona (cod_zona);
ALTER TABLE Armazem_Artigo ADD CONSTRAINT FKArmazem_Ar546241 FOREIGN KEY (cod_armazem) REFERENCES Armazem (cod_armazem);
ALTER TABLE Armazem_Artigo ADD CONSTRAINT FKArmazem_Ar965924 FOREIGN KEY (cod_artigo) REFERENCES Artigo (cod_artigo);
ALTER TABLE PrecoArtigo ADD CONSTRAINT FKPrecoArtig60569 FOREIGN KEY (cod_artigo) REFERENCES Artigo (cod_artigo);
ALTER TABLE Empregado ADD CONSTRAINT FKEmpregado984498 FOREIGN KEY (cod_supervisor) REFERENCES Empregado (cod_empregado);
ALTER TABLE Empregado ADD CONSTRAINT FKEmpregado270397 FOREIGN KEY (cod_armazem) REFERENCES Armazem (cod_armazem);
ALTER TABLE Armazem ADD CONSTRAINT FKArmazem901526 FOREIGN KEY (cod_zona_geografica) REFERENCES ZonaGeografica (cod_zona_geografica);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente746533 FOREIGN KEY (cod_zona_geografica) REFERENCES ZonaGeografica (cod_zona_geografica);
ALTER TABLE NotaEncomenda ADD CONSTRAINT FKNotaEncome867331 FOREIGN KEY (cod_cliente) REFERENCES Cliente (cod_cliente);
ALTER TABLE NotaEncomenda_Zona_Artigo ADD CONSTRAINT FKNotaEncome509242 FOREIGN KEY (cod_nota_encomenda) REFERENCES NotaEncomenda (cod_nota_encomenda);
ALTER TABLE GuiaSaidaArtigos ADD CONSTRAINT FKGuiaSaidaA566783 FOREIGN KEY (cod_nota_encomenda) REFERENCES NotaEncomenda (cod_nota_encomenda);
ALTER TABLE Viagem ADD CONSTRAINT FKViagem703870 FOREIGN KEY (matricula) REFERENCES Veiculo (matricula);
ALTER TABLE Viagem ADD CONSTRAINT FKViagem922866 FOREIGN KEY (cod_armazem_origem) REFERENCES Armazem (cod_armazem);
ALTER TABLE Etapa ADD CONSTRAINT FKEtapa603481 FOREIGN KEY (cod_viagem) REFERENCES Viagem (cod_viagem);
ALTER TABLE Etapa ADD CONSTRAINT FKEtapa842788 FOREIGN KEY (cod_cliente) REFERENCES Cliente (cod_cliente);
ALTER TABLE GuiaSaidaArtigos ADD CONSTRAINT FKGuiaSaidaA221439 FOREIGN KEY (cod_guia_transporte) REFERENCES GuiaTransporte (cod_guia_transporte);
ALTER TABLE GuiaTransporte ADD CONSTRAINT FKGuiaTransp783331 FOREIGN KEY (cod_viagem) REFERENCES Viagem (cod_viagem);
ALTER TABLE NotificacaoFimServico ADD CONSTRAINT FKNotificaca249239 FOREIGN KEY (cod_viagem) REFERENCES Viagem (cod_viagem);
ALTER TABLE NotificacaoFimServico ADD CONSTRAINT FKNotificaca548387 FOREIGN KEY (cod_incidente) REFERENCES Incidente (cod_incidente);
ALTER TABLE Fatura ADD CONSTRAINT FKFatura77681 FOREIGN KEY (cod_cliente) REFERENCES Cliente (cod_cliente);
ALTER TABLE NotaEncomenda ADD CONSTRAINT FKNotaEncome46586 FOREIGN KEY (cod_fatura) REFERENCES Fatura (cod_fatura);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente676409 FOREIGN KEY (cod_codigo_postal) REFERENCES CodigoPostal (cod_codigo_postal);
ALTER TABLE NotaEncomenda_Zona_Artigo ADD CONSTRAINT FKNotaEncome556479 FOREIGN KEY (cod_artigo, cod_zona) REFERENCES Zona_Artigo (cod_artigo, cod_zona);
ALTER TABLE Modelo ADD CONSTRAINT FKModelo698288 FOREIGN KEY (cod_marca) REFERENCES Marca (cod_marca);
ALTER TABLE Veiculo ADD CONSTRAINT FKVeiculo712884 FOREIGN KEY (cod_modelo) REFERENCES Modelo (cod_modelo);
ALTER TABLE Pagamento ADD CONSTRAINT FKPagamento522534 FOREIGN KEY (cod_fatura) REFERENCES Fatura (cod_fatura);
ALTER TABLE FielArmazem ADD CONSTRAINT FKFielArmaze367226 FOREIGN KEY (cod_empregado) REFERENCES Empregado (cod_empregado);
ALTER TABLE Motorista ADD CONSTRAINT FKMotorista34902 FOREIGN KEY (cod_empregado) REFERENCES Empregado (cod_empregado);
ALTER TABLE Modelo ADD CONSTRAINT FKModelo738831 FOREIGN KEY (cod_tipo) REFERENCES TipoVeiculo (cod_tipo);
ALTER TABLE Cliente ADD CONSTRAINT FKCliente488635 FOREIGN KEY (cod_tipo_cliente) REFERENCES TipoCliente (cod_tipo_cliente);
ALTER TABLE Viagem ADD CONSTRAINT FKViagem215760 FOREIGN KEY (cod_empregado) REFERENCES Motorista (cod_empregado);
ALTER TABLE Vendedor ADD CONSTRAINT FKVendedor924981 FOREIGN KEY (cod_empregado) REFERENCES Empregado (cod_empregado);
ALTER TABLE Fatura ADD CONSTRAINT FKFatura450505 FOREIGN KEY (cod_empregado) REFERENCES Vendedor (cod_empregado);
ALTER TABLE NotaEncomenda ADD CONSTRAINT FKNotaEncome477083 FOREIGN KEY (cod_empregado) REFERENCES Vendedor (cod_empregado);
