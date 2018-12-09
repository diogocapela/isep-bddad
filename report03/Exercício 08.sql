-- TESTE 
Declare

Begin

insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (1, 1, 'DD-EE-FF', TO_DATE('27/11/2018', 'DD/MM/YYYY'), TO_DATE('1/12/2018', 'DD/MM/YYYY'), 82, 88);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (2, 1, 'DD-EE-FF', TO_DATE('28/11/2018', 'DD/MM/YYYY'), TO_DATE('1/12/2018', 'DD/MM/YYYY'), 82, 88);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (3, 1, 'DD-EE-FF', TO_DATE('29/11/2018', 'DD/MM/YYYY'), TO_DATE('1/12/2018', 'DD/MM/YYYY'), 82, 88);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (4, 1, 'DD-EE-FF', TO_DATE('30/11/2018', 'DD/MM/YYYY'), TO_DATE('1/12/2018', 'DD/MM/YYYY'), 82, 88);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (5, 1, 'DD-EE-FF', TO_DATE('01/12/2018', 'DD/MM/YYYY'), TO_DATE('1/12/2018', 'DD/MM/YYYY'), 82, 88);
insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (5, 2, 'DD-EE-FF', TO_DATE('01/12/2018', 'DD/MM/YYYY'), TO_DATE('2/12/2018', 'DD/MM/YYYY'), 82, 88);


insert into Viagem (cod_empregado, cod_armazem_origem, matricula, data_partida, data_chegada, capacidade_peso_ocupada, capacidade_volume_ocupada) values (1, 1, 'AA-BB-CC', TO_DATE('27/11/2018', 'DD/MM/YYYY'), TO_DATE('1/12/2018', 'DD/MM/YYYY'), 82, 88);


--TRIGGER

create or replace trigger trg_viagem_impedir_atribuicao_veiculo
before insert or update on Viagem
FOR EACH ROW

Declare
disponivel NUMBER;
numero_viagens number;
numero_viagens_excedidas EXCEPTION;
nao_DISPONIVEL EXCEPTION;
Begin 
    
    select count(*) into numero_viagens from viagem v, veiculo v1   
    where 
    to_char(data_Partida - 7/24,'IW') = to_char(CURRENT_DATE - 7/24,'IW') 
    AND  to_char(data_Partida - 7/24,'IYYY') = to_char(CURRENT_DATE - 7/24,'IYYY') 
    and v.matricula = v1.matricula 
    AND v1.matricula = :new.matricula ;
    
    SELECT disponibilidade INTO disponivel
        FROM Veiculo 
        WHERE matricula = :NEW.matricula;  
        
        IF(disponivel  != 1) THEN
        RAISE nao_DISPONIVEL;
     END IF;
    
    if numero_viagens>4 then 
        raise numero_viagens_excedidas;
    END IF;
    
    
    
    EXCEPTION
    
    WHEN numero_viagens_excedidas THEN
          RAISE_APPLICATION_ERROR(-20010, 'ja fez 4 viagens esta semana');
          
    WHEN nao_DISPONIVEL THEN
      RAISE_APPLICATION_ERROR(-20011, 'Ve�culo esta indispon�vel');
END;