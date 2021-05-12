% nº discs in Gain(P1), nº discs in Risk(P1), nº discs in Gain(P2), nº discs in Risk(P2), nº Red/Blue discs(P1), nº Red/Blue discs (P2)
:- use_module(library(lists)).
:- ensure_loaded('AI.pl').
:- ensure_loaded('auxiliar.pl').

% This predicate calculates the points after a move.
% points(+Game, -FinalGame).
% Game: the original Board
% FinalGame: Board after point calculation
points(Game, FinalGame):-
    get_and_process_points(Game,  FinalGame).

get_and_process_points([GameState|GameBoard], FinalGame):-
    get_flatten_board(GameBoard, ConciseBoard),
    % searches the red groups and then adds them to the score (if their length is greater the 4) 
    search_red_positions(ConciseBoard, RedGroups),
   
    score_points([GameState|GameBoard],RedGroups, r, NewGame),
    % searches the blue groups and then adds them to the score (if their length is greater the 4)
    search_blue_positions(ConciseBoard, BlueGroups),
    
    score_points(NewGame, BlueGroups, b, FinalGame).

search_blue_positions(ConciseBoard, Groups):-
    
    % finds all blue disks in void or not 
    findall(N, (nth1(N, ConciseBoard, 2);nth1(N, ConciseBoard, 5)), BluePositions),
    % finds all near disks
    checkNear(BluePositions, [], NearFinalList),
    checkBlue(ConciseBoard, NearFinalList, _NearGroups, NearFinalGroups),
   
    arrange_into_groups(NearFinalGroups, Groups).

search_red_positions(ConciseBoard, Groups):-

    % finds all red disk in void or not
    findall(N, (nth1(N, ConciseBoard, 1);nth1(N, ConciseBoard, 4)), RedPositions),
    
    checkNear(RedPositions, [], NearFinalList),
    
    checkRed(ConciseBoard, NearFinalList, _NearGroups, NearFinalGroups),
    
    arrange_into_groups(NearFinalGroups, Groups).

% Given a List of lists containing all near cells to a cell removes all non blue cells
checkBlue(_ConciseBoard, [], NearGroups,NearGroups).
checkBlue(ConciseBoard, [FirstBlueList|NearFinalList], NearGroups, NearFinalGroups):-
    % Removes all non blue cells
    checkAllBlues(ConciseBoard,FirstBlueList, _FinalFirstBlueList, List),
    
    append(NearGroups,[List],NearGroups2),
    
    checkBlue(ConciseBoard, NearFinalList, NearGroups2,NearFinalGroups).

% Given a List of lists containing all near cells to a cell removes all non red cells
checkRed(_ConciseBoard, [], NearGroups,NearGroups).
checkRed(ConciseBoard, [FirstRedList|NearFinalList], NearGroups, NearFinalGroups):-
    % Removes all non red cells
    checkAllReds(ConciseBoard,FirstRedList, _FinalFirstRedList, List),
    
    append(NearGroups,[List],NearGroups2),
    
    checkRed(ConciseBoard, NearFinalList, NearGroups2,NearFinalGroups).

% Checks if cell is Red non void
checkAllReds(_ConciseBoard,[], FinalFirstRedList, FinalFirstRedList).
checkAllReds(ConciseBoard,[First|FirstRedList], FinalFirstRedList, List):-
    % Searches First cell position in ConciseBoard
    nth1(First,ConciseBoard,X),
    % Sees if cell has a red piece
    X=:=1,!,
    
    append(FinalFirstRedList,[First],FinalFirstRedList2),
    
    checkAllReds(ConciseBoard,FirstRedList, FinalFirstRedList2, List).

% Checks if cell is Red void
checkAllReds(ConciseBoard,[First|FirstRedList], FinalFirstRedList, List):-
    % Searches First cell position in ConciseBoard
    nth1(First,ConciseBoard,X),
    % Sees if cell has red void piece
    X=:=4,!,
    
    append(FinalFirstRedList,[First],FinalFirstRedList2),
    
    checkAllReds(ConciseBoard,FirstRedList, FinalFirstRedList2, List).

% If the cell is empty does not add to Final list of reds
checkAllReds(ConciseBoard,[_First|FirstRedList], FinalFirstRedList, List):-
    checkAllReds(ConciseBoard,FirstRedList, FinalFirstRedList, List).

% Checks if cell is Blue non void
checkAllBlues(_ConciseBoard,[], FinalFirstBlueList, FinalFirstBlueList).
checkAllBlues(ConciseBoard,[First|FirstBlueList], FinalFirstBlueList, List):-
    nth1(First,ConciseBoard,X),
    % Sees if cell has blue piece
    X=:=2,!,
    
    append(FinalFirstBlueList,[First],FinalFirstBlueList2),
    
    checkAllBlues(ConciseBoard,FirstBlueList, FinalFirstBlueList2, List).

% Checks if cell is Blue void
checkAllBlues(ConciseBoard,[First|FirstBlueList], FinalFirstBlueList, List):-
    nth1(First,ConciseBoard,X),
    % Sees if cell has blue void piece
    X=:=5,!,
    
    append(FinalFirstBlueList,[First],FinalFirstBlueList2),
    
    checkAllBlues(ConciseBoard,FirstBlueList, FinalFirstBlueList2, List).

% If the cell is empty does not add to Final list of blues
checkAllBlues(ConciseBoard,[_First|FirstBlueList], FinalFirstBlueList, List):-
    checkAllBlues(ConciseBoard,FirstBlueList, FinalFirstBlueList, List).


% Gets all near pieces
checkNear([], NearList, NearList).
checkNear([Position1|Positions], NearList, NearFinalList):-
    get_Line_length(Position1, Line_length),
    % Checks all surrounding cells to Position1
    next_to(Position1, NearListPosition1, Line_length),
    % Adds to near list of position1 to Near list (being the first piece in the list position1 itself)
    append(NearList,[[Position1|NearListPosition1]],NearListWithP1),
    
    checkNear(Positions, NearListWithP1, NearFinalList).

% Gets length of cells line
get_Line_length(Position1,Line_length):-
    Position1<5,!,
    Line_length is 3.

get_Line_length(Position1,Line_length):-
    Position1<10, Position1>4,!,
    Line_length is 4.

get_Line_length(Position1,Line_length):-
    Position1<16, Position1>9,!,
    Line_length is 5.

get_Line_length(Position1,Line_length):-
    Position1<23, Position1>15,!,
    Line_length is 6.

get_Line_length(Position1,Line_length):-
    Position1<29, Position1>22,!,
    Line_length is 5.

get_Line_length(Position1,Line_length):-
    Position1<34, Position1>28,!,
    Line_length is 4.

get_Line_length(Position1,Line_length):-
    Position1>33,!,
    Line_length is 3.

% Gets flatten board
get_flatten_board(GameBoard, ConciseBoard):-
    myflatten(GameBoard,ConciseBoard).




% This predicates checks which lists have commun elements and joins them. For example:
% [[14], [24, 23, 25], [25, 24, 26], [26, 25, 27], [27, 26]] results in [[14], [23, 24, 25, 26, 27]]
arrange_into_groups([], []).
arrange_into_groups([First| Rest], [ResultFinal | Final]):-
    
    % finds all lists that have elements in commun 
    findall(L, (member(L, Rest), any_commun(First, L)), Bag),
    
    % this includes the First in the result
    append(Bag, First, NewBag),
    myflatten(NewBag, BagFlatten),

    % the proposite of sort is to remove duplicates
    sort(BagFlatten, Result1),
    length(Result1, ResultLength),
    
    % if the were any lists joined together, its needed to repeat the above procedure
    repeat_arrange([Result1 |Rest], ResultLength, ResultFinal),
    
    % deletes all lists in rest that 
    delete_communs(ResultFinal, Rest, NewRest),

    % recursive call
    arrange_into_groups(NewRest, Final).
    

% repeats the search and join
repeat_arrange( [Result |Rest], PreviousLength, ResultFinal):-

    % finds all lists that have elements in commun 
    findall(L, (member(L, Rest), any_commun(Result, L)), Bag),

    % this includes the First in the result
    append(Bag, Result, NewBag),
    myflatten(NewBag, BagFlatten),

    % the proposite of sort is to remove duplicates
    sort(BagFlatten, NewResult),
    length(NewResult, ResultLength),


    decide_repeat(NewResult, Rest, ResultLength, PreviousLength, ResultFinal).


% No new results were added
decide_repeat(NewResult, _Rest, ResultLength, ResultLength, NewResult).

% Results were added, so its needed to search and join again
decide_repeat(NewResult, Rest, ResultLength, _PreviousLength, ResultFinal):-
    repeat_arrange( [NewResult |Rest], ResultLength, ResultFinal).



% any_commun(+List1, +List2)
% This predicate checks if the two list have any element in commun
any_commun([], _List):- fail.
any_commun([First|_RestOf], List2):-
    member(First, List2).

any_commun([_First|RestOf], List2):-
    any_commun(RestOf, List2).


% delete_communs(+List1, +List2, -Result)
% This predicate checks if any element of List1 is present on any of the inner lists of List2. If it his, it deletes the inner list. The result is stored on Result
delete_communs(_List1, [], []).
delete_communs(List1, [First2|List2], [First2|Result]):-
    \+ any_commun(List1, First2),
    delete_communs(List1, List2, Result).
    
delete_communs(List1, [_First2|List2], Result):-
    delete_communs(List1, List2, Result).
    


% score_points(+Game, +Group, +Player, -FinalGame)
% This function sees which groups have more the 4 disks together and then moves the ones at void to the risk area and the others to the gain  

score_points(Game,[],_Player, Game).

score_points(Game, [FirstList|RestGroup], Player, FinalGame):-
    
    % Sees if the group has more then 3 disks. If not, continues to the next group
    scores_or_not(Game, FirstList, Player, NewGame),
    score_points(NewGame, RestGroup, Player, FinalGame).


scores_or_not(Game, ListDisk, Player, NewGame):-
    length(ListDisk, Len), Len > 3,
    
    % Replaces all the disks and puts them in the respective area 
    replace_all(Game, ListDisk, Player, NewGame).


% if the group of disks isnt big enough
scores_or_not(GameBoard, _FirstList, _Player, GameBoard).


replace_all(Game, [], _Player, Game).

replace_all([GameState|GameBoard], [First|ListDisks], Player, [FinalGameState|FinalGameBoard] ):-
    deflatten_coords(First, Row, Column),
    nth0(Row, GameBoard, RowList),
    replace_and_score([GameState|GameBoard], RowList, Row, Column, Player, NewRow, NewGameState),
    replace(GameBoard, Row, NewRow, NewGameBoard),
    replace_all([NewGameState|NewGameBoard], ListDisks, Player, [FinalGameState|FinalGameBoard]).


% if the disk is in a void space
replace_and_score([GameState|GameBoard], RowList, Row, Column, Player, NewRow, NewGameState):-
    length(RowList, LenCol), length(GameBoard, LenRow),
    MaxCol is LenCol - 1, MaxRow is LenRow - 1,
    (Column == 0; Column == MaxCol; Row == 0; Row == MaxRow), 
    replace(RowList, Column, 3, NewRow),
    add_to_risk(GameState, Player, NewGameState).

% if the disk is not in void
replace_and_score([GameState|_GameBoard], RowList, _Row, Column, Player, NewRow, NewGameState):-
    replace(RowList, Column, 0, NewRow),
    add_to_gain(GameState, Player, NewGameState).



    


    
%points([ [0, 0, 0, 0, 10, 5, 5, 10],[3, 3, 3, 5],[3, 2, 0, 2, 3], [3, 0, 0, 0, 1, 3], [3, 0, 0, 0, 0, 0, 3],[4, 0, 0, 0, 0, 3],[3, 0, 0, 0, 3],[5, 3, 4, 4]],F).