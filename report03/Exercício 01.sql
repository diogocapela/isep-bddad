set serveroutput on;
--retornar a quantidade total  de um artigo num determinado armazém. A função tem como parâmetros, o identificador do artigo 
--e o identificador do armazém. No caso de o identificador do artigo ou do armazém não existir na BD, a função deve retornar o valor NULL.

create or replace FUNCTION func_stock_article_warehouse(id_artigo in Artigo.cod_artigo%type, id_armazem in Armazem.cod_armazem%type)
RETURN NUMBER
is 
total_artigo NUMBER(10):=0;
numero1 number;
numero number;
BEGIN

select count(id_armazem) into numero from Armazem where id_armazem = cod_armazem;

if numero=0 then total_artigo:=0;
    else
        select count(*) into numero1 from artigo 
        where id_artigo=cod_artigo;

    if numero=0 then total_artigo:=0;
        else
            select sum(quantidade) into total_artigo from zona_artigo
            where cod_artigo=id_artigo and cod_zona in (select cod_zona from zona where cod_armazem=id_armazem);
            
            if total_artigo=0 then total_artigo:=0;
            end if;
    end if;
end if;
return total_artigo;
end;
