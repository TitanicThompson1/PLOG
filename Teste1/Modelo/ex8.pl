:- use_module(library(lists)).
:- ['info.pl'].


nextPhase(N, Participants):-
    findall(TT-Id-Perf, eligibleOutcome(Id, Perf, TT), Participants).


eligibleOutcome(Id, Perf, TT):-
    performance(Id, Times),
    madeItThrough(Id),
    participant(Id, _, Perf),
    sumlist(Times,TT).


madeItThrough(Participant):-
    participant(Participant, _, _),
    performance(Participant, Times),
    madeItThrough_rec(Times).

madeItThrough_rec([]).
madeItThrough_rec([Time | RestOfTimes]):-
    Time == 120,
    madeItThrough_rec(RestOfTimes).
