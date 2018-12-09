SET SERVEROUTPUT ON;

DECLARE

    CURSOR cursor_autores IS SELECT * FROM Autores;
    lista_autores Autores%ROWTYPE;
    contador NUMBER;
    
BEGIN

    contador := 1;
    DBMS_OUTPUT.PUT_LINE('-' || '   ' || 'ID' || '   ' || 'Nome');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');

    OPEN cursor_autores;
        LOOP

            FETCH cursor_autores INTO lista_autores;
            EXIT WHEN cursor_autores%NOTFOUND;
    
            
            DBMS_OUTPUT.PUT_LINE(contador || '   ' || lista_autores.id_autor || '   ' || lista_autores.nome);
            contador := contador + 1;

        END LOOP;
    CLOSE cursor_autores;

END;
