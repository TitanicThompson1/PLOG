
ordenada(X) :- length(X, 0).
ordenada(X) :- length(X, 1).

ordenada([Element1, Element2|Trail]) :-
    Element1 =< Element2,
    ordernada_rec(Element2, Trail).

ordernada_rec(X, []).
ordernada_rec(Element1, [Element2| Trail]) :-
    Element1 =< Element2,
    ordernada_rec(Element2, Trail).

% consult('ex10a.pl').
% ordenada([1, 2, 3, 4]).
% ordenada([]).
% ordenada([1]).
% ordenada([1, 5, 6, 7, 8, 1]).
% ordenada([1, 3, 2]).

% ordenada([N]).
% ordenada([N1,N2]):- N1 =< N2.
% ordenada([N1,N2|Resto]):-
% N1 =< N2,
% ordenada([N2|Resto]).