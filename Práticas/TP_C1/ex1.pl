:-use_module(library(clpfd)).

% a
quad_mag3(Quad):-
    Quad = [A, B, C, 
            D, E, F, 
            G, H, I],

    domain(Quad, 1, 9),

    all_distinct(Quad),
    
    A + B + C #= S,
    D + E + F #= S,
    G + H + I #= S,
    
    A + D + G #= S,
    B + E + H #= S,
    C + F + I #= S,
    
    A + E + I #= S,
    C + E + G #= S,

    A #< C, A #< G, C #< G, 

    labeling([], Quad).
    


quad_mag4(Quad):-
    Quad = [A, B, C, D,
            E, F, G, H, 
            I, J, K, L,
            M, N, O, P],

    domain(Quad, 1, 16),

    all_distinct(Quad),
    
    A + B + C + D #= S,
    E + F + G + H #= S,
    I + J + K + L #= S,
    M + N + O + P #= S,
 
    A + E + I + M #= S,
    B + F + J + N #= S,
    C + G + K + O #= S,
    D + H + L + P #= S,

    A + F + K + P #= S,
    D + G + J + M #= S,

    A #< D, A #< M, D #< M, A #< P, 

    labeling([], Quad).

% b

quad_mag(Size, Quad):-

    create_quad(Size, Quad).





create_quad(0, []).
create_quad(Size, [A | Rest]):-
    NewSize is Size - 1,
    create_quad(NewSize, Rest).
  

    

    
