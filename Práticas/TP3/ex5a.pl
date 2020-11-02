
membro(X, [X | _]).
membro(X,[Y | L]) :-
    X \= Y,
    membro(X,L). 

?- membro([1,2],[[1,2],3,5]).
?- membro(1,[2,3,1]).
?- membro(0,[2,3,1]).