conta([], 0).
conta([Element|Trail], N) :-
    N1 is N-1,
    conta(Trail, N1).

% consult('ex8a.pl').
% conta([1, 2, 3], 3).
% conta([1, 2, 3, 4, 5], 5).
% conta([1, 2, 3], 5).
% conta([1, 2, 3, 4, 5], 3).