:- ['info.pl'].
:- use_module(library(lists)).


averageAge(Game, AverageAge):-
    findall(Age, (played(Username, Game, _Hours, _Perc), player(_Name, Username, Age)), Ages),
    sumlist(Ages, SumAges),
    length(Ages, LengthAges),
    AverageAge is SumAges/LengthAges.
    
    
    