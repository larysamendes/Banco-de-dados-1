Larysa Mendes
Larysa Mendes#6389

Larysa Mendes — 14/09/2023 19:41
https://meet.google.com/qtb-vqxk-yxo?pli=1
Meet
Real-time meetings by Google. Using your browser, share your video, desktop, and presentations with teammates and customers.
Imagem
Larysa Mendes — 15/09/2023 11:52
Tipo de arquivo em anexo: archive
plp.zip
1.28 MB
Vitória Maria — 15/09/2023 11:59
Tipo de arquivo em anexo: archive
GerenciamentoProjetos-main.zip
14.53 KB
Larysa Mendes — 15/09/2023 12:05
Olha a diferença de tamanho dos dois arquivos
Vitória Maria — 15/09/2023 12:05
A primeira coisa que tens que fazer é refatorar a quantidade de diretórios, porque tem demais kkkkk
Larysa Mendes — 15/09/2023 12:05
tem muita coisa errado no nosso
Larysa Mendes — 15/09/2023 12:05
sim kkkk
deu erro de import?
Imagem
Vitória Maria — 15/09/2023 12:07
calma que tem pasta demais, estou perdida kkkkkk
Larysa Mendes — 15/09/2023 12:07
o meu ja da no teu
Vitória Maria — 15/09/2023 12:11
tenta fazer isso:

https://www.haskell.org/platform/windows.html
cabal update
ghc --version
cabal --version


se o cabal não for tenta o stack:

https://docs.haskellstack.org/en/stable/install_and_upgrade/#windows
Haskell Platform
The Haskell purely functional programming language home page.
Install/upgrade - The Haskell Tool Stack
The Haskell Tool Stack
Larysa Mendes — 15/09/2023 12:11
vcs estão usando esse stack?
Vitória Maria — 15/09/2023 12:12
não, mas como o teu cabal não funciona o stack é uma alternativa
Vitória Maria — 15/09/2023 12:12
Nope
O projeto compila
Larysa Mendes — 15/09/2023 12:14
pois é a forma q a gente esta usando o cabal q esta errada
Vitória Maria — 15/09/2023 12:14
Sim, tentem com stack
O que está atrapalhando, e muito nas importações é a quantidade de diterórios, o main fica "perdido" kkkkk
Olhe o main da gente, só importa uma coisa, tenta refatorar o de vocês
O Setup é oque?
Larysa Mendes — 15/09/2023 12:19
eu n faço ideia kkkk
Vitória Maria — 15/09/2023 12:21
bora entrar em call agora rapidinho para compararmos os dois?
Larysa Mendes — 15/09/2023 12:22
bora
Vitória Maria — 15/09/2023 12:22
no canal da gente
Larysa Mendes — 15/09/2023 12:23
ok
Vitória Maria — 15/09/2023 12:59
Tipo de arquivo em anexo: archive
SGE-PLP.zip
812.75 KB
Vitória Maria — 15/09/2023 13:59
Deu o que no de Vinícius?
Larysa Mendes — 15/09/2023 14:52
Tá indo
Joao está ajudando
Vitória Maria — 15/09/2023 14:52
Que João?
Larysa Mendes — 15/09/2023 15:03
o que era monitor de fmcc
cara é bom de mais
Vitória Maria — 15/09/2023 15:07
Até a ele vocês recorreram kkkkkkk
Ele é monitor de PLP é?
Larysa Mendes — 15/09/2023 15:44
Kkkkk
É não
Ele é gente boa de mais
Vitória Maria — 15/09/2023 15:45
A máquina virtual deu certo?
Verdade, ele paga álgebra com a gente né
Larysa Mendes — 15/09/2023 15:54
n precisa
ele já enisou a nós rodar da maneira certa
Vitória Maria — 15/09/2023 15:55
Que ótimo, então já compila?
Larysa Mendes — 15/09/2023 15:55
sim
se funcionar
na vdd funciona
kkk
Vitória Maria — 15/09/2023 15:56
Aleluia 🙌🏽🙌🏽😅
Vitória Maria — 27/10/2023 12:13
-- 1)
SELECT fornecedor.nome
FROM fornecedor
WHERE fornecedor.nome not in
    (SELECT distinct fornecedor.nome
    FROM fornecedor
Expandir
QuerysGrupo3.sql
4 KB
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
ProjetoFase03Grupo02.sql
9 KB
