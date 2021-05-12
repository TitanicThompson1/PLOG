:- use_module(library(lists)).
:- ensure_loaded('../next_increment.pl').
:- ensure_loaded('../auxiliar.pl').




% attraction(+List, +MoveNRow, +MoveNColumn, +Disk, +DiskRow, +DiskColumn, +VoidOrNot, +Increment, +Type, -FinalList)
% List: list with the gameboard or the row
% MoveNRow: the row number of the placed disk of the move
% MoveNColumn: the column number of the placed disk of the move
% Disk: the affected disk (1 or 2) 
% DiskRow: the row number of the affected disk
% DiskColumn: the column number of the affected disk
% VoidOrNot: if the affected disk is in a void space (3) or not (0)
% Increment: the increment needed to add to be in the neighbour hexagon.  
%            In row attraction, is the increment of column. In diagonal attraction, is the increment of the row.
% Type: if the attraction is in row, diag1 or diag2.
% FinalList: the resulting list

% When there disk is already in the pretended position (row)
attraction(List, _MoveNRow, MoveNColumn,  _Disk, _DiskRow, DiskColumn, _VoidOrNot, Increment, row, List):-
    NewNColumn is MoveNColumn + Increment,
    NewNColumn == DiskColumn.

% When there disk is already in the pretended position (diag1)
attraction(List, MoveNRow, MoveNColumn,  _Disk, DiskRow, DiskColumn, _VoidOrNot, Increment, diag1, List):-
    NeighborNRow is MoveNRow + Increment,
    NeighborNRow == DiskRow,
    increment_column1(MoveNColumn, MoveNRow, Increment, NeighborNColumn),
    NeighborNColumn == DiskColumn.

% When there disk is already in the pretended position (diag2)
attraction(List, MoveNRow, MoveNColumn,  _Disk, DiskRow, DiskColumn, _VoidOrNot, Increment, diag2, List):-
    
    NeighborNRow is MoveNRow + Increment,
    NeighborNRow == DiskRow,
    increment_column2(MoveNColumn, MoveNRow, Increment, NeighborNColumn),
    NeighborNColumn == DiskColumn.


% Attraction action (row)
attraction(List, _MoveNRow, MoveNColumn,  Disk, _DiskRow, DiskColumn, VoidOrNot, Increment, row, FinalList):-

    % Cleaning the previous place of disk
    replace(List, DiskColumn, VoidOrNot, NewRow),

    NewPosition is MoveNColumn + Increment,

    % Moving to the position next to placed disk
    replace(NewRow, NewPosition, Disk, FinalList).


% Attraction action (diag1)
attraction(BoardGame, MoveNRow, MoveNColumn,  Disk, DiskRow, DiskColumn, VoidOrNot, Increment, diag1, FinalBoardGame):-
    
    % calculating the new row and column of the disk
    NeighborNRow is MoveNRow + Increment,
    increment_column1(MoveNColumn, MoveNRow, Increment, NeighborNColumn),

    nth0(DiskRow, BoardGame, RowDisk),
    nth0(NeighborNRow, BoardGame, NeighborRow),

    % Cleaning the previous place of disk
    replace(RowDisk, DiskColumn, VoidOrNot, NewDiskRow),
    replace(BoardGame, DiskRow, NewDiskRow, NewBoardGame),

    % Puting the affected disk in the new position
    replace(NeighborRow, NeighborNColumn, Disk, NewNeigRow),
    replace(NewBoardGame, NeighborNRow, NewNeigRow, FinalBoardGame).


% Attraction action (diag2)
attraction(BoardGame, MoveNRow, MoveNColumn,  Disk, DiskRow, DiskColumn, VoidOrNot, Increment, diag2, FinalBoardGame):-
    
    % calculating the new row and column of the disk
    NeighborNRow is MoveNRow + Increment,
    increment_column2(MoveNColumn, MoveNRow, Increment, NeighborNColumn),

    nth0(DiskRow, BoardGame, RowDisk),
    nth0(NeighborNRow, BoardGame, NeighborRow),

    % Cleaning the previous place of disk
    replace(RowDisk, DiskColumn, VoidOrNot, NewDiskRow),
    replace(BoardGame, DiskRow, NewDiskRow, NewBoardGame),

    % Puting the affected disk in the new position
    replace(NeighborRow, NeighborNColumn, Disk, NewNeigRow),
    replace(NewBoardGame, NeighborNRow, NewNeigRow, FinalBoardGame).