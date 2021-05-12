:-use_module(library(clpfd)).

ex2:-
    
    Musicos = [ Joao, Antonio, Francisco],  % Harpa 0, Violino 1, Piano 2

    domain(Musicos, 0, 2),
    all_distinct(Musicos),
    

    Antonio #\= 2,
    Joao #\= 1 #/\ Joao #\= 2,

    labeling([], Musicos),
    write(Musicos).