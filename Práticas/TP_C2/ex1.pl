:-use_module(library(clpfd)).

maquinista:-
    People = [Rev, Fog, Maq, Pas1, Pas2, Pas3],
    Places = [Detr, HalfPoint, Chic], % cada variavel possui onde vive as pessoas
    Payday = [PRev, PFog, PMaq, PPas1, PPas2, PPas3]

    domain(People, 0, 5),
    domain(Payday, 0, 5),
    

    Detr #= 1,
    HalfPoint #= Rev,
    %
    Fog #\= 5,
    %
    Chic #= Rev


