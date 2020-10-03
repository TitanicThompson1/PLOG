comprou(joao, honda).
comprou(joao, uno).

ano(honda, 1997).
ano(uno, 1998).

valor(honda, 20000).
valor(uno, 7000).


/*
Crie uma regra pode_vender onde o primeiro argumento é a pessoa, o segundo o carro e o
terceiro é o ano actual (não especificar “homem” ou “carro” nas regras), onde a pessoa só pode
vender o carro se o carro for comprado por ela nos últimos 10 anos e se seu valor for menor do que
10000 Euros.
*/

pode_vender(Pessoa, Carro, Ano) :- comprou(Pessoa, Carro), ano(Carro, Ano1), Ano1 @>= Ano-10, valor(Carro, Valor), Valor @<10000.