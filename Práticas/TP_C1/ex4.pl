:-use_module(library(clpfd)).

cryptogram1(Vars):-
    Vars = [S, E, N, D, M, O, R, Y],
    Carriers = [C1, C2, C3, C4],

    domain(Vars, 0, 9),
    domain(Carriers, 0, 1),

    all_distinct(Vars),
    
    S #\= 0, M #\= 0,

    D + E #= C1 * 10 + Y,
    N + R + C1 #= C2 * 10 + E,
    E + O + C2 #= C3 * 10 + N,
    S + M + C3 #= C4 * 10 + O,
    M #= C4,

    labeling([], Vars).



    
    
