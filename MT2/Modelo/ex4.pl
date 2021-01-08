:- use_module(library(clpfd)).

receitas(NOvos, TempoMax, OvosPorReceita, TempoPorReceita, OvosUsados, Receitas):-
    
    
    Receitas = [R1, R2, R3, R4],
    OvosReceitas = [O1, O2, O3, O4],
    TempoReceitas = [T1, T2, T3, T4],

    length(TempoPorReceita, NReceitas),
    all_distinct(Receitas),
    
    
    domain(Receitas, 1, NReceitas),
    domain(OvosReceitas, 1, NOvos),
    domain(TempoReceitas, 1, TempoMax),
    
    OvosUsados in 1..NOvos,

    elementos(Receitas, OvosPorReceita, OvosReceitas),
    elementos(Receitas, TempoPorReceita, TempoReceitas),

    sum(OvosReceitas, #=, OvosUsados),    
    sum(TempoReceitas, #=<, TempoMax),             

    labeling([maximize(OvosUsados)], Receitas).
    

elementos([], _, []).
elementos([FL1 | L1], L2, [FL3 | L3]):-
    element(FL1, L2, FL3),
    elementos(L1, L2, L3).
    