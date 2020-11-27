:- ['info.pl'].

achievedALot(Player):-
    played(Player, _Game, _HoursPlayed, Percentage),
    Percentage >= 80.