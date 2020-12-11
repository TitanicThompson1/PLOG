:-use_module(library(clpfd)).  % Não esquecer de colocar em todos os programas!
nqueens(Cols):-
    Cols=[A1,A2,A3,A4],
    domain(Cols,1,4),
    all_distinct(Cols),% A1#\=A2, A1#\A3, A1#\A4, A2#\A3, A2#\A4, A3#\A4,
    A1#\=A2+1, A1#\=A2-1, A1#\=A3+2, A1#\=A3-2, A1#\=A4+3, A1#\=A4-3,A2#\=A3+1, A2#\=A3-1, A2#\=A4+2, A2#\=A4-2,A3#\=A4+1, A3#\=A4-1,
    labeling([],Cols).