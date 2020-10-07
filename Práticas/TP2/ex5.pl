e_primo(N) :- 
    N1 is N-1,
    is_not_divisible(N1,N).

is_not_divisible(1,N).
    
is_not_divisible(A,N) :-
    0 =\= mod(N,A),
    A1 is A-1,
    is_not_divisible(A1,N).
