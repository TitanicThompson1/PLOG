:- ['info.pl'].

listGamesOfCategory(Cat):-
    game(Name, Categories, MinAge),
    my_member(Cat, Categories),
    write(Name), write(' ('), write(MinAge), write(')'), nl,
    fail.

listGamesOfCategory(_).


    
my_member(_Ele, []):- fail.
my_member(Ele , [Ele |_Rest]).
my_member(Ele , [_First |Rest]):- my_member(Ele, Rest).



