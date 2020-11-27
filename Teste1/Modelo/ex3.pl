:- ['info.pl'].


patientJuri(JuriMember):-
    get_all_performances(Performances),
    get_all_juri_times(Performances, JuriMember, Times),
    count_abstence(Times, Sum),
    Sum > 1.

get_all_performances(Performances):- get_all_performances_rec([], Performances).


get_all_performances_rec(Acc, Performances):-
    performance(X, _),
    \+ my_member(X, Acc),
    get_all_performances_rec([X | Acc], Performances).

get_all_performances_rec(Performances, Performances).


get_all_juri_times([], _JuriMember, []).

get_all_juri_times([FirstPerfomance | RestOfPerformances], JuriMember, [ Time | Times]):-
    performance(FirstPerfomance, PerfomanceTime),
    my_nth1(JuriMember, PerfomanceTime, Time),
    get_all_juri_times(RestOfPerformances, JuriMember, Times).


count_abstence([], 0).

count_abstence([FirstTime |Times], Sum):-
    FirstTime == 120,
    count_abstence(Times, Sum1),
    Sum is Sum1 + 1.


count_abstence([FirstTime |Times], Sum):-
    FirstTime < 120,
    count_abstence(Times, Sum).


my_nth1(1, [First | _Rest], First).
my_nth1(N, [_First | Rest], Ele):-
    N > 0,
    N1 is N-1,
    my_nth1(N1, Rest, Ele).

my_member(_Ele, []):- fail.
my_member(Ele, [Ele | _Rest]).
my_member(Ele, [_First | Rest]):-
    my_member(Ele, Rest).
