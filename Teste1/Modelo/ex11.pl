:- use_module(library(lists)).

impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

langford(N, L) :-
    Length is 2 * N,
    length(L, Length),
    langford(N, L, Length).

langford(0, _, _).

langford(N, L, Length) :-
    impoe(N, L),
    N1 is N - 1,
    langford(N1, L, Length).