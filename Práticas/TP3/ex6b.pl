
delete_one(Element, List, InterList) :-
    append(La, [Element|Lb], List),
    append(La, Lb, InterList).

delete_all(Element, List, FinalList) :-
    append(La, [Element|Lb], List),
    append(La, Lb, InterList),
    delete_acc(Element, InterList, La, FinalList).

delete_acc(Element, FinalList, [], FinalList).
delete_acc(Element, List, Acc, FinalList) :-
    append(La, [Element|Lb], List),
    append(La, Lb, FinalList),
    delete_acc(Element, InterList, La, FinalList).


% consult('ex6b.pl').
% delete_all(1,[1,2],X).
% delete_all(2,[1,2,2],X).
% delete_all(2,[1,2,2,2,2,2,2,3,4,5],X).