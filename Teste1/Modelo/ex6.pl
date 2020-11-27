:- use_module(library(lists)).
:- ['info.pl'].

nSuccessfulParticipants(T):-
    findall(Part, (performance(Part, Times),all_hundred_twenty(Times)), Bag),
    length(Bag, T   ).
    

all_hundred_twenty([]).
all_hundred_twenty([Time | RestOfTimes]):-
    Time == 120,
    all_hundred_twenty(RestOfTimes).