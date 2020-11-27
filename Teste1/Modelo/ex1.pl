:- ['info.pl'].

% madeItThrough(+Participant)

madeItThrough(Participant):-
    participant(Participant,_,_),
    performance(Participant, Times),
    madeItThrough_rec(Times).

madeItThrough_rec([]).
madeItThrough_rec([Time | RestOfTimes]):-
    Time == 120,
    madeItThrough_rec(RestOfTimes).