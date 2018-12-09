-- 4. 


SET SERVEROUTPUT ON;

DECLARE
    l_qtd_livros INTEGER;
    l_id_editora editoras.id_editora%TYPE;
    l_contador   INTEGER;
BEGIN
    l_id_editora := 1500;
    
    SELECT COUNT(*) INTO l_contador    
    FROM editoras WHERE id_editora=l_id_editora;
    
    IF(l_contador!=0) THEN
        SELECT COUNT(*) INTO l_qtd_livros 
        FROM edicoes_livros WHERE id_editora=l_id_editora;
      
        DBMS_OUTPUT.PUT_LINE('Quantidade de livros: ' || l_qtd_livros);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Editora ' || l_id_editora || ' inexistente.');
    END IF;
END;
/

-- 5.
SET SERVEROUTPUT ON;

DECLARE
    l_stock     edicoes_livros.stock%TYPE;
    l_stock_min edicoes_livros.stock_min%TYPE;
    l_isbn      edicoes_livros.isbn%TYPE;
BEGIN
    l_isbn := '500-1211111191';   
    SELECT stock_min, stock INTO l_stock_min, l_stock 
    FROM edicoes_livros WHERE isbn=l_isbn;
  
    DBMS_OUTPUT.PUT_LINE('ISBN: ' || l_isbn);  
    DBMS_OUTPUT.PUT_LINE('Stock: ' || l_stock);
    DBMS_OUTPUT.PUT_LINE('Stock mínimo: ' || l_stock_min);

EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Livro não existe!');
END;
/

-- 6. 
SET SERVEROUTPUT ON;

DECLARE
    CURSOR cur_autores
    IS 
        SELECT * 
          FROM autores
      ORDER BY nome;
    l_autor autores%ROWTYPE;
    l_linha INTEGER;
BEGIN 
    DBMS_OUTPUT.PUT_LINE(RPAD('-',4) || RPAD('ID',6) || 'NOME');
    DBMS_OUTPUT.PUT_LINE(RPAD('-',35,'-'));
    
    OPEN cur_autores;
    LOOP
        FETCH cur_autores INTO l_autor;
        EXIT WHEN cur_autores%NOTFOUND;
        
        l_linha := cur_autores%ROWCOUNT;  
        
        DBMS_OUTPUT.PUT_LINE(RPAD(l_linha,4) || RPAD(l_autor.id_autor,6) || l_autor.nome);
    END LOOP;
    CLOSE cur_autores;
END;
/

-- 7.
SET SERVEROUTPUT ON;

DECLARE
    CURSOR cur_autores IS SELECT * FROM autores ORDER BY nome;
    l_autor autores%ROWTYPE;
    l_linha INTEGER;
BEGIN 
    DBMS_OUTPUT.PUT_LINE(RPAD('-',4) || RPAD('ID',6) || 'NOME');
    DBMS_OUTPUT.PUT_LINE(RPAD('-',30,'-'));
    
    FOR l_autor IN cur_autores
    LOOP
        l_linha := cur_autores%ROWCOUNT;  
        DBMS_OUTPUT.PUT_LINE(RPAD(l_linha,4) || RPAD(l_autor.id_autor,6) || l_autor.nome);        
    END LOOP; 
END;
/

-- 8. 
SET SERVEROUTPUT ON;

DECLARE      
    l_autor autores%ROWTYPE;
    l_linha INTEGER :=0;    
BEGIN 
    DBMS_OUTPUT.PUT_LINE(RPAD('-',4) || RPAD('ID',6) || 'NOME');
    DBMS_OUTPUT.PUT_LINE(RPAD('-',30,'-'));
    
    FOR l_autor IN (  SELECT * 
                        FROM autores
                    ORDER BY nome)
    LOOP
        l_linha := l_linha + 1;         
        DBMS_OUTPUT.PUT_LINE(RPAD(l_linha,4) || RPAD(l_autor.id_autor,6) || l_autor.nome);        
    END LOOP;
END;
/

-- 9.
SET SERVEROUTPUT ON;

DECLARE    
    CURSOR cur_qtd_vendida(p_id_editora edicoes_livros.id_editora%TYPE, p_ano INTEGER, p_mes INTEGER) 
    IS
        SELECT SUM(V.quantidade) 
          FROM vendas V 
                INNER JOIN edicoes_livros E ON V.isbn=E.isbn          
         WHERE id_editora=p_id_editora 
                AND EXTRACT(MONTH FROM V.data_hora)=p_mes
                AND EXTRACT(YEAR FROM V.data_hora)=p_ano;
                
    l_nome          editoras.nome%TYPE;
    l_id_editora    edicoes_livros.id_editora%TYPE;    
    l_ano           INTEGER;
    l_qtd_vendida   INTEGER;
    l_ano_invalido  EXCEPTION;

BEGIN         
    l_id_editora := 1500;
    l_ano := 2016;
    
    SELECT nome INTO l_nome    
    FROM editoras WHERE id_editora=l_id_editora; 
    
    IF l_ano>=EXTRACT(YEAR FROM SYSDATE) THEN
        RAISE l_ano_invalido;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Editora ' || l_id_editora);
    DBMS_OUTPUT.PUT_LINE('Vendas ' || l_ano);
    DBMS_OUTPUT.PUT_LINE(' ');    
    DBMS_OUTPUT.PUT_LINE(RPAD('MÊS',5) || 'QTD');
    DBMS_OUTPUT.PUT_LINE(RPAD('-',10,'-'));
        
    FOR mes IN 1..12
    LOOP       
        OPEN cur_qtd_vendida(l_id_editora, l_ano, mes);
        FETCH cur_qtd_vendida INTO l_qtd_vendida;
        CLOSE cur_qtd_vendida;  
        
        DBMS_OUTPUT.PUT_LINE( RPAD(mes,5) || NVL(l_qtd_vendida,0) );
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Editora ' || l_id_editora || ' não existe!');
    WHEN l_ano_invalido THEN
        DBMS_OUTPUT.PUT_LINE('Ano ' || l_ano || ' é inválido!');
END;
/

-- 10.
SET SERVEROUTPUT ON;

DECLARE
    l_montante  cartoes_clientes.saldo_atual%TYPE;
BEGIN    
    l_montante := 5;
        
    UPDATE cartoes_clientes 
    SET saldo_atual = saldo_atual + l_montante, saldo_acumulado = saldo_acumulado + l_montante
    WHERE data_adesao < (SYSDATE-INTERVAL '10' YEAR);
  
    DBMS_OUTPUT.PUT_LINE('Qtd de cartões atualizados = ' || SQL%ROWCOUNT);
    
    COMMIT;  
END;
/
