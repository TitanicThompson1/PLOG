:-use_module(library(clpfd)).

guardas(Rooms):-
    Rooms = [R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12],        % this represents the rooms and the amount of guards on them
    
    domain(Rooms, 0, 12),
    sum(Rooms, #=, 12),                 % the number of guards must be 12
    
    5 #= R1 + R2 + R3 + R4,             % Side1
    5 #= R1 + R5 + R7 + R9,             % Side2
    5 #= R4 + R6 + R8 + R12,            % Side3
    5 #= R9 + R10 + R11 + R12,          % Side4

    R1 #< R4, R1 #< R9, R4 #> R9, R7 #> R10,       % Removing symmetries

    labeling([], Rooms), write(Rooms).


    
    

