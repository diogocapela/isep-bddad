-- 5. Implementar uma função, designada func_stock_max, para retornar o maior stock das edições doslivros
-- da livraria. Testar adequadamente a função implementada.

create or replace function func_stock_max return Edicoes_Livros.stock%type as

    c_maior_stock Edicoes_Livros.stock%type;

begin

    select max(stock) into c_maior_stock from Edicoes_Livros;
    
    return c_maior_stock;


end;


-- 6. Implementar um procedimento, designado proc_titulos_edicoes_stock_max, para listar os títulos das
-- edições dos livros que têm o maior stock. No caso de o stock ser zero, deve ser apresentada uma
-- mensagem apropriada, usando o mecanismo de exceções. Testar adequadamente o procedimento
-- implementado.

create or replace procedure proc_titulos_edicoes_stock_max as

    cursor cur_max_stock_livros is select titulo from Livros
    where id_livro in (
        select id_livro from Edicoes_Livros
        where stock in (
            select max(stock) from Edicoes_Livros
        )
    );

    c_numero_de_stock Edicoes_Livros.stock%type;
    c_titulo Livros.titulo%type;

    ex_stock_e_zero exception;

begin

    select max(stock) into c_numero_de_stock from Edicoes_Livros;

    if c_numero_de_stock = 0 then
        raise ex_stock_e_zero;
    end if;

    open cur_max_stock_livros;
    loop

        fetch cur_max_stock_livros into c_titulo;
        exit when cur_max_stock_livros%notfound;

        dbms_output.put_line('Titulo: ' || c_titulo);


    end loop;
    close cur_max_stock_livros;

    exception
    when ex_stock_e_zero then raise_application_error(-20001, 'Stock é zero');


end;



-- 7. Implementar uma função, designada func_tem_livros_editora, para verificar se existem livros de uma
-- dada editora em stock. A função deve receber, por parâmetro, o identificador da editora e tem de
-- retornar um valor booleano, true ou false. Testar adequadamente a função implementada.

create or replace function func_tem_livros_editora(
    p_id_editora Editoras.id_editora%type
) return boolean as

    c_num_livros_em_stock number;

    r_existem_livros_em_stock boolean := false;

begin

    select count(*) into c_num_livros_em_stock from Edicoes_Livros
    where id_editora = p_id_editora
    and stock > 0;
    
    if c_num_livros_em_stock > 0 then
        r_existem_livros_em_stock := true;
    end if;

    return r_existem_livros_em_stock;

end;





-- 8. Implementar uma função, designada func_stock_ano_editora, para retornar o stock dos livros editados
-- por uma dada editora num dado ano. A função deve receber, por parâmetro, o identificador da editora
-- e o ano. Este último parâmetro deve ser opcional na invocação da função e o seu valor por omissão deve
-- ser o ano atual. Se qualquer parâmetro fornecido for inválido, a função deve retornar o valor NULL.
-- Testar adequadamente a função implementada.

create or replace function func_stock_ano_editora(
    p_id_editora Editoras.id_editora%type,
    p_ano number
) return sys_refcursor as

    c_edicoes_livros Edicoes_Livros%rowtype;
    
    c_ano number;

    r_cur_stock_dos_livros sys_refcursor;

begin

    if p_id_editora = NULL then
        return NULL;
    end if;
    
    if p_ano = NULL then
        c_ano := extract(year from sysdate);
    end if;

    open r_cur_stock_dos_livros for select id_livro, stock from Edicoes_Livros where p_id_editora = id_editora and c_ano = ano_edicao;

    return r_cur_stock_dos_livros;

end;


