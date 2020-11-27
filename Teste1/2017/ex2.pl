:- ['info.pl'].

isAgeAppropriate(Name, Game):-
    player(Name, _Username, Age),
    game(Game, _Categories, MinAge),
    Age >= MinAge.