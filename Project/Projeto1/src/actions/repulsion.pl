
:- use_module(library(lists)).
:- ensure_loaded('../auxiliar.pl').
:- ensure_loaded('../find_first_disk.pl').
:- ensure_loaded('../next_increment.pl').



% repulsion(+List, +DiskRow, +DiskColumn, +Disk, +Increment, +Type, -FinalList) 
% This predicate does the action of repulsion into the board
% List: list with the gameboard or the row
% DiskColumn: the column number of the disk that is going to suffer repulsion
% Disk: the disk that is going to suffer repulsion
% Increment: the increment needed to add to be in the neighbour hexagon 
% Type: if the attraction is in row, diag1 or diag2.
% FinalList: the resulting list

repulsion(List, _, DiskColumn, Disk, Increment, row, FinalList):-

    % This predicate finds the new position of the affected disk 
    find_first_disk_row(List, DiskColumn, Increment, NextDisk, NextDiskColumn),

    % calculates the new position of the affected disk.
    calculate_new_positions(NextDisk, NextDiskColumn, Increment, Disk, FinalDisk, FinalDiskColumn),


    % Cleaning the previous place of disk
    replace(List, DiskColumn, 0, NewRow),

    % Moving to the calculated position
    replace(NewRow, FinalDiskColumn, FinalDisk, FinalList).



repulsion(BoardGame, DiskRow, DiskColumn, Disk, Increment, diag1, FinalBoardGame):-
    
    % This predicate finds the new position of the affected disk 
    find_first_disk_diag1(BoardGame, DiskRow, DiskColumn, Increment, NextDisk, NextDiskRow, NextDiskColumn),

    % calculates the new position of the affected disk.
    calculate_new_positions_diag1(NextDisk, NextDiskRow, NextDiskColumn, Increment, Disk, FinalDisk, FinalDiskRow, FinalDiskColumn),

    nth0(DiskRow, BoardGame, RowDisk),
    nth0(FinalDiskRow, BoardGame, FinalRow),

    % Cleaning the previous place of disk
    replace(RowDisk, DiskColumn, 0, NewDiskRow),
    replace(BoardGame, DiskRow, NewDiskRow, NewBoardGame),

    % Puting the affected disk in the new position
    replace(FinalRow, FinalDiskColumn, FinalDisk, NewFinalRow),
    replace(NewBoardGame, FinalDiskRow, NewFinalRow, FinalBoardGame).


repulsion(BoardGame, DiskRow, DiskColumn, Disk, Increment, diag2, FinalBoardGame):-
    
    % This predicate finds the new position of the affected disk 
    find_first_disk_diag2(BoardGame, DiskRow, DiskColumn, Increment, NextDisk, NextDiskRow, NextDiskColumn),

    % calculates the new position of the affected disk.
    calculate_new_positions_diag2(NextDisk, NextDiskRow, NextDiskColumn, Increment, Disk, FinalDisk, FinalDiskRow, FinalDiskColumn),

    nth0(DiskRow, BoardGame, RowDisk),
    nth0(FinalDiskRow, BoardGame, FinalRow),

    % Cleaning the previous place of disk
    replace(RowDisk, DiskColumn, 0, NewDiskRow),
    replace(BoardGame, DiskRow, NewDiskRow, NewBoardGame),

    % Puting the affected disk in the new position
    replace(FinalRow, FinalDiskColumn, FinalDisk, NewFinalRow),
    replace(NewBoardGame, FinalDiskRow, NewFinalRow, FinalBoardGame).



% the predicate find_first_disk_row didnt found any disk, so its going to void
calculate_new_positions('None', NextDiskColumn, _, Disk, NewDisk, NextDiskColumn):-
    NewDisk is Disk + 3.

% find_first_disk_row found a disk, and the new position of the affected disk is next to the found disk
calculate_new_positions(_, NextDiskColumn, Increment, Disk, Disk, NewDiskColumn):-
    NewDiskColumn is NextDiskColumn - Increment.


% the predicate find_first_disk_row didnt found any disk, so its going to void
calculate_new_positions_diag1('None', NextDiskRow, NextDiskColumn, _Increment, Disk, FinalDisk, NextDiskRow, NextDiskColumn):-
    FinalDisk is Disk + 3.

% find_first_disk_diag1 found a disk, and the new position of the affected disk is next to the found disk
calculate_new_positions_diag1(_, NextDiskRow, NextDiskColumn, Increment, Disk, Disk, FinalDiskRow, FinalDiskColumn):-
    FinalDiskRow is NextDiskRow - Increment,
    NewIncrement is 0 - Increment,
    increment_column1(NextDiskColumn, NextDiskRow, NewIncrement, FinalDiskColumn).

% the predicate find_first_disk_row didnt found any disk, so its going to void
calculate_new_positions_diag2('None', NextDiskRow, NextDiskColumn, _Increment, Disk, FinalDisk, NextDiskRow, NextDiskColumn):-
    FinalDisk is Disk + 3.

% find_first_disk_diag2 found a disk, and the new position of the affected disk is next to the found disk
calculate_new_positions_diag2(_, NextDiskRow, NextDiskColumn, Increment, Disk, Disk, FinalDiskRow, FinalDiskColumn):-
    FinalDiskRow is NextDiskRow - Increment,
    NewIncrement is 0 - Increment,
    increment_column2(NextDiskColumn, NextDiskRow, NewIncrement, FinalDiskColumn).