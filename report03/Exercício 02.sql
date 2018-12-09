create or replace function  func_razao_veiculo_transporte(p_cod_armazem in armazem.cod_armazem%type, p_data_inico in date, p_data_fim in date)
return number

    is
    parametro_invalido exception;
    max_qtd_matriculas number;
    min_qtd_matriculas number;
    contador number;
    razao number;
    
    begin
     
     select count (cod_armazem) into contador from armazem A where A.cod_armazem = p_cod_armazem;
     if contador = 0 then raise parametro_invalido;
     end if;
        
     
     select count (*) into max_qtd_matriculas
     from(select v.matricula, count(v.matricula) from viagem V inner join guiatransporte gt on V.cod_viagem = gt.cod_viagem
     inner join veiculo Ve on V.matricula = ve.matricula group by v.matricula 
     having count (v.matricula)=( select max(count(v.matricula)) from viagem V inner join guiatransporte gt on V.cod_viagem = gt.cod_viagem
     inner join veiculo VE on v.matricula = VE.matricula where V.cod_armazem_origem = p_cod_armazem and v.data_partida between p_data_inico and p_data_fim
     group by v.matricula));
       
     select count (*) into min_qtd_matriculas
     from(select v.matricula, count(v.matricula) from viagem V inner join guiatransporte gt on V.cod_viagem = gt.cod_viagem
     inner join veiculo Ve on v.matricula = Ve.matricula group by v.matricula 
     having count (v.matricula)=( select min(count(v.matricula)) from viagem V inner join guiatransporte gt on V.cod_viagem = gt.cod_viagem
     inner join veiculo VE on v.matricula = VE.matricula where V.cod_armazem_origem = p_cod_armazem and v.data_partida between  p_data_inico and p_data_fim
     group by v.matricula));
         
    
    if max_qtd_matriculas = 0 then 
    max_qtd_matriculas := 1;
    end if;
    
    if min_qtd_matriculas = 0 then 
    min_qtd_matriculas :=1;
    end if;
    
     return max_qtd_matriculas/min_qtd_matriculas;
   
    exception
       when parametro_invalido then return null;
        
    end func_razao_veiculo_transporte;