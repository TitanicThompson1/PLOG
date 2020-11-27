:- use_module(library(lists)).
vence([X],X,[]). % para ganhar apanha todos os fósforos 

vence(L,X,L1):- % vence se faz uma jogada a partir da qual o adversario
    joga(L,X,L1), % não vence 
    \+ vence(L1,_,_).

joga(S,X,S1):- % apanha todos os fósforos duma pilha 
    delete(S, X, S1). 

joga(S,X,S2):- % apanha alguns fósforos 
    delete(Y,S,S1), 
    bet(0, Y, X),  % X entre 0 e Y 
    Y1 is Y-X, 
    insert(Y1,S1,S2).


bet(N, M, K) :- N =< M, K = N.
bet(N, M, K) :- N < M, N1 is N+1, bet(N1, M, K).