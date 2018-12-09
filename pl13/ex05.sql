-- 5) Criar um novo script PL/SQL que implemente um bloco anónimo para mostrar o stock e o stock mínimo
-- de uma edição de um dado livro. A existência da edição do livro na BD deve ser efetuada recorrendo ao
-- mecanismo de exceções. Caso não se verifique a existência da edição do livro deve ser apresentada uma
-- mensagem apropriada. Testar adequadamente o bloco anónimo implementado.

set serverout on;

create or replace procedure proc_atualizar_tipo_cliente as

	stockLivro EDICOES_LIVROS.stock%type;
	stockMinimoLivro EDICOES_LIVROS.stock_min%type;

begin

	-- stock
	select stock into stockLivro from EDICOES_LIVROS
	where id_livro = idLivro;

	-- stock_min
	select stock_min into stockMinimoLivro from EDICOES_LIVROS
	where id_livro = idLivro;

	-- stock
	dbms_output.put_line(stockLivro);

	--stock_min
	dbms_output.put_line(stockMinimoLivro);

end getStockLivros;