nth_membro(1,[M|_],M).
nth_membro(N,[_|T],M):-
    N>1,
    N1 is N-1,
    nth_membro(N1,T,M).