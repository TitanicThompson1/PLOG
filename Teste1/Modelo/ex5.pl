:- ['info.pl'].

allPerfs:-
    performance(Id, Times),
    participant(Id, _Age, NameOfPerf),
    write(Id), write(':'), write(NameOfPerf), write(':'), write(Times), nl,
    fail.

allPerfs.
