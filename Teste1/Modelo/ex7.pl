:- use_module(library(lists)).
:- ['info.pl'].

juriFans(JuriFansList):-
    findall(Participant-Fav, (performance(Participant, Times), get_fav(Times, Fav)), JuriFansList).

get_fav(Times, Fav):-
    findall(Njuri, (performance(_Participant, Times), nth1(Njuri, Times, TimeValue), TimeValue == 120), Fav).


