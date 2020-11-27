:- ['info.pl'].

fewHours(Player, Games):-
    fewHours_rec(Player, [], Games), !.
   

fewHours_rec(Player, Acc, Games):-
    played(Player, Game, Hours, _Perc),
    \+ my_member(Game, Acc),
    Hours < 10,
    fewHours_rec(Player, [Game|Acc], Games).

fewHours_rec(_Player, Games, Games).



my_member(_Ele, []):- fail.
my_member(Ele , [Ele |_Rest]).
my_member(Ele , [_First |Rest]):- my_member(Ele, Rest).
