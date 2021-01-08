:- use_module(library(clpfd)).

objecto(piano, 3, 30).
objecto(cadeira, 1, 10).
objecto(cama, 3, 15).
objecto(mesa, 2, 15).

homens(4).

tmax(60).


distribuir:-

    homens(NHomens), tmax(TempoMax),
    findall(Nome, objecto(Nome, _, _), Objectos),
    length(Objectos, NObjs),
    
    length(TemposIniciais, NObjs),
    length(TemposFinais, NObjs),
    length(Atribuicao, NObjs),
    
    domain(TemposIniciais, 0, TempoMax),
    domain(TemposFinais, 0, TempoMax),
    domain(Atribuicao, 1, NHomens),

    cria_tarefas(Objectos, Tarefas, TemposIniciais, TemposFinais),


    cumulative(Tarefas, [limit(NHomens)]),

    labeling([], TemposIniciais),
    labeling([], TemposFinais),
    labeling([], Atribuicao),
    write(TemposIniciais), nl,
    write(TemposFinais)
    


cria_maquinas(0, [], _, _).
cria_maquinas(NHomens, [ machine(I, 1) | Maquinas], I, TempoMax):-
    NewNH is NHomens - 1,
    NewI is I + 1,
    cria_maquinas(NewNH, Maquinas, NewI, TempoMax).

cria_tarefas([], [], [], [], []).
cria_tarefas([ FO | Objectos], [task(Inicio, Minutos, Fim, Minutos, Homem) | Tarefas], [Inicio | TI], [Fim | TF], [Homem | Atrs]):-
    objecto(FO, NHomens, Minutos),
    cria_tarefas(Objectos, Tarefas, TI, TF, Atrs).
