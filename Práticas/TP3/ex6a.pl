delete_one(Element, List, FinalList):-
    append(La, [Element|Lb], List),                 %La é a parte da lista antes de Element. Lb é a parte da lista depois de Element
    append(La, Lb, FinalList).

% consult('ex6a.pl').
?- delete_one(1,[1,2],X).
?- delete_one(2,[1,2],X).