-- 4. Criar um script com código PL/SQL que implemente um bloco anónimo para mostrar a quantidade de
-- edições de livros de uma dada editora. A existência da editora na BD deve ser efetuada recorrendo à
-- estrutura de decisão IF-THEN-ELSE. Caso não se verifique a existência da editora deve ser apresentada
-- uma mensagem apropriada. Testar adequadamente o bloco anónimo implementado. Para visualizar o
-- resultado, executar o comando SET SERVEROUTPUT ON.

set serveroutput on;

declare

    p_id_editora Editoras.id_editora%type := 1500;

    c_editora_existe number;
    c_quantidade_edicoes_livros number;

begin

    select count(*) into c_editora_existe from Editoras where id_editora = p_id_editora;
    
    if c_editora_existe = 0 then
        raise_application_error(-20001, 'Editora não existe');
    end if;
    
    
    select count(*) into c_quantidade_edicoes_livros from Edicoes_Livros where id_editora = p_id_editora;
    
    dbms_output.put_line(c_quantidade_edicoes_livros);

end;


-- 5. Criar um novo script PL/SQL que implemente um bloco anónimo para mostrar o stock e o stock mínimo
-- de uma edição de um dado livro. A existência da edição do livro na BD deve ser efetuada recorrendo ao
-- mecanismo de exceções. Caso não se verifique a existência da edição do livro deve ser apresentada uma
-- mensagem apropriada. Testar adequadamente o bloco anónimo implementado.

declare
    
    p_isbn Edicoes_Livros.isbn%type := '500-1234567891';
    
    c_edicao_existe number;
    c_stock Edicoes_Livros.stock%type;
    c_stock_min Edicoes_Livros.stock_min%type;
    
    ex_edicao_nao_existe exception;
    
begin
    
    select count(*) into c_edicao_existe from Edicoes_Livros where p_isbn = isbn;
    
    if c_edicao_existe = 0 then
        raise ex_edicao_nao_existe;
    end if;

    select stock, stock_min into c_stock, c_stock_min from Edicoes_Livros where p_isbn = isbn;
    
    dbms_output.put_line('Stock: ' || c_stock || ' Min: ' || c_stock_min);
    
    exception
    when ex_edicao_nao_existe then raise_application_error(-20001, 'Edição nao existe');

end;


-- 6. Criar um novo script PL/SQL que implemente um bloco anónimo para listar o identificador e o nome de
-- todos os autores. A listagem deve ter o formato ilustrado na Figura 2. O bloco deve recorrer a um
-- CURSOR explícito e às instruções OPEN, FETCH e CLOSE para processar o CURSOR.


declare

    cursor cur_get_autores is (select id_autor, nome from Autores);
    
    c_id_autor Autores.id_autor%type;
    c_nome Autores.nome%type;
    c_count number := 0;

begin

    dbms_output.put_line('ID' || '     ' || 'NOME');
    dbms_output.put_line('-----------------------------------');

    open cur_get_autores;
    loop
        
        fetch cur_get_autores into c_id_autor, c_nome;
        exit when cur_get_autores%notfound;
        
        c_count := c_count + 1;
        
        dbms_output.put_line(c_count || '     '  || c_id_autor || '     ' || c_nome);
        
    
    end loop;
    close cur_get_autores;


end;

-- 9. Criar um novo script PL/SQL que implemente um bloco anónimo para listar a quantidade de edições de
-- livros vendidos mensalmente por uma dada editora, num dado ano. A listagem deve ter o formato
-- apresentado na Figura 3. Caso a editora não exista na BD ou o ano seja igual ou superior ao ano atual,
-- deve ser apresentada uma mensagem apropriada. O bloco deve usar um CURSOR com parâmetros para
-- receber um identificador de uma editora, um ano e um mês (valor numérico)

declare

    p_id_editora Editoras.id_editora%type := 1500;
    p_ano Edicoes_Livros.ano_edicao%type := 2016;
    
    cursor cur_edicoes_vendidas_no_ano(i_id_editora Editoras.id_editora%type, i_ano Edicoes_Livros.ano_edicao%type, i_mes number) is
    select count(isbn) from Vendas
    where i_ano = extract(year from data_hora)
    and i_mes = extract(month from data_hora)
    and isbn in (select isbn from Edicoes_Livros where i_id_editora = id_editora);



    c_quantidade_no_mes number;
    c_mes number := 1;
    

begin


    loop
        exit when c_mes = 13;
    
        open cur_edicoes_vendidas_no_ano(p_id_editora, p_ano, c_mes);
        loop
            fetch cur_edicoes_vendidas_no_ano into c_quantidade_no_mes;
            exit when cur_edicoes_vendidas_no_ano%notfound;
            
            dbms_output.put_line(c_mes || '     ' || c_quantidade_no_mes);
        
        end loop;
        close cur_edicoes_vendidas_no_ano;

        c_mes := c_mes + 1;
    end loop;


end;



-- 10. Criar um novo script PL/SQL que implemente um bloco anónimo para adicionar 5€ ao saldo atual e ao
-- saldo acumulado dos cartões de clientes com mais de 10 anos. O bloco deve mostrar a quantidade de
-- cartões atualizados e confirmar a transação realizada através do comando COMMIT. Este comando
-- permite tornar persistentes as modificações feitas na BD.

declare

    cursor cur_cartoes_clientes is (select saldo_atual, saldo_acumulado, data_adesao from Cartoes_Clientes);
    
    c_saldo_atual Cartoes_Clientes.saldo_atual%type;
    c_saldo_acumulado Cartoes_Clientes.saldo_acumulado%type;
    c_data_adesao Cartoes_Clientes.data_adesao%type;
    
    c_quantidade_cartoes_actualizados number := 0;

begin

    open cur_cartoes_clientes;
    loop
    
        fetch cur_cartoes_clientes into c_saldo_atual, c_saldo_acumulado, c_data_adesao;
        exit when cur_cartoes_clientes%notfound;
        
        if (extract(year from sysdate) - extract(year from c_data_adesao)) > 10 then
            c_saldo_atual := c_saldo_atual + 5;
            c_saldo_acumulado := c_saldo_acumulado + 5;
            
            c_quantidade_cartoes_actualizados := c_quantidade_cartoes_actualizados + 1;
            
            update Cartoes_Clientes set saldo_atual = c_saldo_atual, saldo_acumulado = c_saldo_acumulado;
        end if;
    

    end loop;
    close cur_cartoes_clientes;
    
    dbms_output.put_line('Cartoes actualizados: ' || c_quantidade_cartoes_actualizados);

end;


-- 10. Criar um novo script PL/SQL que implemente um bloco anónimo para adicionar 5€ ao saldo atual e ao
-- saldo acumulado dos cartões de clientes com mais de 10 anos. O bloco deve mostrar a quantidade de
-- cartões atualizados e confirmar a transação realizada através do comando COMMIT. Este comando
-- permite tornar persistentes as modificações feitas na BD.

declare

    cursor cur_cartoes_clientes is select nr_cartao from Cartoes_Clientes where (sysdate - data_adesao) > (10 * 365);
    
    c_numero_de_cartao Cartoes_Clientes.nr_cartao%type;
    
    c_quantidade_cartoes_actualizados number := 0;

begin

    open cur_cartoes_clientes;
    loop
    
        fetch cur_cartoes_clientes into c_numero_de_cartao;
        exit when cur_cartoes_clientes%notfound;
            

        
        update Cartoes_Clientes set
        saldo_atual = saldo_atual + 5,
        saldo_acumulado = saldo_acumulado + 5
        where nr_cartao = c_numero_de_cartao;
        
        c_quantidade_cartoes_actualizados := c_quantidade_cartoes_actualizados + 1;

    end loop;
    close cur_cartoes_clientes;
    
    commit;
    dbms_output.put_line('Cartoes actualizados: ' || c_quantidade_cartoes_actualizados);

end;