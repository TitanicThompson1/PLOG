conta_elem(X, List, 0) :- \+ member(X, List).

conta_elem(X, List, N) :-
    N > 0,
    N1 is N-1,
    append(_, [X | Trail], List),
    conta_elem(X, Trail, N1).

% consult('ex8b.pl').
% conta_elem(1, [2, 1, 2, 1, 2], 2).
% conta_elem(1, [2, 1, 2, 2], 2).
% conta_elem(1, [2, 1, 2, 2, 4, 5, 1, 0, 7, 1], 3).
% conta_elem(1, [2, 1, 2, 2, 4, 5, 1, 0, 7, 1], 2).
% conta_elem(1, [2, 1, 2, 2, 4, 5, 1, 0, 7, 1], 4).