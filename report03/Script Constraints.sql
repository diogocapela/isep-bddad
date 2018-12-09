ALTER TABLE ZonaGeografica ADD CONSTRAINT unique_coordenadas UNIQUE(
  coordenada_semi_major_axis_a,
  coordenada_semi_major_axis_b,
  coordenada_inverse_flattening
);

ALTER TABLE Zona ADD CONSTRAINT ck_zona_capacidade CHECK(
  capacidade >= 0
);

ALTER TABLE Armazem_Artigo ADD CONSTRAINT ck_armazem_artigo_quantidades CHECK(
  quantidade_stock_minimo > 0 AND
  quantidade_stock > 0
);

ALTER TABLE NotaEncomenda ADD CONSTRAINT ck_nota_encomenda_estado CHECK(
  estado = 'pendente' OR
  estado = 'a caminho' OR
  estado = 'entregue' OR
  estado = 'cancelado'
);

ALTER TABLE Veiculo ADD CONSTRAINT ck_veiculo_numero_kilometros CHECK(
  numero_kilometros >= 0
);

ALTER TABLE Veiculo ADD CONSTRAINT ck_Veiculo_disponibilidade CHECK(
  disponibilidade = 'S' OR
  disponibilidade = 'N'
);

ALTER TABLE Empregado ADD CONSTRAINT ck_Empregado_nif CHECK(
  nif >= 100000000 OR
  nif <= 999999999
);

ALTER TABLE Cliente ADD CONSTRAINT ck_Cliente_nif CHECK(
  nif >= 100000000 OR
  nif <= 999999999
);

ALTER TABLE Cliente ADD CONSTRAINT ck_Cliente_telemovel CHECK(
  telemovel >= 100000000 OR
  telemovel <= 999999999
);

ALTER TABLE Empregado ADD CONSTRAINT ck_Empregado_cartaoCidadao CHECK(
  cartao_cidadao >= 100000000 OR
  cartao_cidadao <= 999999999
);
