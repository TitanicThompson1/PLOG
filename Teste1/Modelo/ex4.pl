:-['info.pl'].

% bestParticipant(+P1, +P2, -P)

bestParticipant(P1, P2, P):-
    get_time_sum(P1, TimeP1),
    get_time_sum(P2, TimeP2),
    check_who_is_best(P1, TimeP1, P2, TimeP2, P).


get_time_sum(Participant, Time):-
    performance(Participant, Times),
    sum_all(Times, Time).


check_who_is_best(P1, TimeP1, _P2, TimeP2, P):-
    TimeP1 > TimeP2,
    P = P1.


check_who_is_best(_P1, TimeP1, P2, TimeP2, P):-
    TimeP2 > TimeP1,
    P = P2.

sum_all([Ele], Ele).
sum_all([First | Rest], SumFinal):-
    sum_all(Rest, Sum),
    SumFinal is Sum + First.

