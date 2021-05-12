:- use_module(library(lists)).


% Gets the disks of red player
get_red_gain_area([X, Y | _], X, Y).

% Gets the disks of blue player
get_blue_gain_area([_, _, A, B | _], A, B).

% Gets the gain and risk area of both players
get_players_disks([_, _, _, _, E, F, G, H | _], E, F, G, H).


% This predicate replaces an item of Index in a List by a Value.
% replace(+List, +Index, +Value, -NewList).
% List: the original List
% Index: the index of the element to be replaced
% Value: the new value of the index
% NewList: the modified list
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, I1 is I-1, replace(T, I1, X, R).


add_to_risk(GameState, r, NewGameState):-
    get_red_gain_area(GameState, _Gain, Risk),
    NewRisk is Risk + 1,
    replace(GameState, 1, NewRisk, NewGameState).

add_to_risk(GameState, b, NewGameState):-
    get_blue_gain_area(GameState, _Gain, Risk),
    NewRisk is Risk + 1,
    replace(GameState, 3, NewRisk, NewGameState).


add_to_gain(GameState, r, NewGameState):-
    get_red_gain_area(GameState, Gain, _Risk),
    NewGain is Gain + 1,
    replace(GameState, 0, NewGain, NewGameState).

add_to_gain(GameState, b, NewGameState):-
    get_blue_gain_area(GameState, Gain, _Risk),
    NewGain is Gain + 1,
    replace(GameState, 2, NewGain, NewGameState).




% This predicate succeeds if a player has enough disk of a certain color to play TESTADO
has_disks(r, 1, GameState) :-
    get_players_disks(GameState, Red, _, _, _), Red \== 0.

has_disks(r, 2, GameState) :-
    get_players_disks(GameState, _, Blue, _, _), Blue \== 0.

has_disks(b, 1, GameState) :-
    get_players_disks(GameState, _, _, Red, _), Red \== 0.

has_disks(b, 2, GameState) :-
    get_players_disks(GameState, _, _, _, Blue), Blue \== 0.    


% pos_to_row_col(+Pos, -Row, -Col).
% This predicate translates the position to the column and row nr
pos_to_row_col(1, 1, 1). pos_to_row_col(2, 1, 2). pos_to_row_col(3, 1, 3). pos_to_row_col(4, 2, 1). pos_to_row_col(5, 2, 2).
pos_to_row_col(6, 2, 3). pos_to_row_col(7, 2, 4). pos_to_row_col(8, 3, 1). pos_to_row_col(9, 3, 2). pos_to_row_col(10, 3, 3). pos_to_row_col(11, 3, 4). 
pos_to_row_col(12, 3, 5). pos_to_row_col(13, 4, 1). pos_to_row_col(14, 4, 2). pos_to_row_col(15, 4, 3). pos_to_row_col(16, 4, 4). pos_to_row_col(17, 5, 1).
pos_to_row_col(18, 5, 2). pos_to_row_col(19, 5, 3).

% max_column(Row, MaxCol)
% This predicate puts in MaxCol the max value for column of the Row
max_column(0, 4).
max_column(1, 5).
max_column(2, 6).
max_column(3, 7).
max_column(4, 6).
max_column(5, 5).
max_column(6, 4).


deflatten_coords(1, 0, 0). deflatten_coords(2, 0, 1). deflatten_coords(3, 0, 2). deflatten_coords(4, 0, 3).
deflatten_coords(5, 1, 0). deflatten_coords(6, 1, 1). deflatten_coords(7, 1, 2). deflatten_coords(8, 1, 3). deflatten_coords(9, 1, 4).
deflatten_coords(10, 2, 0). deflatten_coords(11, 2, 1). deflatten_coords(12, 2, 2). deflatten_coords(13, 2, 3). deflatten_coords(14, 2, 4). deflatten_coords(15, 2, 5).
deflatten_coords(16, 3, 0). deflatten_coords(17, 3, 1). deflatten_coords(18, 3, 2). deflatten_coords(19, 3, 3). deflatten_coords(20, 3, 4). deflatten_coords(21, 3, 5). deflatten_coords(22, 3, 6).
deflatten_coords(23, 4, 0). deflatten_coords(24, 4, 1). deflatten_coords(25, 4, 2). deflatten_coords(26, 4, 3). deflatten_coords(27, 4, 4). deflatten_coords(28, 4, 5).
deflatten_coords(29, 5, 0). deflatten_coords(30, 5, 1). deflatten_coords(31, 5, 2). deflatten_coords(32, 5, 3). deflatten_coords(33, 5, 4).
deflatten_coords(34, 6, 0). deflatten_coords(35, 6, 1). deflatten_coords(36, 6, 2). deflatten_coords(37, 6, 3).



% Gets Disk in cell number Cell
find_cell(_Cell, [], _N, _N_color).
find_cell(Cell, [First|Board], N, N_color):-
    length(First, Length),
    find_line(Cell, First, N, N_color),
    N1 is N + Length,
    find_cell(Cell, Board, N1, N_color).

find_line(_Cell, [], _N, _N_color).
find_line(Cell, [First|Cells], N, N_color):-
    N1 is N+1,
    n_color_value(N_color,Cell,First, N),
    find_line(Cell, Cells, N1, N_color).

n_color_value(N_color,Cell,First, N) :- Cell =:= N, !, N_color is First.
n_color_value(_N_color,_Cell,_First, _N).


% decrease_number_disk(+GameState, +Player, +Disk, -FinalGameState)
% This predicate decreases by the number of disk accordingly to the played Disk of a certain Player
decrease_number_disk(GameState, r, 1, FinalGameState):-
    get_players_disks(GameState, RedDisks, _, _, _),
    FinalRedDisk is RedDisks - 1,
    replace(GameState, 4, FinalRedDisk, FinalGameState).


decrease_number_disk(GameState, r, 2, FinalGameState):-
    get_players_disks(GameState, _, BlueDisks, _, _),
    FinalBlueDisk is BlueDisks - 1,
    replace(GameState, 5, FinalBlueDisk, FinalGameState).


decrease_number_disk(GameState, b, 1, FinalGameState):-
    get_players_disks(GameState, _, _, RedDisks, _),
    FinalRedDisk is RedDisks - 1,
    replace(GameState, 6, FinalRedDisk, FinalGameState).


decrease_number_disk(GameState, b, 2, FinalGameState):-
    get_players_disks(GameState, _, _, _, BlueDisks),
    FinalBlueDisk is BlueDisks - 1,
    replace(GameState, 7, FinalBlueDisk, FinalGameState).



% find_max(+List, -Pos)
% Finds the maximum number position. if there isnt a maximum, return -1.
find_max_index(List, -1):-
    sort(List, SortedList),
    last(SortedList, Last),
    first(SortedList, First),
    
    % If the first number of the sorted list is equal to the last element, it means there isnt a maximum.
    First == Last.
    
find_max_index(List, Index):-
    sort(List, SortedList),
    last(SortedList, Last),
    nth1(Index, List, Last).


% Gets first element of list
first([First|_Rest], First).


% print_nl(+NumberOfNl).
% Prints nl equal to NumberOfNl.
print_nl(0).
print_nl(X):-
    Y is X - 1,
    nl,
    print_nl(Y).



% The empty list is already flat.
myflatten([],[]).

% For a non-empty list: flatten the head and flatten the tail and
% append the results.
myflatten([Head|InTail],Out) :-
	myflatten(Head,FlatHead),
	myflatten(InTail,OutTail),
	append(FlatHead,OutTail,Out).
% When trying to flatten the head, you might find that the head is
% not itself a list. In this case the head of the input list simply
% becomes the head of the output list. 
myflatten([Head|InTail], [Head|OutTail]) :-
	Head \= [],
	Head \= [_|_],
        myflatten(InTail,OutTail).