:- use_module(library(lists)).
:- ensure_loaded('next_increment.pl').



% find_first_disk_row(+RowList, +MoveColumn, +Increment, -Disk, -DiskColumn)
% Finds the first disk of in the row to the right/left of the placed disked (with nº of column MoveColumn)
% RowList: the list of the row
% MoveColumn: the number of the column of the placed disk
% Increment: the increment to be added to pass to the next tile (can be -1 or 1)
% Disk: the nearest disk. With there aren't any, it is 'None'
% DiskColumn: the nearest disk column

find_first_disk_row(RowList, MoveColumn, Increment, Disk, DiskColumn):-

    StartColumn is MoveColumn + Increment,

    % Gets the disk at position StartNColumn
    nth0(StartColumn, RowList, StartDisk),

    find_first_disk_row_rec(RowList, StartColumn, Increment, StartDisk, Disk, DiskColumn).


% find_first_disk_row_rec(+RowList, +StartColumn, +CurrentDisk, -FinalDisk, -DiskColumn)
% This predicate does the recursivity of the find_first_disk_row

% Tests if there is a disk in the current position
find_first_disk_row_rec(_RowList, CurrentColumn, _Increment, 1, 1, CurrentColumn).
find_first_disk_row_rec(_RowList, CurrentColumn, _Increment, 4, 4, CurrentColumn).
find_first_disk_row_rec(_RowList, CurrentColumn, _Increment, 2, 2, CurrentColumn).
find_first_disk_row_rec(_RowList, CurrentColumn, _Increment, 5, 5, CurrentColumn).

% There are no disk on the left side of the Row
find_first_disk_row_rec(_, 0, _Increment, _Disk, 'None', 0).

% There are no disk on the right side of the Row
find_first_disk_row_rec(RowList, CurrentColumn, _Increment, _Disk , 'None', MaxCol):- 
    length(RowList, RowLength),
    MaxCol is RowLength - 1,
    CurrentColumn == MaxCol.

% Moves on to the next position
find_first_disk_row_rec(RowList, CurrentColumn, Increment, _CurrentDisk, FinalDisk, DiskColumn):-
    NewColumn is CurrentColumn + Increment,

    nth0(NewColumn, RowList, NewDisk),
    find_first_disk_row_rec(RowList, NewColumn, Increment, NewDisk, FinalDisk, DiskColumn).




% find_first_disk_diag1(+Boardgame, +MoveNRow, +MoveNColumn, +Increment, -Disk, -DiskRow, -DiskColumn)
% Finds the first disk of in the first diagonal above or down of the placed disked 
% Boardgame: the boardgame
% MoveNRow: the number of the row of the placed disk
% MoveNColumn: the number of the column of the placed disk
% Increment: the direction of the next increment (can be -1 or 1)
% Disk: the nearest disk. With there aren't any, it is 'None'
% DiskRow: the nearest disk row
% DiskColumn: the nearest disk column

find_first_disk_diag1(Boardgame, MoveNRow, MoveNColumn, Increment, Disk, DiskRow, DiskColumn):-
    
    % starting row and column
    NewStartR is MoveNRow + Increment,

    increment_column1(MoveNColumn, MoveNRow, Increment, NewStartC),
    
    nth0(NewStartR, Boardgame, Row),   
    nth0(NewStartC, Row, StartDisk),

    find_first_disk_diag1_rec(Boardgame, NewStartR, NewStartC, Increment, StartDisk, Disk, DiskRow, DiskColumn).

% Tests if there is a disk in the current position
find_first_disk_diag1_rec(_Boardgame, CurrentRow, CurrentColumn, _Increment, 4, 4, CurrentRow, CurrentColumn).
find_first_disk_diag1_rec(_Boardgame, CurrentRow, CurrentColumn, _Increment, 2, 2, CurrentRow, CurrentColumn).
find_first_disk_diag1_rec(_Boardgame, CurrentRow, CurrentColumn, _Increment, 1, 1, CurrentRow, CurrentColumn).
find_first_disk_diag1_rec(_Boardgame, CurrentRow, CurrentColumn, _Increment, 5, 5, CurrentRow, CurrentColumn).

% checks if current position is on the limit of the board
find_first_disk_diag1_rec(_Boardgame, 0, CurrentColumn, _Increment, _CurrentDisk, 'None', 0, CurrentColumn).

find_first_disk_diag1_rec(_Boardgame, CurrentRow, 0, _Increment, _CurrentDisk, 'None', 0, CurrentRow).

% Checks if it has reached the last row
find_first_disk_diag1_rec(Boardgame, CurrentRow, CurrentColumn, _Increment, _CurrentDisk, 'None', CurrentRow, CurrentColumn):-
    
    % Number of rows 
    length(Boardgame, BoardgameLength),
    MaxRow is BoardgameLength - 1,
    CurrentRow == MaxRow.

% Checks if it has reached the last column
find_first_disk_diag1_rec(Boardgame, CurrentRow, CurrentColumn, _Increment, _CurrentDisk, 'None', CurrentRow, CurrentColumn):-
    
    % Number of rows 
    nth0(CurrentRow, Boardgame, Row),
    length(Row, RowLength),
    MaxCol is RowLength - 1,
    CurrentColumn == MaxCol.


find_first_disk_diag1_rec(Boardgame, CurrentRow, CurrentColumn, Increment, _CurrentDisk, Disk, DiskRow, DiskColumn):-
    NewStartR is CurrentRow + Increment,
    increment_column1(CurrentColumn, CurrentRow, Increment, NewStartC),
    nth0(NewStartR, Boardgame, Row),
    nth0(NewStartC, Row, NewDisk),

    find_first_disk_diag1_rec(Boardgame, NewStartR, NewStartC, Increment, NewDisk, Disk, DiskRow, DiskColumn).


% find_first_disk_diag1(+Boardgame, +MoveNRow, +MoveNColumn, +Increment, -Disk, -DiskRow, -DiskColumn)
% Finds the first disk of in the second diagonal above or down of the placed disked 
% Boardgame: the boardgame
% MoveNRow: the number of the row of the placed disk
% MoveNColumn: the number of the column of the placed disk
% Increment: the direction of the next increment (can be -1 or 1)
% Disk: the nearest disk. With there aren't any, it is 'None'
% DiskRow: the nearest disk row
% DiskColumn: the nearest disk column

find_first_disk_diag2(Boardgame, MoveNRow, MoveNColumn, Increment, Disk, DiskRow, DiskColumn):-
    NewStartR is MoveNRow + Increment,
    increment_column2(MoveNColumn, MoveNRow, Increment, NewStartC),
    nth0(NewStartR, Boardgame, Row),
    nth0(NewStartC, Row, StartDisk),

    find_first_disk_diag2_rec(Boardgame, NewStartR, NewStartC, Increment, StartDisk, Disk, DiskRow, DiskColumn).

% Tests if there is a disk in the current position
find_first_disk_diag2_rec(_Boardgame, CurrentRow, CurrentColumn, _Increment, 4, 4, CurrentRow, CurrentColumn).
find_first_disk_diag2_rec(_Boardgame, CurrentRow, CurrentColumn, _Increment, 2, 2, CurrentRow, CurrentColumn).
find_first_disk_diag2_rec(_Boardgame, CurrentRow, CurrentColumn, _Increment, 1, 1, CurrentRow, CurrentColumn).
find_first_disk_diag2_rec(_Boardgame, CurrentRow, CurrentColumn, _Increment, 5, 5, CurrentRow, CurrentColumn).

find_first_disk_diag2_rec(_Boardgame, 0, CurrentColumn, _Increment, _CurrentDisk, 'None', 0, CurrentColumn).

find_first_disk_diag2_rec(_Boardgame, CurrentRow, 0, _Increment, _CurrentDisk, 'None', CurrentRow, 0).

% Checks if it has reached the last row
find_first_disk_diag2_rec(Boardgame, CurrentRow, CurrentColumn, _Increment, _CurrentDisk, 'None', CurrentRow, CurrentColumn):-
    
    % Number of rows 
    length(Boardgame, BoardgameLength),
    MaxRow is BoardgameLength - 1,
    CurrentRow == MaxRow.

% Checks if it has reached the last column
find_first_disk_diag2_rec(Boardgame, CurrentRow, CurrentColumn, _Increment, _CurrentDisk, 'None', CurrentRow, CurrentColumn):-
    
    % Number of rows 
    nth0(CurrentRow, Boardgame, Row),
    length(Row, RowLength),
    MaxCol is RowLength - 1,
    CurrentColumn == MaxCol.


find_first_disk_diag2_rec(Boardgame, CurrentRow, CurrentColumn, Increment, _CurrentDisk, Disk, DiskRow, DiskColumn):-
    NewStartR is CurrentRow + Increment,
    increment_column2(CurrentColumn, CurrentRow, Increment, NewStartC),
    nth0(NewStartR, Boardgame, Row),
    nth0(NewStartC, Row, NewDisk),

    find_first_disk_diag2_rec(Boardgame, NewStartR, NewStartC, Increment, NewDisk, Disk, DiskRow, DiskColumn).