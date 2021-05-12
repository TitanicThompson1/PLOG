:- ['auxiliar.pl'].
:- use_module(library(lists)).

% Receives a State of the game (including the Board) and the player that is going to make the next play 
display_game([State | Board], _Player):- 
    nl,nl,nl,
    % Printing the board
    print_board(Board, 0, 0),nl,nl,
    write('     Gain                Risk'),
    
    % Gets pieces players still have
    get_players_disks(State, P1Red, P1Blue, P2Red, P2Blue),

    % P1 Area
    nl, write('P1 '), nl,
    write(' '),
    print_disk_area_top(36), nl,
    get_red_gain_area(State, P1Gain, P1Risk),

    % Printing the Gain and Risk area of Player1
    print_disk_area(1,36,P1Gain, P1Risk),  % height, length, number of pieces Gain Area, number od pieces Risk Area for P1
    write('|'),
    print_disk_area_top(36), write('|'),
    
    % P2 Area
    nl, nl, write('P2 '), nl, 
    write(' '),
    print_disk_area_top(36), nl,
    get_blue_gain_area(State, P2Gain, P2Risk),

    % Printing the Gain and Risk area of Player2
    print_disk_area(1, 36, P2Gain, P2Risk),  % height, length, number of pieces Gain Area, number od pieces Risk Area for P2
    write('|'),
    print_disk_area_top(36), write('|'),

    % Prints the number of discs that each player has
    nl, nl, write('P1 - '),write('red: '), write(P1Red),write(', blue: '), write(P1Blue),nl,
    nl, write('P2 - '),write('red: '), write(P2Red),write(', blue: '), write(P2Blue),nl.

% Prints Disk Area Top (the top bar)
print_disk_area_top(0).
print_disk_area_top(L):-
    write('_'),
    L1 is L - 1,
    print_disk_area_top(L1).

% Prints Middle Disk Area with Pieces
print_disk_area(0, _L, _R, _B).
print_disk_area(A, L, R, B):-
    write('|'), 
    print_middle_p1(L,R,B), nl,
    A1 is A-1,
    print_disk_area(A1, L, R, B).

% Prints line of Disk Area
print_middle_p1(19,R,B):- write('|'), print_middle_p2(18,R,B).
print_middle_p1(L,R,B):-
    print_disk(R,W),
    write(W),
    R1 is R-1,
    L1 is L-1,
    print_middle_p1(L1,R1,B).

print_middle_p2(0,_R, _B):- write('|').
print_middle_p2(L,R,B):-
    print_disk(B,W),
    write(W),
    L1 is L-1,
    B1 is B-1,
    print_middle_p2(L1,R,B1).

% atoms for pieces in disk area (X represents a piece)
print_disk(0,' ').
print_disk(1,'X').
print_disk(N,X) :- N<0, !, print_disk(0,X).
print_disk(_N,X) :- print_disk(1,X).

% Prints the board first line
print_board([], _Line, _N).
print_board([L | T], 0, _N) :-
    length(L, Length),
    Length2 is 8-Length,
    print_spaces(4*Length2+1),
    print_first(Length), nl,
    print_spaces(4*Length2+1),
    print_second(Length), nl,
    print_spaces(4*Length2+1),
    print_third_first, print_third(Length-1), nl,
    print_spaces(4*Length2+1),
    print_fourth_first(L), print_fourth(Length-1, L, 1),nl,
    print_spaces(4*Length2-3),
    print_first(Length+1),nl,
    print_spaces(4*Length2-3),
    print_second(Length+1),nl,
    %length(L, Length),
    %Space_Length is 7 - Length,                                 % Space_Length is the number of whitespaces needed to be printed before printing the board line
    %print_spaces(Space_Length), print_line(L),
    %nl, print_spaces(Space_Length), print_bottom(Length), 
    print_board(T, 1, 1).                                         % Printing the rest of the board

% Prints the board last line
print_board([L], 6, N) :- 
    length(L, Length),
    N2 is N + Length - 1,
    Length2 is 8-Length,
    print_spaces(4*Length2+1),
    print_third_first, print_third(Length-1), nl,
    print_spaces(4*Length2+1),
    print_fourth_first(L), print_fourth(Length-1, L, 1),nl,
    print_spaces(4*Length2+1),
    print_fifth(Length),nl,
    print_spaces(4*Length2+1),
    print_sixth(Length),nl,
    print_board([], 6, N2).

% Prints the board second half
print_board([L | T], 6, N) :- 
    length(L, Length),
    N2 is N + Length - 2,
    Length2 is 8-Length,
    print_spaces(4*Length2+1),
    print_third_first, print_third(Length-2, N),print_third_last, nl,
    print_spaces(4*Length2+1),
    print_fourth_first(L), print_fourth(Length-1, L, 1),nl,
    print_spaces(4*Length2+1),
    print_fifth(Length),nl,
    print_spaces(4*Length2+1),
    print_sixth(Length),nl,
    print_board(T, 6, N2).

% Prints the board first half
print_board([L | T], _Line, N) :- 
    length(L, Length),
    N2 is N + Length - 2,
    Length2 is 8-Length,
    print_spaces(4*Length2+1),
    print_third_first, print_third(Length-2, N),print_third_last, nl,
    print_spaces(4*Length2+1),
    print_fourth_first(L), print_fourth(Length-1, L, 1),nl,
    print_spaces(4*Length2-3),
    print_first(Length +1),nl,
    print_spaces(4*Length2-3),
    print_second(Length +1),nl,
    print_board(T, Length, N2).

% Prints a line of the board
print_first(0).
print_first(Length) :-
    write('   / \\  '),
    Length2 is Length - 1,
    print_first(Length2).

print_second(0).
print_second(Length) :-
    write(' /     \\'),
    Length2 is Length - 1,
    print_second(Length2).

print_third_first :-
    write('|       |').

print_third_last :-
    write('       |').

print_third(0, _N).
print_third(Length, N) :-
    write('  '),
    print_number(N),
    write('   |'),
    Length2 is Length - 1,
    N2 is N+1,
    print_third(Length2, N2).

print_third(0).
print_third(Length) :-
    write('    '),
    write('   |'),
    Length2 is Length - 1,
    print_third(Length2).

print_fourth_first([L|_Tail]) :-
    write('|   '),
    code(L,X),
    write(X),
    write('   |').

print_fourth(0, _L, _N).
print_fourth(Length, L, N) :-
    write('   '),
    nth0(N,L,X),
    code(X,Y),
    write(Y),
    write('   |'),
    Length2 is Length - 1,
    N2 is N+1,
    print_fourth(Length2, L, N2).

print_fifth(0).
print_fifth(Length) :-
    write(' \\     /'),
    Length2 is Length - 1,
    print_fifth(Length2).

print_sixth(0).
print_sixth(Length) :-
    write('   \\ /  '),
    Length2 is Length - 1,
    print_sixth(Length2).

% Prints a line of the board
print_line([]).
print_line([C | L]) :-
    print_cell(C),
    print_line(L).

% Prints a cell of the board
print_cell(C):-
	code(C,P),
	write('/ '), write(P), write(' \\').

% print_bottom prints the second line of boardline (each boardline has two lines)
print_bottom(0).
print_bottom(Length) :-             % Length is the length of the current board line
    Length2 is Length - 1,
    write('\\___/'),
    print_bottom(Length2).

% print_spaces prints the needed spaces in the left to align the board
print_spaces(0).
print_spaces(Length) :-
    Length2 is Length - 1,
    write(' '),
    print_spaces(Length2).

% The code for the atoms
code(0, ' ').   % Whitespace
code(1, 'R').   % Red disc in blank space
code(2, 'B').   % Blue disc in blank space
code(3, 'T').   % Void
code(4, 'R').   % Red disc in void space   
code(5, 'B').   % Blue disc in void space

% code for printing in 2 spaces
print_number(N) :- N<10, !, write(' '), write(N).
print_number(N) :- write(N).