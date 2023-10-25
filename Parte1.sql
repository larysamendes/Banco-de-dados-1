select e.nome, endereco
    from empregado e, departamento d
        where depto = codDep and d.nome = 'software'

select codproj, d.nome, e.nome, e.endereco, salario
    from empregado e, projeto p, departamento d
        where p.local = 'ufcg' and depart = coddep and gerente = matricula


select e.nome as empregado , s.nome as supervisor
    from empregado e , empregado s
        where e.supervisor = s.matricula

select matricula, d.nome
    from empregado , departamento d
        where depto = d.coddep

select distinct salario
    from empregado


select *
    from departamento
select *
    from empregado

select *
    from projeto

select p.nome
    from empregado e, projeto p, departamento d, alocacao a
        where e.nome = 'larysa' and depart = coddep
        or (p.codproj = a.codproj and e.matricula = a.matric and e.nome = 'larysa')

select p.nome
    from empregado e, projeto p, departamento d
        where depart = d.coddep and e.nome = 'larysa' and gerente = matricula
union
select p.nome
    from projeto p, alocacao a, empregado e
        where a.codproj = p.codproj and e.matricula = matric and e.nome = 'larysa'

select distinct p.nome
    from empregado e, departamento d, projeto p, alocacao a
        where e.nome = 'larysa' and matric = matricula and a.codproj = p.codproj
        or e.nome = 'larysa' and d.coddep = depart  and gerente = matricula

select *
    from alocacao
 

select distinct nome
    from projeto
       where codproj in (select codproj
                            from projeto p, departamento d , empregado e
                                where e.nome = 'larysa' and 
                                      d.gerente = e.matricula and
                                      p.depart = d.coddep)
            or
            codproj in (select p.codproj
                            from empregado e, alocacao a, projeto p
                                where e.nome = 'larysa' and 
                                      a.matric = e.matricula and
                                      p.codproj = a.codproj)


create table dependente(
    coddependente varchar(15),
    matricula varchar(15),
    nome varchar(15),
    sexo varchar(15),
    constraint dependente_pk primary key (coddependente, matricula),
    constraint matricempreg_fk foreign key (matricula) references empregado(matricula)
)
alter table empregado add sexo varchar(15)

select *
    from empregado

update empregado
    set sexo = 'masculino' 
        where nome = 'matheus'
 
select e.nome
    from empregado e, dependente d
        where e.nome = d.nome and
              e.sexo = d.sexo and
              e.matricula = d.matricula

select nome
    from empregado e
        where matricula in (select matricula
                                from dependente d
                                    where e.nome = d.nome and
                                          e.matricula = d.matricula and
                                          e.sexo = d.sexo)

select nome
    from empregado e
        where not exists (select *
                        from dependente d
                            where e.nome = d.nome and
                                  e.sexo = d.sexo and
                                  e.matricula = d.matricula)

select nome
    from empregado e
        where exists ( select *
                            from dependente d
                                where e.matricula = d.matricula)
        and 
        not exists ( select *
                            from dependente d
                                where e.matricula = d.matricula and
                                      e.nome = d.nome and
                                      e.sexo = d.sexo)


select distinct matric
    from alocacao
        where codproj not in (1,2)

select matricula, nome
    from empregado e
        where not exists (
            (select codproj 
                from alocacao 
                    where matric = 1)
            minus
            (select codproj
                from alocacao a
                    where a.matric = e.matricula and
                          a.matric <> 1)
)

select *
    from alocacao


select nome
    from empregado 
        where supervisor is null

select count(salario), max(salario), min(salario), avg(salario)
    from empregado

select max(salario), min(salario)
    from empregado e, departamento d
        where d.nome = 'producao' and
                        depto = coddep

select count(*)
    from empregado

select count(distinct salario)
    from empregado e, departamento d
        where depto = coddep and
              d.nome = 'producao'

select e.nome
    from empregado e
        where (select count(*)
                    from dependente d
                        where e.matricula = d.matricula) >= 2

select matricula, salario, (select max(salario)
                                from empregado)
    from empregado

select depto, count(*), avg(salario)
    from empregado
        group by depto

select p.codproj , p.nome, count(*)
    from alocacao a, projeto p
        where p.codproj = a.codproj
    group by p.codproj, p.nome

select d.nome, d.sexo , count(sexo)
    from dependente d
    group by d.nome, d.sexo

select p.codproj, p.nome, count(*) 
    from alocacao a, projeto p
        where p.codproj = a.codproj
     
    group by p.codproj, p.nome
    having count(*) >2

select nome
    from empregado
        where upper(endereco) like '%SOUSA%'

select nome
    from empregado
        where lower(endereco) like '%sousa%'

select e.nome, 1.1 * salario
    from empregado e, projeto p , alocacao a
        where p.codproj = a.codproj and
              p.nome = 'acai' and
              matricula = matric

select d.nome, e.nome, p.nome
    from empregado e, departamento d, projeto p , alocacao a
    where depto = coddep and
          matricula = matric and
          p.codproj = a.codproj
    
    order by d.nome desc , e.nome asc
      
