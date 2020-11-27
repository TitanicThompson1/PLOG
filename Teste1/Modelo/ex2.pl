:- ['info.pl'].

% juriTimes(+Participants, +JuriMember, -Times, -Total)

juriTimes(Participants, JuriMember, Times, Total):-
    get_times(Participants, JuriMember, Times),
    sum_all(Times, Total).


get_times([Participant], JuriMember, [JuriTime]):-
    performance(Participant, PartTimes),
    my_nth1(JuriMember, PartTimes, JuriTime).


get_times([ Participant | Participants], JuriMember, [JuriTime |Times]):-
    performance(Participant, PartTimes),
    my_nth1(JuriMember, PartTimes, JuriTime),
    get_times(Participants, JuriMember, Times).


my_nth1(1, [First | _Rest], First).
my_nth1(N, [_First | Rest], Ele):-
    N > 0,
    N1 is N-1,
    my_nth1(N1, Rest, Ele).

sum_all([Ele], Ele).
sum_all([First | Rest], SumFinal):-
    sum_all(Rest, Sum),
    SumFinal is Sum + First.



    