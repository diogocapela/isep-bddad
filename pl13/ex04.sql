-- 4) Criar um script com código PL/SQL que implemente um bloco anónimo para mostrar a quantidade de
-- edições de livros de uma dada editora. A existência da editora na BD deve ser efetuada recorrendo à
-- estrutura de decisão IF-THEN-ELSE. Caso não se verifique a existência da editora deve ser apresentada
-- uma mensagem apropriada. Testar adequadamente o bloco anónimo implementado. Para visualizar o
-- resultado, executar o comando SET SERVEROUTPUT ON.

set serverout on;

declare

	quantiadeLivros number;
    numero number := 15;

begin

	select count(*) into quantiadeLivros from edicoes_livros
	where id_editora = numero;

	dbms_output.put_line(quantiadeLivros);

end;
