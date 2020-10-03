% Pessoas: João, Maria, Ana, homem, mulher
% Sitio: casa, apartamento, mora_em 
% Animais: cão gato, tigre, animal, gosta_de
% Jogos: jogo, damas, xadrez
% Desportos: desporto, tenis, natacao


homem(joao).
mulher(ana).
mulher(maria).

mora_em(joao, apartamento).
mora_em(ana, casa).
mora_em(maria, casa).

animal(cao).
animal(gato).
animal(tigre).

jogo(xadrez).
jogo(damas).

desporto(tenis).
desporto(natacao).

gosta_de(joao, tigre).
gosta_de(ana, cao).
gosta_de(maria, cao).

gosta_de(joao, damas).
gosta_de(ana, xadrez).
gosta_de(maria, xadrez).

gosta_de(joao, natacao).
gosta_de(ana, tenis).
gosta_de(maria, tenis).

%Quem mora num apartamento e gosta de animais?
?- mora_em(Pessoa, apartamento), gosta_de(Pessoa, _Animal), animal(_Animal).

%Será que o João e a Maria moram numa casa e gostam de desportos?
?- mora_em(joao, casa), mora_em(maria, casa), gosta_de(joao, _Desporto1), desporto(_Desporto1), gosta_de(maria, _Desporto2), desporto(_Desporto2).

%Quem gosta de jogos e de desportos?
?- gosta_de(Pessoa, Jogo), jogo(Jogo), gosta_de(Pessoa, Desporto), desporto(Desporto).

%Existe alguma mulher que gosta de ténis e gosta de tigres?
?- gosta_de(Mulher, tenis), gosta_de(Mulher, tigre), mulher(Mulher).

