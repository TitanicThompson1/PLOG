casado(ana, barbara).
casado(antonio, bruno).

%casado(X, Y) :- once(casado(Y, X)), Y\==X.

combina(peru, vinhoMaduro).
combina(frango, cerveja).
combina(salmao, vinhoVerde).
combina(solha, vinhoVerde).

gosta(ana, peru).
gosta(ana, vinhoMaduro).
gosta(ana, vinhoVerde).
gosta(barbara, frango).
gosta(barbara, vinhoVerde).
gosta(antonio, salmao).
gosta(antonio, solha).
gosta(antonio, vinhoVerde).
gosta(bruno, frango).
gosta(bruno, cerveja).




?- casado(ana, bruno), gosta(ana, vinhoVerde), gosta(bruno, vinhoVerde).

?- combina(salmao, Bebida).

?- combina(Comida, vinhoVerde).