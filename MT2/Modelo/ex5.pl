:- use_module(library(clpfd)).

embrulha(Rolos, Presentes, RolosSelecionados):-
    length(Presentes, NPresentes),
    length(Presentes, NRolos),
    length(RolosSelecionados, NPresentes),

    %domain(RolosSelecionados, 1, NRolos),
    constroi_items(Presentes, RolosSelecionados, Itens),
    constroi_bin(Rolos, Bins, 1),

    bin_packing(Itens, Bins),

    labeling([], RolosSelecionados).
    


constroi_items([], [], []).
constroi_items([FP | Presentes], [FR | RolosSelecionados], [item(FR, FP) | Resto]):-
    constroi_items(Presentes, RolosSelecionados, Resto).

constroi_bin([], [], _).
constroi_bin([R1 | Rolos], [bin(N, R1) | Bins], N):-
    NewN is N + 1,
    constroi_bin(Rolos, Bins, NewN).
