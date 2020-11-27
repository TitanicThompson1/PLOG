:- ['info.pl'].

updatePlayer(Player, Game, Hours, Percentage):-
    integer(Hours), integer(Percentage),
    update(Player, Game, Hours, Percentage).

    
    
% para consultar
updatePlayer(Player, Game, Hours, Percentage):-
    played(Player, Game, Hours, Percentage).


% atualiza na base de dados
update(Player, Game, Hours, Percentage):-
    retract(played(Player, Game, Hours1, Percentage1)),
    NewHours is Hours + Hours1,
    NewPer is Percentage1 + Percentage,
    assert(played(Player, Game, NewHours, NewPer)).

% não tem na base de dados
update(Player, Game, Hours, Percentage):-
    assert(played(Player, Game, Hours, Percentage)).


% updatePlayer('Best Player Ever', 'Duas Botas', Hours, Percentage).
% updatePlayer('Best Player Ever', 'Duas Botas', 5, 12).
% updatePlayer('Best Player Ever', 'Duas Botas', Hours, Percentage).
