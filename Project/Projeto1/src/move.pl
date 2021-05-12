:- ensure_loaded('auxiliar.pl').
:- ensure_loaded('moves.pl').
:- ensure_loaded('find_first_disk.pl').
:- ensure_loaded('actions/action.pl').
:- ensure_loaded('Points.pl').

% move(+Game, +Move, -NewGame)
% This predicate verifies if the move is valid and then makes it. If the move isn't valid, the predicate fails.
% Game: GameBoard plus GameState
% Move: the move to be made
% NewGame: the GameState and GameBoard after the move

move(Game, Move, FinalGame):-
    
    % validates the move
    validate_move(Game, Move), !,
    
    % moves the piece and process the board
    process_move(Game, Move, NewGame),

    % checks if points were made
    points(NewGame, FinalGame).
    

validate_move([GameState | Boardgame],  [Player, Move, Disk | _]):-

    % gets the possible moves 
    valid_moves([GameState | Boardgame], Player, ListOfMoves),

    % verifies if move belongs to the List
    member(Move, ListOfMoves),

    % verifies if has disks of that color to play
    has_disks(Player, Disk, GameState).


process_move([GameState | Boardgame], [Player, Move, Disk | _], [FinalGameState | FinalBoardGame]) :-
    
    % gets row and column associated to the move
    pos_to_row_col(Move, Row, Column),

    % puts the piece in the board
    put_piece(Boardgame, Row, Column, Disk, NewBoard1),
    
    % decreases the number of disks of the player
    decrease_number_disk(GameState, Player, Disk, FinalGameState),
    
    % checks if there are disks in the row and applies repulsion and/or attraction
    process_row(NewBoard1, Row, Column, Disk, NewBoard2),

    % checks if there are disks in the first diagonal and applies repulsion and/or attraction
    process_first_diagonal(NewBoard2, Row, Column, Disk, NewBoard3),

    % checks if there are disks in the second diagonal and applies repulsion and/or attraction
    process_second_diagonal(NewBoard3, Row, Column, Disk, FinalBoardGame).
    

% puts the piece in the correct position
put_piece(Boardgame, Row, Column, Disk, NewBoard) :-
    nth0(Row, Boardgame, SpecificRow),
    replace(SpecificRow, Column, Disk, NewRow),
    replace(Boardgame, Row, NewRow, NewBoard).

% process_row predicate is divided in two: the left row, and the right row
process_row(Boardgame, Row, Column, Disk, FinalBoardGame):-
    process_left_row(Boardgame, Disk, Row, Column, NewBoard),
    process_right_row(NewBoard, Disk, Row, Column, FinalBoardGame).
    

% Finds the nearest disk and does the attraction/repulsion 
process_left_row(Boardgame, MoveDisk, MoveNRow, MoveNColumn,  FinalBoardGame) :-
    nth0(MoveNRow, Boardgame, RowList),

    % finds the first disk in the left row. If there is none, returns None in variable ClosestDisk
    find_first_disk_row(RowList, MoveNColumn, -1, ClosestDisk, ClosestDiskNCol),

    % does the repulsion or attraction
    do_action(RowList, _, MoveNColumn, MoveDisk, ClosestDisk, _, ClosestDiskNCol, -1, row, FinalRow),
    
    % replaces the old row for the new row
    replace(Boardgame, MoveNRow, FinalRow, FinalBoardGame).


% This predicate is similar to the above. The difference is that the increment is now 1 (because it is the right row)
process_right_row(Boardgame, MoveDisk, MoveNRow, MoveNColumn,  FinalBoardGame):-   
    nth0(MoveNRow, Boardgame, RowList),
    
    find_first_disk_row(RowList, MoveNColumn, 1, ClosestDisk, ClosestDiskNCol),
    
    do_action(RowList, _, MoveNColumn, MoveDisk, ClosestDisk, _, ClosestDiskNCol, 1, row, FinalRow),
    
    replace(Boardgame, MoveNRow, FinalRow, FinalBoardGame).
    

% similar to process_row
process_first_diagonal(Boardgame, Row, Column, Disk, FinalBoardGame):-
    process_upper_diag1(Boardgame, Row, Column, Disk, NewBoard),
    process_inferior_diag1(NewBoard, Row, Column, Disk, FinalBoardGame).

% similar to process_row
process_second_diagonal(Boardgame, Row, Column, Disk, FinalBoardGame):-
    process_upper_diag2(Boardgame, Row, Column, Disk, NewBoard),
    process_inferior_diag2(NewBoard, Row, Column, Disk, FinalBoardGame).

% the logic of this predicate is similar to the process row left/right. The difference is that the auxilary predicates uses the all board
process_upper_diag1(Boardgame, MoveNRow, MoveNColumn, MoveDisk, FinalBoardGame):-
    find_first_disk_diag1(Boardgame, MoveNRow, MoveNColumn, -1, ClosestDisk, ClosestDiskNRow, ClosestDiskNCol),
    do_action(Boardgame, MoveNRow, MoveNColumn, MoveDisk, ClosestDisk, ClosestDiskNRow, ClosestDiskNCol, -1, diag1, FinalBoardGame).

% similar to upper_diag1, but the increment is 1
process_inferior_diag1(Boardgame, MoveNRow, MoveNColumn, MoveDisk, FinalBoardGame):-
    find_first_disk_diag1(Boardgame, MoveNRow, MoveNColumn, 1, ClosestDisk, ClosestDiskNRow, ClosestDiskNCol),
    do_action(Boardgame, MoveNRow, MoveNColumn, MoveDisk, ClosestDisk, ClosestDiskNRow, ClosestDiskNCol, 1, diag1, FinalBoardGame).

% similar to upper_diag1, but for the second diagonal
process_upper_diag2(Boardgame, MoveNRow, MoveNColumn, MoveDisk, FinalBoardGame):-
    find_first_disk_diag2(Boardgame, MoveNRow, MoveNColumn, -1, ClosestDisk, ClosestDiskNRow, ClosestDiskNCol),
    do_action(Boardgame, MoveNRow, MoveNColumn, MoveDisk, ClosestDisk, ClosestDiskNRow, ClosestDiskNCol, -1, diag2, FinalBoardGame).

% similar to upper_diag2, but the increment is -1
process_inferior_diag2(Boardgame, MoveNRow, MoveNColumn, MoveDisk, FinalBoardGame):-
    find_first_disk_diag2(Boardgame, MoveNRow, MoveNColumn, 1, ClosestDisk, ClosestDiskNRow, ClosestDiskNCol),
    do_action(Boardgame, MoveNRow, MoveNColumn, MoveDisk, ClosestDisk, ClosestDiskNRow, ClosestDiskNCol, 1, diag2, FinalBoardGame).

