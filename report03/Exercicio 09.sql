create or replace trigger trg_guia_saida_atualizar_stock
after insert or update or delete on GuiaSaida
for each row

declare
    
    quantidadeEncomendada number;
    novaQuantidadeEncomendada number;
    codGuiaSaida GuiaSaida.cod_guia_saida%type;
    codArtigo Artigo.cod_artigo%type;

begin 

    if inserting then

        codGuiaSaida := :new.cod_guia_saida;

        select neza.quantidade_encomenda into quantidadeEncomendada from NotaEncomenda_Zona_Artigo neza
        where neza.cod_guia_saida = codGuiaSaida;

        select za.cod_artigo into codArtigo from NotaEncomenda_Zona_Artigo neza, Zona_Artigo za
        where neza.cod_artigo = za.cod_artigo
        and neza.cod_zona = za.cod_zona;

        update Zona_Artigo za set za.quantidade = za.quantidade - quantidadeEncomendada
        where za.cod_artigo = codArtigo;

    end if;

    if updating then

        select neza.quantidade_encomenda into quantidadeEncomendada from NotaEncomenda_Zona_Artigo neza
        where neza.cod_guia_saida = :old.cod_guia_saida;

        select neza.quantidade_encomenda into novaQuantidadeEncomendada from NotaEncomenda_Zona_Artigo neza
        where neza.cod_guia_saida = :new.cod_guia_saida;

        select za.cod_artigo into codArtigo from NotaEncomenda_Zona_Artigo neza, Zona_Artigo za
        where neza.cod_artigo = za.cod_artigo
        and neza.cod_zona = za.cod_zona;

        update Zona_Artigo za set za.quantidade = za.quantidade + quantidadeEncomendada - novaQuantidadeEncomendada
        where za.cod_artigo = codArtigo;

    end if;

    if deleting then

        codGuiaSaida := :old.cod_guia_saida;

        select neza.quantidade_encomenda into quantidadeEncomendada from NotaEncomenda_Zona_Artigo neza
        where neza.cod_guia_saida = codGuiaSaida;

        select za.cod_artigo into codArtigo from NotaEncomenda_Zona_Artigo neza, Zona_Artigo za
        where neza.cod_artigo = za.cod_artigo
        and neza.cod_zona = za.cod_zona;

        update Zona_Artigo za set za.quantidade = za.quantidade + quantidadeEncomendada
        where za.cod_artigo = codArtigo;

    end if;

end trg_guia_saida_atualizar_stock;