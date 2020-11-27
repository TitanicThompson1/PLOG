:- ['ex1a.pl'].

trajecto_cavalo([Traj]).

trajecto_cavalo([P1, P2| Traj]):-
    salto_cavalo(P1, P2),
    trajecto_cavalo([P2 | Traj]).


    