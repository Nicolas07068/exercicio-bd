-- exercicio 1
create table nomes (
    nome varchar(50)
);

insert into nomes (nome)
values 
('Roberta'),
('Roberto'),
('Maria Clara'),
('João');

select upper(nome) from nomes;

select nome, length(nome) as tamanho from nomes;

select
    case
        when nome like '%Maria%' then concat('Sra. ', nome)
        else concat('Sr. ', nome)
    end as nome_com_tratamento
from nomes;

-- exercicio 2
create table produtos (
    produto varchar(50),
    preco decimal(10, 2),
    quantidade int
);

insert into produtos (produto, preco, quantidade)
values 
('Produto A', 25.99, 10),
('Produto B', 15.49, 0),
('Produto C', 35.75, 5);

select produto, round(preco, 2) as preco_arredondado from produtos;

select produto, abs(quantidade) as quantidade_absoluta from produtos;

select avg(preco) as media_precos from produtos;

-- exercicio 3
create table eventos (
    data_evento date
);

insert into eventos (data_evento)
values 
('2023-01-15'),
('2023-02-20'),
('2023-03-10');

insert into eventos (data_evento) values (now());
select datediff('2023-03-10', '2023-01-15') as dias_entre_eventos;
select data_evento, dayname(data_evento) as dia_semana from eventos;

-- exercicio 4
select produto,
       if(quantidade > 0, 'Em estoque', 'Fora de estoque') as status_estoque
from produtos;

select produto,
       case 
           when preco < 20 then 'Barato'
           when preco >= 20 and preco <= 50 then 'Médio'
           else 'Caro'
       end as categoria_preco
from produtos;

-- exercicio 5
delimiter //

create function total_valor(preco decimal(10, 2), quantidade int)
returns decimal(10, 2)
begin
    declare total decimal(10, 2);
    set total = preco * quantidade;
    return total;
end //

delimiter ;

select produto, preco, quantidade, total_valor(preco, quantidade) as valor_total from produtos;

-- exercicio 6
select count(*) as total_produtos from produtos;

select produto, preco from produtos where preco = (select max(preco) from produtos);

select produto, preco from produtos where preco = (select min(preco) from produtos);

select sum(if(quantidade > 0, preco * quantidade, 0)) as valor_total_em_estoque from produtos;

-- exercicio 07


delimiter //

create function calcular_fatorial (n int)
returns int
begin
	declare resultado int default 1;
    declare i int default 1;
    while i<= n do
		set resultado = resultado * i;
        set i= i + 1;
	end while; 
    return resultado;
end //

delimiter ;

select calcular_fatorial(5) as fatorial_5



delimiter // 

create function calcular_exponencial (base int, expoente int)
returns int
begin
	declare resultado int default 1;
    declare i int default 1;
    while i <= expoente do 
		set resultado = resultado * base;
        set i = i + 1;
	end while; 
    return resultado;
end //

delimiter ;

select calcular_exponencial (2,3) as exponencial_2;



delimiter //

create function verificar_palindromo(palavra varchar(255))
returns int
begin
    declare reverso varchar(255);
    set reverso = reverse(palavra);
    if palavra = reverso then
        return 1;
    else
        return 0;
    end if;
end //

delimiter ;

select verificar_palindromo('radar') as e_palindromo;