:-use_module(library(clpfd)).

% o carro verde é o primeiro, mas no enunciado diz "carro  verde  está depois  do  carro  azul"
semaforo(Positions):-
    Positions = [PY, PG, PBlu, PBla],           % positions of yellow, green, blue and black cars
    Sizes = [S1, S2, S3, S4],                   % sizes of cars in order

    domain(Positions, 1, 4),
    domain(Sizes, 1, 4),

    all_distinct(Positions), all_distinct(Sizes),

    % First Restriction

    % after blue and before blue
    Restr1Pos #= PBlu - 1, Restr2Pos #= PBlu + 1,
    element(Restr1Pos, Sizes, SelSize1),
    element(Restr2Pos, Sizes, SelSize2),
    
    SelSize1 #< SelSize2,

    % Second restriction

    element(PG, Sizes, SizeGreen), SizeGreen #= 1,
    

    % 3º e 4º restriction

    %PG #= PBlu + 1, 
    PY #= PBla + 1,

    labeling([], Positions).
    

    

    

