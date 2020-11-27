:- ['info.pl'].
:- use_module(library(lists)).

mostEffectivePlayers(Game, Players):-
    setof(Best-Player, Percentage^Hours^(played(Player, Game, Hours, Percentage), Best is Percentage/Hours), Set),
    find_max(Set, NewSet),
    get_players(NewSet, Players).


find_max(Set, Players):-
    length(Set, LengthSet),
    nth1(LengthSet, Set, Effect-MaxPlayer),
    StartLength is LengthSet - 1,
    find_max_rec(Set, StartLength, [Effect-MaxPlayer], Players).

find_max_rec(Set, StartLength, [LastEffect-LastPlayer|Acc], Players):-
    
    nth1(StartLength, Set, Effect-MaxPlayer),
    Effect == LastEffect,
    NewLengthSet is StartLength - 1,
    find_max_rec(Set, NewLengthSet, [Effect-MaxPlayer, LastEffect-LastPlayer|Acc], Players).


find_max_rec(_Set, _StartLength, Players, Players).
    
get_players([_Effect-Player], [Player]).
get_players([_Effect-Player|Rest], [Player |RestPlayer]):-
    get_players(Rest, RestPlayer).




    
    