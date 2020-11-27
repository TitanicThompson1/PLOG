:- ['info.pl'].

onlyPlayesMatureGames(Username):-
    player(Name, Username, Age), !,
    \+ (played(Username, Game, HoursPlayed, PercentUnlocked), game(Game, Categories, MinAge), MinAge > Age).

