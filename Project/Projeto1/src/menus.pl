:- ensure_loaded('game_cycle.pl').
:- ensure_loaded('auxiliar.pl').



initial_menu :-
    print_nl(40),
    print_title,

    % Prints the user options
    print_options,      

    % Reads the option selected by the user
    read(Option),

    process_start_option(Option).


print_title :-
    nl, write('                                                                   __ '),nl,
    write(' _ _ _     _                      _          _____                |  |'),nl,
    write('| | | |___| |___ ___ _____ ___   | |_ ___   |   __|___ _ _ ___ ___|  |'),nl,
    write('| | | | -_| |  _| . |     | -_|  |  _| . |  |  |  | . | | |_ -|_ -|__|'),nl,
    write('|_____|___|_|___|___|_|_|_|___|  |_| |___|  |_____|__,|___|___|___|__|'),nl,
    nl,nl.

print_options :-
    write('(1) Start'), nl, 
    write('(2) Exit'), nl.


process_start_option(2):- !.              % Exit option
process_start_option(1):-
    player_choice_menu.

% Invalid input processing
process_start_option(_) :-
    write('Invalid Input. Please try again.'), nl,
    read(Option),
    process_start_option(Option).


% Menu to change the play mode
player_choice_menu :-
    
    print_nl(40),

    % Printing options
    write('Choose between the following modes:'), nl, nl,
    write('(1) Person vs Person'), nl,
    write('(2) Computer vs Person'), nl,
    write('(3) Person vs Computer'), nl,
    write('(4) Computer vs Computer'), nl,
    nl,nl,
    write('(5) Return'), nl,
    
    % Geting user option
    read(Option),

    % Processing user input
    process_player_option(Option).
    
    

% The game mode is stored with the predicate game_mode/1
process_player_option(1):-
    % In this case, diffulty isn´t needed
    do_game('PP', 'None').

process_player_option(2):-
    level_menu('CP').

process_player_option(3):-
    level_menu('PC').

process_player_option(4):-
    level_menu('CC').

process_player_option(5):-
    !, initial_menu.

% Invalid input processing
process_player_option(_) :-
    write('Invalid Input. Please try again.'), nl,
    read(Option),
    process_player_option(Option).


level_menu(Mode):-
    
    print_nl(40),

    write('Choose level:'), nl, nl,
    write('(1) Easy'), nl,
    write('(2) Normal'), nl,
    nl,nl,
    write('(3) Return'), nl,

    % Geting user option
    read(Option),

    % Processing user input
    process_level_option(Option, Mode).
    


process_level_option(1, Mode):-
    do_game(Mode, 'easy').

process_level_option(2, Mode):-
    do_game(Mode, 'normal').


process_level_option(3, _):-
    !, player_choice_menu.


% Invalid input processing
process_level_option(_, Mode) :-
    write('Invalid Input. Please try again.'), nl,
    read(Option),
    process_level_option(Option, Mode).
