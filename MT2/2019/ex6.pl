:- use_module(library(clpfd)).
:- use_module(library(lists)).

prat(Prateleiras, Objectos, Vars):-
    length(Objectos, NObjs),
    length(Vars, NObjs),
    length(Prateleiras, NPrateleiras),

    domain(Vars, 1, NObjs),

    constroi_maqs(Prateleiras, 1, Maquinas),
    constroi_tarefas(Objectos, Tarefas),

    %restringe_pesos(Vars, NPrateleiras, 0),
    write(Tarefas), nl,
    write(Maquinas),
    
    cumulatives(Tarefas, Maquinas, [bound(upper)]),
    
    labeling([], Vars).


constroi_maqs([], _, []).
constroi_maqs([FP | Prateleiras], I, NewMaqs):-
    constroi_maq(FP, I, Maq, NewI),
    constroi_maqs(Prateleiras, NewI, Maqs),
    append(Maq, Maqs, NewMaqs).
    
    
constroi_maq([], I, _, I).
constroi_maq([FSpace | RP], I, [machine(I, FSpace) | RM], FinalI):-
    NewI is I + 1,
    constroi_maq(RP, NewI, RM, FinalI).
    

constroi_tarefas([], []).
constroi_tarefas([Peso-Vol | Prat], [task(1, 1, 2, Vol, Maq) | Resto]):-    
    constroi_tarefas(Prat, Resto).


restringe_pesos([], _, _).
restringe_pesos([F | Vars], NPrateleiras, I):-
    EPrimeira is I mod NPrateleiras,
    restringe(F, EPrimeira),
    NewI is I + 1,
    restringe_pesos(Vars, NPrateleiras, NewI).

restringe(F ).
