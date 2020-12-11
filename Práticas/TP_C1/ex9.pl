:-use_module(library(clpfd)).

factors(F):-
    F = [F1, F2],

    domain(F, 1, 1000000000),

    has_no_zeros(F1),
    has_no_zeros(F2),

    F1 * F2 #= 1000000000,
    
    F1 #< F2,                  % Eliminates symmetries


    labeling([], F).

has_no_zeros(N):-
    N #> 10,
    N1 #= N mod 10,
    N1 #\= 0,
    NewN #= N // 10,
    has_no_zeros(NewN).

has_no_zeros(N):-
    N #< 10,
    N #\= 0.
