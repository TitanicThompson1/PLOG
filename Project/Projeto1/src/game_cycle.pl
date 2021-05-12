:- ensure_loaded('display.pl').
:- ensure_loaded('game_over.pl').
:- ensure_loaded('choose_move.pl').
:- ensure_loaded('auxiliar.pl').
:- ensure_loaded('../boards/InitialBoard.pl').
:- use_module(library(system)).


% do_game(+Mode, +Level).
% This predicate startes the game loop.
% Mode: the game mode (PP, CP, PC, CC).
% Level: the game level (easy or normal).

do_game(Mode, Level):-

    % checks if the first move is made by an human
    Mode \== 'CC', Mode \== 'CP',
    initial(Game),
    game_cycle_human(Game, 'r', Mode, Level).


do_game(Mode, Level):-
    
    % checks if the first move is made by a computer
    Mode \== 'PP', Mode \== 'PC',
    initial(Game),
    game_cycle_computer(Game, 'r', Mode, Level).


% game_cycle_human(+Game, +Player, +Mode, +Level).
% This predicate is responsable for the game loop. It only stops when the game is finished.
% Game: The current game state.
% Player: The current player.
% Mode: The game mode.
% Level: The AI level.


game_cycle_human(Game, Player, Mode, Level):-
    
    display_game(Game, Player),
    repeat,

    % gets the move and the disk the player wants to play
    get_move(Game, Move1, Disk),
    
    move(Game, [Player, Move1, Disk], NewGame1), !, % if move succeds, it means that it is no longer neede to go back (hence the cut).
    
    % clears the board
    print_nl(40),

    % chooses who is going to play next
    choose_whats_next(NewGame1, Player, Mode, 'P', Level).



game_cycle_computer(Game, Player, Mode, Level):-
    
    % chooses the next move for the AI.
    display_game(Game, Player),

    
    % chooses the next move for the AI.
    choose_move(Game, Player, Level, Move),
    
    % stops for 1sec to give more 'humanity' to the move.
    sleep(1),
    move(Game, Move, NewGame1), !,
   
    % clears the board.
    print_nl(40),

    % chooses who is going to play next.
    !, choose_whats_next(NewGame1, Player, Mode, 'C', Level).

    

% choose_whats_next(+Game, +Player, +Mode, +CurrentPlayer, +Level)
% This predicate decides who is going to play next (Human or Computer, RedPlayer or BluePlayer).
% Game: The current game state.
% Player: The current player.
% Mode: The game mode.
% CurrentPlayer: the player that did the last move (C or P).
% Level: the level of the AI.


% Verifies if game has finished
choose_whats_next(Game, _Player, _Mode, _CurrentPlayer, _Level):-
    game_over(Game, Winner),
    Winner \== 'None'.

% The game mode is Person vs Person, so it only needs to change the current player.
choose_whats_next(Game, Player, 'PP', _CurrentPlayer, Level):-
    next_player(Player, NextPlayer),
    game_cycle_human(Game, NextPlayer, 'PP', Level).


% The game mode is Computer vs Computer, so it only needs to change the current player.
choose_whats_next(Game, Player, 'CC', _CurrentPlayer, Level):-
    next_player(Player, NextPlayer),
    game_cycle_computer(Game, NextPlayer, 'CC', Level).

% Changes the current player and the type of player
choose_whats_next(Game, Player, 'PC', 'P', Level):-
    next_player(Player, NextPlayer),
    game_cycle_computer(Game, NextPlayer, 'PC', Level).


% Changes the current player and the type of player
choose_whats_next(Game, Player, 'PC', 'C', Level):-
    next_player(Player, NextPlayer),
    game_cycle_human(Game, NextPlayer, 'PC', Level).


% Changes the current player and the type of player
choose_whats_next(Game, Player, 'CP', 'P', Level):-
    next_player(Player, NextPlayer),
    game_cycle_computer(Game, NextPlayer, 'CP', Level).


% Changes the current player and the type of player
choose_whats_next(Game, Player, 'CP', 'C', Level):-
    next_player(Player, NextPlayer),
    game_cycle_human(Game, NextPlayer, 'CP', Level).


next_player('r', 'b').
next_player('b', 'r').


% get_move(+Game, -Move, -Disk)
% This receives the input by the player for the move and the disk
% Game: The current game state.
% Move: the move to be made.
% Disk: the disk to be placed.


get_move(Game, Move, Disk):-
    repeat,
    valid_moves(Game, _, ValidMoves),
    write('The valid moves are: '), write(ValidMoves),    
    read(Move),
    member(Move, ValidMoves),
    write('Choose the color of your disk (r/b): '),
    read(ADisk),
    
    % validates and translates the input
    process_disk(ADisk, Disk).


% this predicate validates and translates the input from user friendly to the intern representation of the game
process_disk(r, 1).
process_disk(b, 2).
process_disk(_, Disk):-
    write('Choose the color of your disk (r/b): '),
    read(ADisk),
    process_disk(ADisk, Disk).