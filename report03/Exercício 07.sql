create or replace trigger trg_nota_encomenda_impedir_registo before insert on NotaEncomenda
for each row

declare

    numero_faturas number;
    faturas_em_atraso_exception exception;

begin

    select count(cod_fatura) into numero_faturas from Fatura f
    where f.cod_cliente = :new.cod_cliente
    and SYSDATE - data_fatura > 90 and estado='nao liquidada';

    if numero_faturas > 0 then 
        raise faturas_em_atraso_exception;
    end if;

exception
    when faturas_em_atraso_exception then DBMS_OUTPUT.PUT_LINE('EXCEPTION: Faturas em atraso com mais de 3 meses!');
        
end;
