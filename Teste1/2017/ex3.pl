:- ['info.pl'].

timePlayingGames(Player, Games, ListOfTimes, SumTimes):-
    get_all_played_times(Player, Games, ListOfTimes),
    my_sum_list(ListOfTimes, SumTimes).


get_all_played_times(_, [],[]).
get_all_played_times(Player, [FirstGame | RestOfGames], [ HoursPlayed |ListOfTimes]):-
    played(Player, FirstGame, HoursPlayed, _PercentUnlocked),
    get_all_played_times(Player, RestOfGames, ListOfTimes).

get_all_played_times(Player, [FirstGame | RestOfGames], [ 0 | ListOfTimes]):-
    \+ played(Player, FirstGame, _HoursPlayed, _PercentUnlocked),
    get_all_played_times(Player, RestOfGames, ListOfTimes).

my_sum_list([], 0).
my_sum_list([First | Rest], Sum):-
    my_sum_list(Rest, Sum1),
    Sum is Sum1 + First.

