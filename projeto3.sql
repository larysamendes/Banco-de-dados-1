-- 1 - Liste o nome e a home page dos fornecedores de produtos da categoria ‘HARDWARE’.
-- Os registros devem estar ordenados pelo nome em ordem alfabética.

select distinct f.nome, f.home_page
from produto p
join categoria ca on p.cod_categoria = ca.codcat
join fornecimento fo on fo.codigo_produto = p.codprod
join fornecedor f on f.codforn = fo.codigo_fornecedor
where ca.nome = 'HARDWARE'
order by f.nome asc;

-- 2 - Qual a quantidade de compras feitas por ‘José da Costa’ no mês de Fevereiro de 2020?
-- Caso existam vários clientes chamados ‘José da Costa’, mostre a quantidade de cada um
-- (uma linha com o código e respectiva quantidade para cada um).

select cl.codcli, count(co.codordem) as quantidade_de_compras
from cliente cl
join ordem_de_compra co on cl.codcli = co.codigo_cliente
where cl.nome = 'José' and cl.sobrenome = 'da Costa'
  and extract(month from co.data_compra) = 2
  and extract(year from co.data_compra) = 2020
group by cl.codcli;

-- 3 - Liste todos os possíveis fornecedores dos produtos contidos na nota fiscal cuja chave de
-- acesso é ‘NFE4612-789796’.

select distinct f.codforn, f.nome
from fornecedor f
join fornecimento fo on fo.codigo_fornecedor = f.codforn
join compra_produto cp on cp.codigo_produto = fo.codigo_produto
join ordem_de_compra co on co.codordem = cp.codigo_compra
join nota_fiscal nf on co.codordem = nf.cod_ordem_compra
where nf.chave_acesso = 'NFE4612-789796';

-- 4 - Qual(is) transportadora(s) mais entregou(aram) compras na cidade de São Paulo? Projete
-- código e nome.

select t.codtrans, t.nome
from transportadora t
join ordem_de_compra o on t.codtrans = o.codigo_transportadora
where o.end_cidade = 'São Paulo'
group by t.codtrans, t.nome
having count(o.codordem) = (
    select max(total_compras)
    from (select t1.codtrans, count(o1.codordem) as total_compras
          from transportadora t1
          join ordem_de_compra o1 ON t1.codtrans = o1.codigo_transportadora
          where o1.end_cidade = 'São Paulo'
          group by t1.codtrans) subquery);

-- 5 - Qual a média dos valores dos produtos comprados por ‘João Paulo’ na(s) compra(s)
-- finalizadas do dia 25/10/2020? Caso exista mais de um cliente chamado ‘João Paulo’, retorne
-- uma linha para cada um com seu código e sua respectiva média de compra.

select cl.codcli, avg(p.preco_venda) as media_de_compra
from cliente cl 
join ordem_de_compra oc on cl.codcli = oc.codigo_cliente
join compra_produto cp on cp.codigo_compra = oc.codordem
join produto p on p.codprod = cp.codigo_produto
where cl.nome = 'João Paulo' and oc.data_compra = TO_DATE('25/10/2020', 'DD/MM/YY') and oc.status = 'FINALIZADA'
group by cl.codcli;

-- 6 - Liste o nome dos produtos da categoria ‘Limpeza’, juntamente com o nome dos seus
-- fornecedores. Caso algum fornecedor não possua produtos dessa categoria, o seu nome ainda
-- deve estar presente na listagem resultante e o nome do produto deve possuir valor nulo.

select p.nome as NomeProduto, fo.nome as NomeFornecedor
from produto p
join fornecimento f on p.codprod = f.codigo_produto
join categoria ca on p.cod_categoria = ca.codcat
join fornecedor fo on f.codigo_fornecedor = fo.codforn
where ca.nome = 'Limpeza'
union
select null as NomeProduto, fo.nome as NomeFornecedor
from fornecedor fo
where fo.codforn not in (
  select f.codigo_fornecedor
  from fornecimento f
  join produto p on f.codigo_produto = p.codprod
  join categoria ca on p.cod_categoria = ca.codcat
  where ca.nome = 'Limpeza');

-- 7 - Qual cliente, que nunca indicou outro, comprou a maior quantidade de produtos
-- fornecidos pela fornecedora ‘JK Distribuições’? Projete o código. Caso haja mais de um
-- cliente que atenda a esta condição, liste todos (o resultado deve conter uma linha para cada
-- um).

select cl.codcli
from cliente cl
join ordem_de_compra oc on cl.codcli = oc.codigo_cliente
join compra_produto cp on oc.codordem = cp.codigo_compra
where cl.codcli not in (
                        select cl.cliente_indica
                        from cliente cl
... (96 linhas)
Recolher
ProjetoFase03Grupo02.sql
9 KB
Larysa Mendes — 27/10/2023 17:41
vlwww
﻿
Vitória Maria
vitoria_maria_
-- Grupo 02:
-- Anna Beatriz Soares Furtado
-- Jamilly Venâncio da Silva
-- Luana Bringel Leite
-- Vitória Maria do Nascimento

-- 1 - Liste o nome e a home page dos fornecedores de produtos da categoria ‘HARDWARE’.
-- Os registros devem estar ordenados pelo nome em ordem alfabética.

select distinct f.nome, f.home_page
from produto p
join categoria ca on p.cod_categoria = ca.codcat
join fornecimento fo on fo.codigo_produto = p.codprod
join fornecedor f on f.codforn = fo.codigo_fornecedor
where ca.nome = 'HARDWARE'
order by f.nome asc;

-- 2 - Qual a quantidade de compras feitas por ‘José da Costa’ no mês de Fevereiro de 2020?
-- Caso existam vários clientes chamados ‘José da Costa’, mostre a quantidade de cada um
-- (uma linha com o código e respectiva quantidade para cada um).

select cl.codcli, count(co.codordem) as quantidade_de_compras
from cliente cl
join ordem_de_compra co on cl.codcli = co.codigo_cliente
where cl.nome = 'José' and cl.sobrenome = 'da Costa'
  and extract(month from co.data_compra) = 2
  and extract(year from co.data_compra) = 2020
group by cl.codcli;

-- 3 - Liste todos os possíveis fornecedores dos produtos contidos na nota fiscal cuja chave de
-- acesso é ‘NFE4612-789796’.

select distinct f.codforn, f.nome
from fornecedor f
join fornecimento fo on fo.codigo_fornecedor = f.codforn
join compra_produto cp on cp.codigo_produto = fo.codigo_produto
join ordem_de_compra co on co.codordem = cp.codigo_compra
join nota_fiscal nf on co.codordem = nf.cod_ordem_compra
where nf.chave_acesso = 'NFE4612-789796';

-- 4 - Qual(is) transportadora(s) mais entregou(aram) compras na cidade de São Paulo? Projete
-- código e nome.

select t.codtrans, t.nome
from transportadora t
join ordem_de_compra o on t.codtrans = o.codigo_transportadora
where o.end_cidade = 'São Paulo'
group by t.codtrans, t.nome
having count(o.codordem) = (
    select max(total_compras)
    from (select t1.codtrans, count(o1.codordem) as total_compras
          from transportadora t1
          join ordem_de_compra o1 ON t1.codtrans = o1.codigo_transportadora
          where o1.end_cidade = 'São Paulo'
          group by t1.codtrans) subquery);

-- 5 - Qual a média dos valores dos produtos comprados por ‘João Paulo’ na(s) compra(s)
-- finalizadas do dia 25/10/2020? Caso exista mais de um cliente chamado ‘João Paulo’, retorne
-- uma linha para cada um com seu código e sua respectiva média de compra.

select cl.codcli, avg(p.preco_venda) as media_de_compra
from cliente cl 
join ordem_de_compra oc on cl.codcli = oc.codigo_cliente
join compra_produto cp on cp.codigo_compra = oc.codordem
join produto p on p.codprod = cp.codigo_produto
where cl.nome = 'João Paulo' and oc.data_compra = TO_DATE('25/10/2020', 'DD/MM/YY') and oc.status = 'FINALIZADA'
group by cl.codcli;

-- 6 - Liste o nome dos produtos da categoria ‘Limpeza’, juntamente com o nome dos seus
-- fornecedores. Caso algum fornecedor não possua produtos dessa categoria, o seu nome ainda
-- deve estar presente na listagem resultante e o nome do produto deve possuir valor nulo.

select p.nome as NomeProduto, fo.nome as NomeFornecedor
from produto p
join fornecimento f on p.codprod = f.codigo_produto
join categoria ca on p.cod_categoria = ca.codcat
join fornecedor fo on f.codigo_fornecedor = fo.codforn
where ca.nome = 'Limpeza'
union
select null as NomeProduto, fo.nome as NomeFornecedor
from fornecedor fo
where fo.codforn not in (
  select f.codigo_fornecedor
  from fornecimento f
  join produto p on f.codigo_produto = p.codprod
  join categoria ca on p.cod_categoria = ca.codcat
  where ca.nome = 'Limpeza');

-- 7 - Qual cliente, que nunca indicou outro, comprou a maior quantidade de produtos
-- fornecidos pela fornecedora ‘JK Distribuições’? Projete o código. Caso haja mais de um
-- cliente que atenda a esta condição, liste todos (o resultado deve conter uma linha para cada
-- um).

select cl.codcli
from cliente cl
join ordem_de_compra oc on cl.codcli = oc.codigo_cliente
join compra_produto cp on oc.codordem = cp.codigo_compra
where cl.codcli not in (
                        select cl.cliente_indica
                        from cliente cl
                        where cl.cliente_indica is not null)
and cl.codcli in (
                select distinct codigo_cliente
                from ordem_de_compra oc
                join compra_produto cp on oc.codordem = cp.codigo_compra
                join fornecimento f on cp.codigo_produto = f.codigo_produto
                join fornecedor fo on f.codigo_fornecedor = fo.codforn
                where fo.nome = 'JK Distribuições')
and cp.codigo_produto in (
                        select codigo_produto
                        from fornecimento f
                        join fornecedor fo on f.codigo_fornecedor = fo.codforn
                        where fo.nome = 'JK Distribuições')
group by cl.codcli
having sum(cp.quantidade) = (
    select max(num_produtos_comprados)
    from (
        select cl.codcli, sum(cp.quantidade) as num_produtos_comprados
        from cliente cl
        join ordem_de_compra oc on cl.codcli = oc.codigo_cliente
        join compra_produto cp on oc.codordem = cp.codigo_compra
        where cl.codcli not in (
                                select cl.cliente_indica
                                from cliente cl
                                where cl.cliente_indica is not null)
        and cl.codcli in (
                        select distinct codigo_cliente
                        from ordem_de_compra oc
                        join compra_produto cp on oc.codordem = cp.codigo_compra
                        join fornecimento f on cp.codigo_produto = f.codigo_produto
                        join fornecedor fo on f.codigo_fornecedor = fo.codforn
                        where fo.nome = 'JK Distribuições')
        and cp.codigo_produto in (
                                select codigo_produto
                                from fornecimento f
                                join fornecedor fo on f.codigo_fornecedor = fo.codforn
                                where fo.nome = 'JK Distribuições')
        group by cl.codcli));

-- 8 - Liste o nome dos clientes que não efetuaram nenhuma ordem de compra.

select cl.nome 
from cliente cl 
left outer join ordem_de_compra oc on cl.codcli = oc.codigo_cliente
where oc.codordem is null;

-- 9 - Localize a(s) categoria(s) presente(s) em mais compras de clientes com idade de 50 anos
-- ou superior. Projete o código e nome.

select distinct ca.codcat, ca.nome
from ordem_de_compra oc
join compra_produto ps on ps.codigo_compra = oc.codordem
join produto p on ps.codigo_produto = p.codprod
join categoria ca on ca.codcat = p.cod_categoria
where oc.codigo_cliente in 
    (select distinct cl.codcli
    from cliente cl 
    where months_between(sysdate, data_nascimento)/12 >= 50)
group by ca.codcat, ca.nome
having count(oc.codordem) = (
    select max(compras_por_categoria)
    from 
    (select distinct ca.codcat, count(oc.codordem) as compras_por_categoria
        from ordem_de_compra oc
        join compra_produto ps on ps.codigo_compra = oc.codordem
        join produto p on ps.codigo_produto = p.codprod
        join categoria ca on ca.codcat = p.cod_categoria
        where oc.codigo_cliente in 
            (select distinct cl.codcli
            from cliente cl 
            where months_between(sysdate, data_nascimento)/12 >= 50)
        group by ca.codcat));

-- 10 - Quais clientes não fizeram nenhuma compra no ano de 2022, ou não indicaram nenhum
-- outro cliente no ano de 2021? Projete código e nome.

select distinct cl.codcli, cl.nome
from cliente cl 
where cl.codcli not in
                      (select oc.codigo_cliente
                       from ordem_de_compra oc
                       where extract(year from oc.data_compra) = 2022)
 or cl.codcli not in (select cl.cliente_indica
                       from cliente cl 
                       where extract(year from cl.data_indicacao) = 2021);

-- 11 - Liste as quantidades em estoque dos produtos agrupadas por categorias, listando somente
-- as categorias que possuem uma quantidade superior a 100 unidades em estoque. Projete o
-- nome da categoria e a quantidade em estoque de produtos pertencentes àquela categoria.

select ca.nome, sum(p.quantidade) as quantidade_em_estoque
from produto p
join categoria ca on ca.codcat = p.cod_categoria
group by ca.nome
having sum(p.quantidade) > 100;


--Crie uma view que lista as ordens de compra no valor de mais de 10 mil reais
--que foram transportadas pela transportadora 'Azul Cargo'.

create view lista_ordem as
    select o.*
        from ordem_de_compra o, transportador t , nota_fiscal n
            where valor_total > 10000 and
                  cod_ordem_compra = codordem and
                  codigo_transportadora = codtrans
                  t.nome = 'Azul Cargo' and
                  o.status = 'FINALIZADA'

CREATE VIEW AZUL_CARGO
    AS SELECT o.*
    FROM NOTA_FISCAL nf, ORDEM_DE_COMPRA o, TRANSPORTADORA t
    WHERE nf.COD_ORDEM_COMPRA = o.CODORDEM AND o.CODIGO_TRANSPORTADORA = t.CODTRANS
        AND nf.VALOR_TOTAL > 10000 AND t.NOME = 'Azul Cargo' AND o.STATUS = 'FINALIZADA'

CREATE VIEW TRANSPORTADORAS_QUANTIDADE_DE_COMPRAS(nomeTransportadora, comprasTransportadas)
    AS SELECT t.NOME AS nomeTransportadora, COUNT(o.CODORDEM) AS comprasTransportadas
    FROM TRANSPORTADORA t LEFT OUTER JOIN ORDEM_DE_COMPRA o
    ON t.CODTRANS = o.CODIGO_TRANSPORTADORA AND o.STATUS = 'FINALIZADA'
    GROUP BY t.CODTRANS, t.NOME
  
CREATE VIEW FORNECEDORES_CATEGORIAS
AS SELECT
    fr.CODFORN AS CODIGO_FORNECEDOR, fr.CNPJ AS CNPJ_FORNECEDOR, fr.NOME AS NOME_FORNECEDOR,
    fr.HOME_PAGE AS HOME_PAGE_FORNECEDOR, fr.EMAIL AS EMAIL_FORNECEDOR, fr.TELEFONE AS TELEFONE_FORNECEDOR,
    fr.END_RUA AS RUA_FORNECEDOR, fr.END_NUM AS NUM_FORNECEDOR, fr.END_BAIRRO AS BAIRRO_FORNECEDOR,
    fr.END_CIDADE AS CIDADE_FORNECEDOR, fr.END_CEP AS CEP_FORNECEDOR, ca.CODCAT AS CODIGO_CATEGORIA,
    ca.NOME AS NOME_CATEGORIA, SUM(pt.QUANTIDADE) AS QUANTIDADE_PRODUTOS
FROM FORNECEDOR fr
CROSS JOIN CATEGORIA ca
LEFT OUTER JOIN FORNECIMENTO ft ON fr.CODFORN = ft.CODIGO_FORNECEDOR
LEFT OUTER JOIN PRODUTO pt ON ft.CODIGO_PRODUTO = pt.CODPROD
        AND pt.COD_CATEGORIA = ca.CODCAT
GROUP BY fr.CODFORN,ca.CODCAT, fr.NOME, ca.NOME, fr.CNPJ, fr.HOME_PAGE, fr.EMAIL, fr.TELEFONE, fr.END_RUA, 
         fr.END_NUM, fr.END_BAIRRO, fr.END_CIDADE, fr.END_CEP
ORDER BY fr.CODFORN, ca.CODCAT;


CREATE OR REPLACE TRIGGER NOME_TRANSPORTADORA
BEFORE INSERT OR UPDATE OF NOME ON TRANSPORTADORA
FOR EACH ROW
BEGIN
    :NEW.NOME := INITCAP(:NEW.NOME);
END;



CREATE OR REPLACE TRIGGER CLIENTE_CPF
BEFORE INSERT OR UPDATE OF CPF ON CLIENTE
FOR EACH ROW
BEGIN
    :NEW.NOME := UPPER(:NEW.NOME);
END;


-- Crie uma view que lista as transportadoras e a quantidade compras que elas já transportaram.

create view transportadora_new (nomeTransportadora, totalCompras)
    as select t.nome as nomeTransportadora, count(o.codordem) as totalCompras
        from transportadora t left join ordem_de_compra o
            on codtrans = codigo_transportadora and
               status = 'FINALIZADA'
        group by codtrans, t.nome

select *
    from transportadora_new

--6 - Crie uma view que lista os fornecedores e a quantidade de produto por categoria
--fornecidos por eles. A view deve exibir os dados dos fornecedores, a categoria do
--produto e a quantidade de produtos por categoria.

create view fornec
    as select fr.CODFORN AS CODIGO_FORNECEDOR, fr.CNPJ AS CNPJ_FORNECEDOR, fr.NOME AS NOME_FORNECEDOR,
    fr.HOME_PAGE AS HOME_PAGE_FORNECEDOR, fr.EMAIL AS EMAIL_FORNECEDOR, fr.TELEFONE AS TELEFONE_FORNECEDOR,
    fr.END_RUA AS RUA_FORNECEDOR, fr.END_NUM AS NUM_FORNECEDOR, fr.END_BAIRRO AS BAIRRO_FORNECEDOR,
    fr.END_CIDADE AS CIDADE_FORNECEDOR, fr.END_CEP AS CEP_FORNECEDOR, ca.CODCAT AS CODIGO_CATEGORIA,
    ca.NOME AS NOME_CATEGORIA, SUM(pt.QUANTIDADE) AS QUANTIDADE_PRODUTOS
        from fornecedor f

-- 7 - Crie um trigger para modificar o nome da transportadora deixando a primeira
--letra no nome sempre maiúscula quando esse dado for inserido ou atualizado.

create trigger modificaNome
    before update or insert on transportadora
    for each row
    begin 
        :New.nome := initcap(:New.nome);
    end;

--8 - Crie um trigger para deixar em caixa alta todo o nome do cliente quando for
--inserido ou atualizado um número de CPF para ele.

create or replace trigger update_cpf
    after update or insert on cliente
    for each row
    when (old.cpf <> new.cpf)
    begin
        update cliente
            set nome = upper(nome),
            set sobrenome = upper(sobrenome)
     end;

CREATE OR REPLACE TRIGGER update_cpf
AFTER INSERT OR UPDATE OF cpf ON cliente
FOR EACH ROW
WHEN (OLD.cpf <> NEW.cpf)
BEGIN
    :NEW.nome := UPPER(:NEW.nome);
    :NEW.sobrenome := UPPER(:NEW.sobrenome);
END;

create or replace trigger up_cpf
    before insert or update of cpf on cliente
    for each row
    begin
        :New.nome := upper(:New.nome);
    end;

--9 - Crie um trigger para substituir o valor do campo 'END_BAIRRO' por 'CENTRO'
--na tabela de CLIENTE se esse valor for nulo quando o cliente for atualizado ou
--inserido.


CREATE OR REPLACE TRIGGER TG_Transportadora_letra
BEFORE INSERT OR UPDATE OF nome ON TRANSPORTADORA
FOR EACH ROW
BEGIN
  IF  REGEXP_LIKE(:NEW.nome, '^[a-z]') THEN
    :NEW.nome := UPPER(SUBSTR(:NEW.nome, 1, 1)) || SUBSTR(:NEW.nome, 2);
  END IF;
END;

select a.nome
    from empregado a
        where matricula in (select matricula
                            from empregado)
        minus
        (select e1.matricula
            from empregado e1, empregado e2
                where e1.salario < e2.salario);
 
select nome
    from empregado
        where salario = (select max(salario)
                            from empregado)

select nome
    from empregado
        where salario >= all (select salario
                                from empregado)

select nome 
    from empregado
    where matricula in (select e1.matricula
                            from empregado e1, empregado e2
                                where e1.salario > e2.salario)
select *
        from empregado


update empregado
    set salario = 102311
    where nome = 'larysa'

--4) crie uma visao que mostra a categoria eo total em dinheito estocado por categoria, que totalizam mais de 3000

create table newproduto(
    idProduto int,
    nome varchar(15),
    categoria varchar(15),
    preco number(7,2),
    estoque int,
    primary key (idProduto)
);

create table nemcompra (
    idproduto int,
    quantidade int,
    primary key (idproduto),
    foreign key (idproduto) references newproduto(iDproduto)
);


--3) faça um trigger para quando houver uma atualizacao no estoque da tabela produto, se o novo valor de estoque for menor que 5 , então
-- insira na tabela compras o produto e a quantidade igual a 50. 

create or replace trigger update_estoque
    after update of estoque on newproduto
    for each row
    when (estoque < 5)
    begin 
        insert into nemcompra(idproduto, quantidade)
        values(:new.idproduto, 50);
    end;

--4) crie uma visao que mostra a categoria eo total em dinheiro 
--estocado por categoria, que totalizam mais de 3000
--produto(idproduto, nome, categoria, preco, estoque)

create view mostra
    as select categoria, sum(preco * estoque) as total
        from newproduto
        group by categoria
        having sum(preco * estoque ) > 3000;
        
--5) remova da tabela compra todos os produtos categoria limpeza 
--que tem quantidade menor do que 10.

delete from newproduto
    where idproduto in (select p.idproduto
                            from newproduto p, nemcompra c
                                where p.categoria = 'limpeza' and  
                                      p.idproduto = c.idproduto and
                                      c.quantidade < 10)
--9- Crie um trigger que insira pontos por cada indicação de um cliente, durante uma
--inserção ou atualização, sempre que um cliente aparecer como indicador de outro, o
--mesmo receberá 100 pontos.


create or replace trigger atualizaPontos
    after insert or update of cliente_indica on cliente
    for each row 
    begin
        if :new.cliente_indica is not null then
            update cliente
            set pontos = pontos + 100
            where codcli = :new.cliente_indica;
        end if;
     end;

select *
    from cliente

update cliente
    set cliente_indica = 1
        where  codcli = 3
    
drop trigger update_cpf



create or replace trigger new_status
    before insert on ordem_de_compra
    for each row
    begin
        :new.status := 'AGUARDANDO PAGAMENTO';
    end;

--4 - Crie uma view que liste o nome dos produtos e a quantidade de vezes que foram
--comprados. A listagem deverá estar ordenada dos produtos mais comprados para
--os menos comprados.

create view lista_produtos as
    select p.nome , count(codprod) as total_comprado
        from produto p left join compra_produto p on codigo_produto = codprod
        group by p.nome
        order by total_comprado


--8 - Crie um trigger para inserir SEXO = 'outro' quando uma tupla for inserida com o
--valor SEXO nulo.

create or replace trigger modifica_sexo_null
    before insert on cliente
    for each row
    begin
        if :new.sexo is null then
            :new.sexo := 'outro';
        end if;
    end;

---7 - Crie um trigger para modificar o sobrenome de um cliente. Quando inserir um
--sobrenome, substituir por 'da -> resto do sobrenome'. Exemplo: se inserir 'silva',
--substituir por 'da silva'.

create or replace trigger modifica_sobrenome
    before insert on cliente
    for each row
    begin
        :new.sobrenome := 'da ' || :new.sobrenome;
    end;
