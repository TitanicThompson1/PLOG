:- use_module(library(lists)).
initial(0-0).
final(2-_Y).

ligado(e1, _X-Y, 0-Y). % empty bucket 1
ligado(e2, X-_Y, X-0). % empty bucket 2
ligado(f1, _X-Y, 4-Y). % fill bucket 1
ligado(f2, X-_Y, X-3). % fill bucket 1

ligado('1T2', 0-Y, 0-Y).
ligado('1T2', X-3, X-3).
ligado('1T2', X1-Y1, X2-Y2):-
    NewX1 is X1 - 1,
    NewY1 is Y1 + 1,
    ligado('1T2', NewX1-NewY1, X2-Y2).

path(Final, Final, Path, Sol):- inverte([Final|Path], Sol).
path(Initial, Final, Path, Sol):-
    ligado(X, )


inverte([X], [X]). 
inverte([X|Y], Lista):- 
    inverte(Y, Lista1), append(Lista1, [X], Lista).


b:- initial(Ini), final(Final), path(Ini, Final, [Ini], Path), write(Path).

minB:- initial(Ini), final(Final), 
    setof(Len-Path,  ( path(Ini, Final, [Ini], Path), length(Path, Len)  ), L),
    L = [ MinLen-MinPath | _ ], printa(MinPath).