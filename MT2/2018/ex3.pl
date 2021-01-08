:- use_module(library(clpfd)).

prog2(N,M,L1,L2) :-
    length(L1, N),
    N1 is N - 1, length(L2, N1),
    domain(L1, 1, M),
    domain(L2, 1, M),
    all_distinct(L1),
    
    check(L1, L2),
    nth1(1, L1, First),
    nth1(N, L1, Last),
    First #< Last,
    
    labeling([], L1).

check([_],[]).
check([A, B | R],[X | Xs]) :-
    A + B #= X,
    
    check([B | R], Xs).