:- use_module(library(lists)).

process([], []).
process([First| Rest], [Result1 | Final]):-

    findall(L, (member(L, Rest), any_commun(First, L)), Bag),
    append(Bag, First, NewBag),
    myflatten(NewBag, BagFlatten),

    % the proposite of sort is to remove duplicates
    sort(BagFlatten, Result1),
    delete_communs(Result1, Rest, NewRest),
    process(NewRest, Final).
    

any_commun([], _List):- fail.   
any_commun([First|_RestOf], List2):-
    member(First, List2).

any_commun([_First|RestOf], List2):-
    any_commun(RestOf, List2).


delete_communs(_List1, [], []).
delete_communs(List1, [First2|List2], [First2|Result]):-
    \+ any_commun(List1, First2),
    delete_communs(List1, List2, Result).
    
delete_communs(List1, [_First2|List2], Result):-
    delete_communs(List1, List2, Result).



myflatten([],[]).

%% For a non-empty list: flatten the head and flatten the tail and
%% append the results.
myflatten([Head|InTail],Out) :-
	myflatten(Head,FlatHead),
	myflatten(InTail,OutTail),
	append(FlatHead,OutTail,Out).
%% When trying to flatten the head, you might find that the head is
%% not itself a list. In this case the head of the input list simply
%% becomes the head of the output list. 
myflatten([Head|InTail], [Head|OutTail]) :-
	Head \= [],
	Head \= [_|_],
        myflatten(InTail,OutTail).



score_points_red(FinalGameBoard,_List, FinalGameBoard).

score_points_red(GameBoard, [FirstList|RedGroups], FinalGameBoard):-
    scores_or_not(GameBoard, FirstList, NewGameBoard),
    score_points_red(NewGameBoard, [FirstList|RedGroups], FinalGameBoard).


scores_or_not(GameBoard, ListRed, NewGameBoard):-
    length(ListRed, Len), Len > 3,
    replace_all(GameBoard, ListRed, NewGameBoard).


replace_all(GameBoard, [First|ListRed], NewGameBoard).
    pos_to_row_col(First, Row, Column),
    nth0(Row, GameBoard, RowList),
    replace_and_score(RowList, Column, NewRow)



scores_or_not(GameBoard, _FirstList, GameBoard).
    