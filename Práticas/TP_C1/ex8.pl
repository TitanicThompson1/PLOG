:-use_module(library(clpfd)).

% em teoria funciona mas o sicstus está estupido

mercearia:-
    P = [PAr, PB, PE, PAt],             % Price of every object

    domain(P, 1, 711),                  % em centimos

    % Sum must be equal to product
    sum(P, #=, 711),                    % sum(P, #=, 711),
    PAr * PB * PE * PAt #= 711,

    PB #> PAt, PAt #> PAr,

    PE #< PB, PE #< PAt, PE #< PAr,     % minimum(PE, P),

    divisive_by_ten(P, 2),

    labeling([], P).
    
divisive_by_ten([], 0).
divisive_by_ten([P1 | RestOfP], N):-
    P1 mod 10 #= 0 #<=> N1,
    N #= N1 + N2,
    divisive_by_ten(RestOfP, N2).
                    
