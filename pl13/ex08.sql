SET SERVEROUTPUT ON;

DECLARE

    lista_autores Autores%ROWTYPE;
    contador NUMBER;
    
BEGIN

    contador := 1;
    DBMS_OUTPUT.PUT_LINE('-' || '   ' || 'ID' || '   ' || 'Nome');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');


    
    FOR lista_autores IN (SELECT * FROM Autores)
    LOOP
        
        DBMS_OUTPUT.PUT_LINE(contador || '   ' || lista_autores.id_autor || '   ' || lista_autores.nome);
        contador := contador + 1;

    END LOOP;


END;