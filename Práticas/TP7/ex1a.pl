salto_cavalo(R/C, RF/CF):-
    (movimento(DistR, DistC); movimento(DistC, DistR)),
    RF is R + DistR, 
    CF is C + DistC,
    dentro_do_tab(RF),
    dentro_do_tab(CF).


movimento(2, -1).
movimento(2, 1).
movimento(-2, 1).
movimento(-2, -1).

dentro_do_tab(X):- X =< 8, 0 =< X.

    
