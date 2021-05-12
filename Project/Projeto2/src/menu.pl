:- ensure_loaded('solve.pl').
:- ensure_loaded('generate.pl').
:- use_module(library(lists)).

puzzle(1,[R],[G,R],[_B,G], 'R * GR = BG').

puzzle(2,[B],[B,_G],[R,R,R], 'B * BG = RRR').

puzzle(3,[G],[G,B],[B,_R,G], 'G * GB = BRG').

puzzle(4,[R],[B,R],[B,_G,B], 'R * BR = BGB').

puzzle(5,[_B],[R,G],[R,R,G], 'B * RG = RRG').

puzzle(6,[G,R],[R,G],[R,_B,R], 'GR * RG = RBR').

puzzle(7,[_R],[G,B],[B,G,G], 'R * GB = BGG').

puzzle(8,[B,R],[R,G],[G,B,G], 'BR * RG = GBG').

puzzle(9,[G,B],[G,R],[R,B,B], 'GB * GR = RBB').

puzzle(10,[R,B],[B,B],[G,R,G], 'RB * BB = GRG').

puzzle(11,[B,G],[B,R],[G,B,R], 'BG * BR = GBR').

puzzle(12,[G],[G,R],[R,G,G], 'G * GR = RGG').

puzzle(13,[R],[R,B],[G,B,G], 'R * RB = GBG').

puzzle(14,[B],[B,R],[_G,R,R], 'B * BR = GRR').

puzzle(15,[G],[G,B],[B,B,_R], 'G * GB = BBR').

puzzle(16, _, _, _, 'Generate Puzzle').

% Menu predicate
menu:-
    print_nl(20),
    write('   ______                 __           ____                 __           __'),nl,
    write('  / ____/______  ______  / /_____     / __ \\_________  ____/ /_  _______/ /_'),nl,
    write(' / /   / ___/ / / / __ \\/ __/ __ \\   / /_/ / ___/ __ \\/ __  / / / / ___/ __/'),nl,
    write('/ /___/ /  / /_/ / /_/ / /_/ /_/ /  / ____/ /  / /_/ / /_/ / /_/ / /__/ /_  '),nl,
    write('\\____/_/   \\__, / .___/\\__/\\____/  /_/   /_/   \\____/\\__,_/\\__,_/\\___/\\__/  '),nl,
    write('          /____/_/                                                          '),nl,
    print_opt.

% Chooses the puzzle to be solved
print_opt:-
    % Prints all available puzzles to be solved
    findall([N,Print], (puzzle(N,_,_,_,Print), write(N), write(') '), write(Print), nl), _),nl,

    nl,

    % Reads choosen puzzle number
    read_number('Choose the puzzle to be solved:  ', Option, 0, 17),

    % processes option
    process_option(Option).


% Generates the problem
process_option(16):-
    nl,
    
    read_number('Write the size of the puzzle: ', N, 1, 100),
    
    generate_crypto(N, L1, L2, L3),

    write_crypto(L1, L2, L3), nl,

    write('Press anything to show the solution'),

    read(_), nl,

    % Solves the equation
    solver(L1,L2,L3), nl,

    % Asks if another puzzle is to be solved
    another.


% Calls the predicate that solves the equation
process_option(Option):-
    nl,

    % Gets the parameters of the equation
    puzzle(Option,L1,L2,L3,Eq),!,

    write('The equation chosen was: '), write(Eq),nl,

    % Solves the equation
    solver(L1,L2,L3), nl,


    % Asks if another puzzle is to be solved
    another.


read_number(Message, Number, Min, Max):-
    repeat, 
    write(Message),
    read(Number), integer(Number), Number > Min, Number < Max.
    

% Prints Try another puzzle menu
another:-
    write('Try another puzzle?'), nl,
    write('(y)es'), nl,
    write('(n)o'), nl,
    read(Option), nl,
    another(Option).

% If Option is y it goes back to main Menu
another(Option):-  
    \+ var(Option), Option = y,
    print_nl(20), menu.

% If Option is n it ends the program
another(Option):-
    \+ var(Option), Option = n,
    write('Turning off...').

% If Option is neither y or n, then it asks for a valid option
another(_) :- write('Invalid Option'), nl, another.


print_nl(0).
print_nl(N):-
    N > 0, nl, 
    NewN is N - 1,
    print_nl(NewN).


write_crypto(L1, L2, L3):-
    join_without_dup(L1, L2, L3, AllInOne),
    Colors = ['Red', 'Green', 'Blue', 'Yellow', 'Pink', 'Orange', 'Brown', 'Purple', 'White', 'Black'],
    %trace,
    attribute_colors(L1, AllInOne, Colors),
    write(' * '),
    attribute_colors(L2, AllInOne, Colors),
    write(' = '), 
    attribute_colors(L3, AllInOne, Colors), nl.
    


attribute_colors([],_ ,_).
attribute_colors([F | R], AllInOne, Colors):-
    my_nth0(N, AllInOne, F),
    nth0(N, Colors, Color),
    write(Color),
    attribute_colors(R, AllInOne, Colors).
    

my_nth0(N, [F | R], Ele):-
    my_nth0_rec(N, [F | R], Ele, 0).


my_nth0_rec(_, [], _, _):- fail.
my_nth0_rec(Cur, [F | _], Ele, Cur):-
    F == Ele.
my_nth0_rec(N, [_ | R], Ele, Cur):-
    Next is Cur + 1,
    my_nth0_rec(N,  R, Ele, Next).   


