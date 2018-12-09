SET SERVEROUTPUT ON;

DECLARE

    CURSOR cursor_livros_vendidos_mensalmente(
        p_idEditora Editoras.id_editora%TYPE,
        p_ano INTEGER,
        p_mes INTEGER
    ) IS
    SELECT sum(v.quantidade) FROM Vendas v, Edicoes_Livros el
    WHERE v.isbn = el.isbn
    AND el.id_editora = p_idEditora
    AND EXTRACT(YEAR FROM v.data_hora) = p_ano
    AND EXTRACT(MONTH FROM v.data_hora) = p_mes;
    
    l_id_editora            Editoras.id_editora%TYPE;
    l_ano                   INTEGER;
    l_nome                  Editoras.nome%TYPE;
    
    l_quantidade_vendida    INTEGER;
    
BEGIN

    l_id_editora := 1500;
    l_ano := 2016;

    DBMS_OUTPUT.PUT_LINE('ID Editora: ' || l_id_editora);
    DBMS_OUTPUT.PUT_LINE('Ano: ' || l_ano);
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('MÊS    QUANTIDADE');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
    
    FOR mes in 1..12
    LOOP
        
        OPEN cursor_livros_vendidos_mensalmente(1500, 2016, mes);
        FETCH cursor_livros_vendidos_mensalmente INTO l_quantidade_vendida;
        CLOSE cursor_livros_vendidos_mensalmente;
        
        DBMS_OUTPUT.PUT_LINE(mes || '           ' ||l_quantidade_vendida);
    END LOOP;
    

END;
