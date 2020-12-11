:-use_module(library(clpfd)).

queen_problem(NN):-
    
    
    NN = [C1, C2, C3, C4],              % We already know that there are no queens in the same row. The position 
                                        % in the list is the row

    domain(NN, 1, 4),

    all_distinct(NN),                   % Columns must be distinct
 
    abs(C1 - C2) #\= 1,                 %cant be in the same diagonal
    abs(C1 - C3) #\= 2,
    abs(C1 - C4) #\= 4,
    abs(C2 - C3) #\= 1,
    abs(C2 - C4) #\= 2,
    abs(C3 - C4) #\= 1,

    C2 #< C3,                           % eliminating simetries 

    labeling([],NN).

nqueen(N, Cols):-

    length(Cols, N),
    domain(Cols, 1, N),

    all_distinct(Cols),

    put_rest_of_restrictions(Cols),

    element(1, Cols, First), element(N, Cols, Last),

    First #< Last,              % Eliminating symmetries    

    labeling([], Cols).

put_rest_of_restrictions([]).
put_rest_of_restrictions([Col | Cols]):-
    propragate(Col, Cols, 1),
    put_rest_of_restrictions(Cols).

propragate(_, [], _).
propragate(Col, [Col2 | Cols], N):-
    abs(Col - Col2) #\= N,
    N1 is N + 1,
    propragate(Col, Cols, N1).




