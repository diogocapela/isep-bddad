---atualize o valor do tipo de cliente, para todos os clientes, de acordo com o volume de negócio que efetuaram
--O período de volume de  negócios a ser considerado é o dos  12 meses anteriores. No entanto, só os clientes que foram atualizados
--há  mais de 12 meses é que podem ser atualizados.

CREATE OR REPLACE PROCEDURE proc_atualizar_tipo_cliente is

  
    data_alteracao date;
    id_fatura fatura.cod_fatura%type;
    valor_total_intermedio number;
    valor_total number;
    id_cliente1 cliente.cod_cliente%type;
    id_cliente cliente.cod_cliente%type;
    valor_min number(10);
    valor_max number(10);
    id_tipo_cliente cliente.cod_tipo_cliente%type;
    cursor todos_clientes is select cod_cliente from cliente where data_ultima_alteracao<sysdate-365;
   cursor todos_clientes_ola is select cod_cliente from cliente where data_ultima_alteracao<sysdate-365;

Begin
    
    
    
    open todos_clientes_ola;
    loop 
        fetch todos_clientes_ola into id_cliente1;
       
        select count(cod_fatura) into valor_total from fatura  where cod_cliente in id_cliente1;
        if valor_total!=0 then
             select cod_fatura into id_fatura from fatura  where cod_cliente in id_cliente1;

            select sum(quantia) into valor_total_intermedio from pagamento where cod_fatura=id_fatura and data_pagamento>sysdate-365;
            valor_total:=valor_total+valor_total_intermedio;
    
        
            select cod_tipo_cliente into id_tipo_cliente from cliente where cod_cliente in id_cliente1;
            
            select lim_min into valor_min from tipocliente 
            where cod_tipo_cliente=id_tipo_cliente;
            
            select lim_max into valor_max from tipocliente 
            where cod_tipo_cliente=id_tipo_cliente;
            
        
            if valor_total<valor_min then
                update cliente set cod_tipo_cliente= id_tipo_cliente-1 where cod_cliente in id_cliente1;
                update cliente set data_ultima_alteracao= sysdate where cod_cliente in id_cliente1;
            else
                if valor_total>valor_max then
                    update cliente set cod_tipo_cliente= id_tipo_cliente+1 where cod_cliente in id_cliente1;
                    update cliente set data_ultima_alteracao= sysdate where cod_cliente in id_cliente1;
                end if;
            end if;
        end if;
        EXIT WHEN todos_clientes%NOTFOUND;
    end loop;
    close todos_clientes_ola;

end;
