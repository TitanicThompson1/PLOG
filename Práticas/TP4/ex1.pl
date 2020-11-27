ligado(a, b). 
ligado(a, c). 
ligado(b, d). 
ligado(b, e). 
ligado(b, f). 
ligado(c, g). 
ligado(d, h). 
ligado(d, i).
ligado(f, i).
ligado(f, j).
ligado(f, k).
ligado(g, l).
ligado(g, m).
ligado(k, n).
ligado(i, f).

membro(X, [X|_]):- !.
membro(X, [_|Y]):- membro(X,Y).

concatena([], L, L). 
concatena([X|Y], L, [X|Lista]):- 
    concatena(Y, L, Lista).

inverte([X], [X]). 
inverte([X|Y], Lista):- 
    inverte(Y, Lista1), concatena(Lista1, [X], Lista).

% resolva_prof(No_inicial, No_meta, Solucao).

resolva_prof(No_inicial, No_meta, Solucao):-
    profundidade([], No_inicial, No_meta, Sol_inv),       
    inverte(Sol_inv, Solucao).

% Realiza a pesquisa em profundidade 
profundidade(Caminho, No_meta, No_meta, [No_meta|Caminho]). 
profundidade(Caminho, No, No_meta, Sol):-       
    ligado(No, No1),            
    not membro(No1, Caminho),            % previne ciclos       
    profundidade([No|Caminho], No1, No_meta, Sol).


% resolva_larg(No_inicial, No_meta, Solucao)

resolva_larg(No_inicial, No_meta, Solucao):-


largura(Caminho, No, No_meta, [No_meta | Sol]):-
    findall(X, ligado(No, X), Bag),
    member(No_meta, Bag).

largura(Caminho, No, No_meta, [No_meta | Sol]):-
    findall(X, ligado(No, X), Bag),
    

    
    

