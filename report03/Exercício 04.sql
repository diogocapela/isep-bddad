
--isto testa
set serveroutput on;
Declare

Begin

proc_faturas_nao_liquidadas(to_date('2018/01/01', 'yyyy/mm/dd'),to_date('2018/12/12', 'yyyy/mm/dd'));
End;


--isto é o procedure 



--realizar uma listagem com as faturas, de um dado período de tempo,que ainda não foram liquidadas

-- Deve  ser  apresentada  informação (identificador, data de faturação e valor total) das faturas em falta de cada cliente, ordenada pela 
--data de faturação,bem como o subtotal a liquidar por cliente.

-- Deve ser apresentado o total de todas as faturas, de todos os que clientes, que faltam ser liquidadas à IsepBricolage.
--realizar uma listagem com as faturas, de um dado período de tempo,que ainda não foram liquidadas

-- Deve  ser  apresentada  informação (identificador, data de faturação e valor total) das faturas em falta de cada cliente, ordenada pela 
--data de faturação,bem como o subtotal a liquidar por cliente.

-- Deve ser apresentado o total de todas as faturas, de todos os que clientes, que faltam ser liquidadas à IsepBricolage.
CREATE OR REPLACE PROCEDURE proc_faturas_nao_liquidadas(data_inicio date, data_fim date) IS

    counter number(10);
    id_fatura Fatura.cod_fatura%type;
    data_1 date;
    valor_total number(10, 2);
    subtotal_liquidar number(10,2); 
    total_faturas_por_liquidar integer;
    id_cliente cliente.cod_cliente%type;
    id_cliente_temp cliente.cod_cliente%type;
    
    cursor cursor_faturas_nao_liquidadas1  is select cod_fatura from Fatura where etapa = 'nao liquidada' 
        and data_fatura>data_inicio;
        
    cursor cursor_faturas_nao_liquidadas2 is select cod_fatura from Fatura where etapa = 'nao liquidada' 
        and data_fatura>data_inicio and data_fatura<data_fim;
        
    cursor faturas_clientes is select cod_cliente from cliente;
  

Begin 
    DBMS_OUTPUT.PUT_LINE('merda');
    
        open cursor_faturas_nao_liquidadas1;
            LOOP
                FETCH cursor_faturas_nao_liquidadas1 INTO id_fatura;
                counter:=counter+1;
                EXIT WHEN cursor_faturas_nao_liquidadas1%NOTFOUND;
                 DBMS_OUTPUT.PUT_LINE(id_fatura);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('total de faturas é' || counter);
        close cursor_faturas_nao_liquidadas1;
    
    open faturas_clientes;
        LOOP
        FETCH faturas_clientes into id_cliente;
          EXIT WHEN faturas_clientes%NOTFOUND;
              DBMS_OUTPUT.PUT_LINE('id_cliente' || id_cliente); 
                select count(cod_fatura) into valor_total from fatura 
                where cod_cliente=id_cliente 
                and data_fatura>data_inicio and data_fatura<data_fim
                and etapa='nao liquidada';
                if valor_total!= 0 then
                     select cod_fatura into id_fatura from fatura 
                    where cod_cliente=id_cliente 
                    and data_fatura>data_inicio and data_fatura<data_fim
                    and etapa='nao liquidada';
                     DBMS_OUTPUT.PUT_LINE('cod_fatura' || id_fatura);
                     select sum(quantia) into valor_total from pagamento where cod_fatura=id_fatura;
                     DBMS_OUTPUT.PUT_LINE('valor total ' || valor_total);
                end if;
                 
                  select count(data_fatura) into valor_total from fatura 
                where cod_cliente=id_cliente 
                and etapa='nao liquidada'
                and data_fatura>data_inicio and data_fatura<data_fim;
                
                if valor_total!=0 then
                    select data_fatura into data_1 from fatura 
                    where cod_cliente=id_cliente 
                    and etapa='nao liquidada'
                    and data_fatura>data_inicio and data_fatura<data_fim;
                     DBMS_OUTPUT.PUT_LINE('data faturacao' || data_1);
                 end if;
               
        end loop;
    close faturas_clientes;
        
END;
            









