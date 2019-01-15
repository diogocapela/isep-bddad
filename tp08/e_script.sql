-- 1

create or replace procedure listar_reposicao_de_stock(p_cod_armazem Armazem.cod_armazem%type)
as

    cursor cur_produtos is (select cod_produto, stock, stock_minimo from ArmazemProduto where p_cod_armazem = cod_armazem);

    c_produto ArmazemProduto.cod_produto%type;
    c_stock ArmazemProduto.stock%type;
    c_stock_minimo ArmazemProduto.stock_minimo%type;

    c_stock_a_encomendar ArmazemProduto.stock%type;

    armazem_existe number;

    ex_armaze_inexistente exception;
    ex_vendas_reduzidas exception;

begin

    select count(*) into armazem_existe
    from ArmazemProduto where cod_armazem = p_cod_armazem;

    if armazem_existe = 0 then
        raise ex_armaze_inexistente;
    end if;


    open cur_produtos;
    loop
        fetch cur_produtos into c_produto, c_stock, c_stock_minimo;
        exit when cur_produtos%notfound;

        c_stock_a_encomendar := (12 * c_stock_minimo) - c_stock;

        dbms_output.put_line(c_produto || ' / ' ||c_stock_a_encomendar);
    end loop;
    close cur_produtos;



    exception
    when ex_vendas_reduzidas then raise_application_error(-20002, 'Vendas reduzidas!');
    when ex_armaze_inexistente then raise_application_error(-20001, 'Armazem inexistente');


end;





-- 2

create or replace procedure listar_produtos as

    cursor cur_armazens is select cod_armazem from Armazem;
    cursor cur_produtos_do_armazem(p_cod_armazem Armazem.cod_armazem%type) is select cod_produto, stock from ArmazemProduto where p_cod_armazem = cod_armazem;
    
    c_cod_armazem Armazem.cod_armazem%type;
    c_cod_produto Produto.cod_produto%type;
    c_stock ArmazemProduto.stock%type;

    
begin

    open cur_armazens;
    loop
        fetch cur_armazens into c_cod_armazem;
        exit when cur_armazens%notfound;
        
        open cur_produtos_do_armazem(c_cod_armazem);
        loop
        
            fetch cur_produtos_do_armazem into c_cod_produto, c_stock;
            exit when cur_produtos_do_armazem%notfound;
            
            dbms_output.put_line('A: ' || c_cod_armazem || 'PROD: ' || c_cod_produto || 'QNT: ' || c_stock);
            
        end loop;
        close cur_produtos_do_armazem;
        
    
    end loop;
    close cur_armazens;

end;