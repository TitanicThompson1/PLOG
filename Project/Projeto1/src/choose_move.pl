:- use_module(library(random)).

:- ensure_loaded('moves.pl').
:- ensure_loaded('move.pl').
:- ensure_loaded('auxiliar.pl').
:- ensure_loaded('AI.pl').

% choose_move(+Game, +Player, +Level, -Move)​.
% This predicate chooses the next for the computer accordingly to the level

choose_move(Game, Player, Level, Move):-
    valid_moves(Game, Player, ListOfMoves),
    pick_move(Game, Player, Level, ListOfMoves, Move).    
    
% pick_move(+Game, +Player, +Level, +ListOfMoves, -Move)
% Picks the move accordingly to the level
% Game: the current state of the game.
% Player: the current player (r/b).
% Level: the level of the computer (easy/normal).
% ListOfMoves: the list of possible moves.
% Move: the picked move.


% Move for the easy level (pics an move at random)
pick_move([GameState|_GameBoard], Player, easy, ListOfMoves, [Player, MoveN, Disk]):-
    length(ListOfMoves, Size),
    random(0, Size, Choosen),
    nth0(Choosen, ListOfMoves, MoveN),
    choose_color_disk(GameState, Player, Disk).


% Move for the normal level. It does all possible moves, evaluates them and picks the one that generates the maximum value
pick_move(Game, Player, normal, ListOfMoves, [Player, Move, Disk]):-

    evaluate_moves(Game, Player, ListOfMoves, ListOfValues),

    % finds the index of the maximum value
    find_max_index(ListOfValues, NMaxValue),

    % getting the maximum move number an the move itself
    get_move_n(NMaxValue, MoveN),
    get_specific_move(MoveN, ListOfMoves, Move),

    % getting the disk
    get_color_disk(NMaxValue, Disk).



choose_color_disk(GameState, r, Disk):-
    get_players_disks(GameState, RR, RB, _BR, _BB),
    RR\==0, RB \==0,
    random(1, 3, Disk).

choose_color_disk(GameState, r, Disk):-
    get_players_disks(GameState, RR, _RB, _BR, _BB),
    RR\==0, Disk = 1.

choose_color_disk(GameState, r, Disk):-
    get_players_disks(GameState, _RR, RB, _BR, _BB),
    RB\==0, Disk = 2.

choose_color_disk(GameState, b, Disk):-
    get_players_disks(GameState, _RR, _RB, BR, BB),
    BR\==0, BB \==0,
    random(1, 3, Disk).

choose_color_disk(GameState, b, Disk):-
    get_players_disks(GameState, _RR, _RB, BR, _BB),
    BR\==0, Disk = 1.

choose_color_disk(GameState, b, Disk):-
    get_players_disks(GameState, _RR, _RB, _BR, BB),
    BB\==0, Disk = 2.




% evaluate_moves(+Game, +Player, +ListOfMoves, -ListOfValues)
% This predicate evaluates all moves and puts in the ListOfValues

evaluate_moves(_, _,[], []).
evaluate_moves(Game, Player, [MoveN | RestOfMove], [ValueR, ValueB | ListOfValues]):-

    % puts a red disk in the tile MoveN
    do_red_move(Game, Player, MoveN, ValueR),

    % puts a blue disk in the tile MoveN
    do_blue_move(Game, Player, MoveN, ValueB),

    % calls recursivly to evaluate all movements of the list
    evaluate_moves(Game, Player, RestOfMove, ListOfValues).




% places a red disk in MoveN
do_red_move(Game, Player, MoveN, ValueR):-
    move(Game, [Player, MoveN, 1], NewGame),
    value(NewGame, Player, ValueR).


% doesnt have red disks
do_red_move(_Game, _Player, _MoveN, -1).


% places a blue disk in MoveN
do_blue_move(Game, Player, MoveN, ValueB):-
    move(Game, [Player, MoveN, 2], NewGame),
    value(NewGame, Player, ValueB).

% doesnt have blue disks
do_blue_move(_Game, _Player, _MoveN, -1).


get_move_n(-1, -1).
    

% Checks if MaxValue is even. If it, then the index of the choosen move is NMaxValue divided by 2 (because the size of the list
% of values is double of the size of the list of moves) 
get_move_n(NMaxValue, MoveN):-    
    Rest is NMaxValue mod 2, Rest == 0,
    MoveN is div(NMaxValue, 2).

% If its odd, its needed to add 1 so it becomes even and then the division can be done
get_move_n(NMaxValue, MoveN):-
    NewN is NMaxValue + 1,
    MoveN is div(NewN, 2).


% Gets the move. If MoveN is negative (it means there ins't an maximum), picks on at random 
get_specific_move(-1, ListOfMoves, Move):-
    length(ListOfMoves, Size),
    random(0, Size, Choosen),
    nth0(Choosen, ListOfMoves, Move).

get_specific_move(MoveN, ListOfMoves, Move):-
    nth1(MoveN, ListOfMoves, Move).



% Gets the color associated with the value. Even values are blue, odd are red.
get_color_disk(NMaxValue, 2):-
    Rest is NMaxValue mod 2, Rest == 0.

get_color_disk(_NMaxValue, 1).
