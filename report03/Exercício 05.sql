-- Procedure

create or replace procedure proc_tratar_nota_encomenda(p_cod_nota_encomenda NotaEncomenda.cod_nota_encomenda%type) is

    parametro_invalido_exception exception;
    quantidade_invalida_exception exception;

    nota_encomenda_count number;
    codArtigo NotaEncomenda_Zona_Artigo.cod_artigo%type;
    codZona NotaEncomenda_Zona_Artigo.cod_zona%type;
    quantidadeEncomendada NotaEncomenda_Zona_Artigo.quantidade_encomenda%type;
    quantiadadeExistente NotaEncomenda_Zona_Artigo.quantidade_encomenda%type;

begin

    -- get the number of results
    select count(*) into nota_encomenda_count from NotaEncomenda ne
    where ne.cod_nota_encomenda = p_cod_nota_encomenda;

    -- if there are less than 1 result, it means the inputted parameter was
    -- invalid, if so raise and exeption with a readable message
    if nota_encomenda_count < 1 then
        raise parametro_invalido_exception;
    end if;

    -- get quantidadeEncomendada
    select neza.quantidade_encomenda into quantidadeEncomendada from NotaEncomenda ne, NotaEncomenda_Zona_Artigo neza
    where ne.cod_nota_encomenda = p_cod_nota_encomenda
    and neza.cod_nota_encomenda = p_cod_nota_encomenda;

    -- get codArtigo
    select neza.cod_artigo into codArtigo from NotaEncomenda ne, NotaEncomenda_Zona_Artigo neza
    where ne.cod_nota_encomenda = p_cod_nota_encomenda
    and neza.cod_nota_encomenda = p_cod_nota_encomenda;

    -- get codZona
    select neza.cod_zona into codZona from NotaEncomenda ne, NotaEncomenda_Zona_Artigo neza
    where ne.cod_nota_encomenda = p_cod_nota_encomenda
    and neza.cod_nota_encomenda = p_cod_nota_encomenda;

    -- get quantiadadeExistente
    select neza.quantidade_encomenda into quantiadadeExistente from Zona_Artigo za, NotaEncomenda_Zona_Artigo neza
    where za.cod_artigo = codArtigo
    and za.cod_zona = codZona
    and neza.cod_nota_encomenda = p_cod_nota_encomenda;

    if quantiadadeExistente - quantidadeEncomendada < 0 then
        raise quantidade_invalida_exception;
    end if;

    -- update armazem
    update Zona_Artigo za set za.quantidade = quantiadadeExistente - quantidadeEncomendada
    where za.cod_artigo = codArtigo
    and za.cod_zona = codZona;

    -- update estado nota encomenda
    update NotaEncomenda ne set ne.estado = 'processada'
    where ne.cod_nota_encomenda = p_cod_nota_encomenda;

exception

    when parametro_invalido_exception then DBMS_OUTPUT.PUT_LINE('EXCEPTION: Código de nota de encomenda inválido!');
    when quantidade_invalida_exception then DBMS_OUTPUT.PUT_LINE('EXCEPTION: Não existe quantidade suficiente para a compra!');

end proc_tratar_nota_encomenda;

-- Test

set serveroutput on;
declare
begin
    proc_tratar_nota_encomenda(22);
end;

