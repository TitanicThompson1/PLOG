appende([],L,L).
appende([X|L1],L2,[X|L3]) :- appende(L1,L2,L3).