ligado(a,b). 
ligado(a,c). 
ligado(b,d). 
ligado(b,e). 
ligado(b,f). 
ligado(c,g). 
ligado(d,h). 
ligado(d,i).
ligado(f,i).
ligado(f,j).
ligado(f,k).
ligado(g,l).
ligado(g,m).
ligado(k,n).
ligado(i,f).

membro(X, [X|_]):- !.
membro(X, [_|Y]):- membro(X,Y).

concatena([], L, L).
concatena([X|Y], L, [X|Lista]):- concatena(Y, L, Lista).

inverte([X], [X]).
inverte([X|Y], Lista):- inverte(Y, Lista1), concatena(Lista1, [X], Lista).