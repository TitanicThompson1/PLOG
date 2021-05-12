
:- ensure_loaded('attraction.pl').
:- ensure_loaded('repulsion.pl').


% do_action(+BoardGame, +MoveNRow, +MoveNColumn, +MoveDisk, +ClosestDisk, +ClosestDiskNRow, +ClosestDiskNCol, +Increment, +Type, -FinalBoardGame)
% Chooses what is the appropriate action (repulsion or attraction), and makes it. Returns the board game after the action  
% BoardGame: the initial boardgame
% MoveNRow: the row of the placed disk
% MoveNColumn: the column of the placed disk
% MoveDisk: the placed disk
% ClosestDisk: the closest disk
% ClosestDiskNRow: the row of the closest disk
% ClosestDiskNCol: the column of the closest disk
% Increment: In the case of row, it is the increment to be added to get to the next tile (1 or -1). In case of the diagonal, it is the direction of the increment (1 or -1).
% Type: if it is a row, first or second diagonal (row, diag1, diag2).
% FinalBoardGame: the board after the action.

% No action
do_action(BoardGame, _, _, _, 'None', _, _, _, _, BoardGame).

% The disk is already at void (repulsion)
do_action(BoardGame, _, _, 1, 4, _, _, _, _, BoardGame).

% Interaction of Red with Red
do_action(BoardGame, _, _, 1, 1, ClosestDiskNRow, ClosestDiskNCol, Increment, Type, FinalBoardGame):-
    repulsion(BoardGame, ClosestDiskNRow, ClosestDiskNCol, 1, Increment, Type, FinalBoardGame).

% Interaction of Red with Blue
do_action(List, MoveNRow, MoveNColumn, 1, 2, ClosestDiskNRow, ClosestDiskNCol, Increment, Type, FinalBoardGame):-
    attraction(List, MoveNRow, MoveNColumn, 2, ClosestDiskNRow, ClosestDiskNCol, 0, Increment, Type, FinalBoardGame).

% Interaction of Red with Blue in void
do_action(List, MoveNRow, MoveNColumn, 1, 5, ClosestDiskNRow, ClosestDiskNCol, Increment, Type, FinalBoardGame):-
    attraction(List, MoveNRow, MoveNColumn, 2, ClosestDiskNRow, ClosestDiskNCol, 3, Increment, Type, FinalBoardGame).

% The disk is already at void (repulsion)
do_action(BoardGame, _, _, 2, 5, _, _, _, _,BoardGame).

% Interaction of Blue with Red
do_action(List, MoveNRow, MoveNColumn, 2, 1, ClosestDiskNRow, ClosestDiskNCol, Increment, Type, FinalBoardGame):-
    attraction(List, MoveNRow, MoveNColumn, 1, ClosestDiskNRow, ClosestDiskNCol, 0, Increment, Type, FinalBoardGame).

% Interaction of Blue with Blue
do_action(BoardGame, _, _, 2, 2, ClosestDiskNRow, ClosestDiskNCol, Increment, Type, FinalBoardGame):-
    repulsion(BoardGame, ClosestDiskNRow, ClosestDiskNCol, 2, Increment, Type, FinalBoardGame).

% Interaction of Blue with Red in void
do_action(List, MoveNRow, MoveNColumn, 2, 4, ClosestDiskNRow, ClosestDiskNCol, Increment, Type, FinalBoardGame):-
    attraction(List, MoveNRow, MoveNColumn, 1, ClosestDiskNRow, ClosestDiskNCol, 3, Increment, Type, FinalBoardGame).
