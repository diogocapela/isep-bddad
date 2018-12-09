--isto é a funçao
create or replace function func_zone_max_storage(id_armazem in armazem.cod_armazem%type)
RETURN SYS_REFCURSOR
is

 cursor_zonas SYS_REFCURSOR;
    
    
begin

    OPEN cursor_zonas for   
            
        select cod_zona from zona_artigo 
        where quantidade=
            (select max(quantidade) from zona_artigo     
                where cod_zona in (  
                    SELECT cod_zona
                    FROM Zona
                    where id_armazem = cod_armazem));        
    
    RETURN cursor_zonas;

end;


--isto testa


set serveroutput on;
Declare
id_armazem armazem.cod_armazem%type:=1;
id_zona zona_artigo.cod_zona%type;
zonas SYS_REFCURSOR;
Begin

zonas := func_zone_max_storage(id_armazem);

 LOOP
      FETCH zonas INTO id_zona;

      EXIT WHEN zonas%NOTFOUND;
      DBMS_OUTPUT.put_line (id_zona);
   END LOOP;

   CLOSE zonas;
End;