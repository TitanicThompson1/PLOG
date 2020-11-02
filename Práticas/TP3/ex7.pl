before(Element1, Element2, List) :-
    append(X,[Element1|Trail1], List),
    append([Element1|Trail1_1],[Element2|Trail2], [Element1|Trail1]).

% before(1, 2, [1, 2]).
% before(2, 1, [1, 2]).
% before(1, 2, [3, 4, 2, 1]).
% before(1, 2, [3, 4, 1, 2]).
% before(1, 2, [3, 4, 1, 2, 3, 5, 6]).
% before(1, 2, [3, 4, 2, 1, 3, 5, 6]).