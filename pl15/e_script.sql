set serveroutput on

-- 5. Implementar um trigger, designado trg_vendas_impedir_alteracoes, para impedir a adição, atualização
-- ou eliminação de um registo na tabela Vendas fora do horário de funcionamento da livraria. A livraria
-- funciona de segunda a sexta, das 9H00 às 19H00. Testar adequadamente o trigger implementado

create or replace trigger trg_vendas_impedir_alteracoes
before insert or update or delete on Vendas
begin

    -- Check if between 9H00 às 19H00
    if sysdate not between to_date('09:00:00', 'HH24:MI:SS') and to_date('19:00:00', 'HH24:MI:SS') then
        raise_application_error(-20001, 'Só pode fazer alterações de segunda a sexta, das 9H00 às 19H00!');
    end if;
    
    -- Check if is weekend - o NLS_DATE_LANGUAGE=ENGLISH não é preciso
    if to_char(sysdate, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') in ('SAT', 'SUN') then
        raise_application_error(-20001, 'Só pode fazer alterações de segunda a sexta, das 9H00 às 19H00!');
    end if;

end;

-- 6. Desativar o trigger implementado e testar adequadamente o novo estado do trigger. Reparar na
-- mudança de cor do ícone do trigger, na pasta Triggers da respetiva “Connection”. 

alter trigger trg_vendas_impedir_alteracoes disable;

-- 7. Ativar novamente o trigger implementado e testar adequadamente o novo estado do trigger. Reparar
-- na mudança de cor do ícone do trigger, na pasta Triggers da respetiva “Connection”.

alter trigger trg_vendas_impedir_alteracoes enable;

-- 8. Implementar um trigger, designado trg_precos_edicoes_livros_impedir_registo, para impedir o registo
-- de um novo preço de uma edição de um livro, se a data inicial (data_inicio) for anterior ou igual à data
-- atual. Testar adequadamente o trigger implementado

create or replace trigger trg_precos_edicoes_livros_impedir_registo
before insert or update on Precos_Edicoes_Livros
for each row
begin

    if :new.data_inicio <= sysdate then
        raise_application_error(-20001, 'Só pode registar um novo preço de uma edição de um livro se a data inicial (data_inicio) for anterior ou igual à data atual');
    end if;

end;

-- 9. Implementar um trigger, designado trg_vendas_saldos_cartao_cliente, para atualizar o saldo atual e o
-- saldo acumulado de um determinado cartão de cliente, quando é adicionado ou eliminado um registo
-- na tabela Vendas. Nas vendas relacionadas com os clientes que têm cartão e que são realizadas apenas
-- durante terça ou quarta, é adicionado o valor de 5% das vendas a cada um dos saldos do cartão. Testar
-- adequadamente o trigger implementado.

create or replace trigger trg_vendas_saldos_cartao_cliente
before insert or update or delete on Vendas
for each row
declare

    preco_do_livro Precos_Edicoes_Livros.preco%type;
    saldo_actual_do_cliente Cartoes_Clientes.saldo_atual%type;
    saldo_acumulado_do_cliente Cartoes_Clientes.saldo_acumulado%type;
    novo_saldo_actual_do_cliente Cartoes_Clientes.saldo_atual%type;
    novo_saldo_acumulado_do_cliente Cartoes_Clientes.saldo_acumulado%type;

begin

    select preco
    into preco_do_livro
    from Precos_Edicoes_Livros pel
    where :new.isbn = pel.isbn
    and :new.data_hora > (select max(data_inicio) from Precos_Edicoes_Livros pel2 where :new.isbn = pel2.isbn);

    select saldo_atual
    into saldo_actual_do_cliente
    from Cartoes_Clientes cc
    where :new.nif_cliente = cc.nif_cliente;

    select saldo_acumulado
    into saldo_acumulado_do_cliente
    from Cartoes_Clientes cc
    where :new.nif_cliente = cc.nif_cliente;

    if to_char(:new.data_hora, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') in ('TUE', 'WED') then

        novo_saldo_actual_do_cliente := saldo_actual_do_cliente + ((preco_do_livro * :new.quantidade) * 0.05);
        novo_saldo_acumulado_do_cliente := saldo_acumulado_do_cliente + ((preco_do_livro * :new.quantidade) * 0.05);

        update Cartoes_Clientes cc
        set cc.saldo_atual = novo_saldo_actual_do_cliente, cc.saldo_acumulado = novo_saldo_acumulado_do_cliente
        where :new.nif_cliente = cc.nif_cliente;

    end if;

end;