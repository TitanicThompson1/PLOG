:- ['info.pl'].
:- use_module(library(lists)).

ageRange(MinAge, MaxAge, Players):-
    findall(Player, (player(Player, _Username, Age), Age =< MaxAge, Age >= MinAge), Players).
    
