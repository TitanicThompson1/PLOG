:- ensure_loaded('auxiliar.pl').

% value(+GameState, +Player, -Value)
% This predicate returns the value of the hard difficulty AI for a give board. The value is calculated adding all non void pieces with the player s color
%    and the pieces reight next to it. If the piece is the void a point is added, otherwise two points are added. Pieces that are in void positions but dont
%    connect with any non void piece of the same color will not be added, since its points are not desired. When calculating the value it will only rate the 
%    value higher if a non void piece is present.
% GameState: Current GameBoard
% Player: Player that will make the play
% Value: Avaliation number for the board

value([Tline|Board], Player, Value) :-

    length(Tline, Length),
    N is Length + 2,
    together(Board, N, [Tline|Board], Player,0, Value).

% Checks Value for each row of the board
together([_Last_line], _N, _Whole_board, _Color,Value_per_line, Value):- Value is Value_per_line.
together([[_First_cell | Current_cell]| Board], N, Whole_board, Color,Value_per_line, Value):-
    length(Current_cell, Length),
    together_cell(Current_cell, N, Whole_board, Length, Color, 0, Value_per_cell),
    N1 is N + Length + 1,
    Value_per_line2 is Value_per_cell + Value_per_line,
    together(Board, N1, Whole_board, Color,Value_per_line2,Value).

% Checks if the cell color is the same as the player, calling the function to sum the Current total value
together_cell([_Last_cell], _N, _Whole_board, _Line_length, _Color, Initial_value, Value_per_cell):- Value_per_cell is Initial_value.
together_cell([_Current_cell|Rest], N, Whole_board, Line_length, Color, Initial_value, Value_per_cell):-
    find_cell(N,Whole_board,1,N_color),
    point_color(Color,Point_color),
    N_color =:= Point_color,!,
    next_to(N, List, Line_length),
    see_color(List, 0, Whole_board, Color, Cell_value),
    Initial_value2 is Initial_value + Cell_value,
    N2 is N+1,
    together_cell(Rest, N2, Whole_board, Line_length, Color, Initial_value2, Value_per_cell).

% Advances the cell if its color is not the same as the player s color
together_cell([_Current_cell|Rest], N, Whole_board, Line_length, Color, Initial_value, Value_per_cell):-
    N2 is N+1,
    together_cell(Rest, N2, Whole_board, Line_length, Color, Initial_value, Value_per_cell).

% Sums cell list of values
see_color([], Value, _Whole_board, _Color, Cell_value):- Cell_value is Value.
see_color([First|List], Value, Whole_board, Color, Cell_value):-
    find_cell(First,Whole_board,1,N_color),
    calculate_value(N_color, Value1, Color),
    Value2 is Value + Value1,
    see_color(List, Value2, Whole_board, Color, Cell_value).

% Calculates value of the cell taking into consideration the player and the piece position
calculate_value(N_color, Value1, r):- N_color =:= 1, !, Value1 is 2.
calculate_value(N_color, Value1, r):- N_color =:= 4, !, Value1 is 1.
calculate_value(N_color, Value1, b):- N_color =:= 2, !, Value1 is 2.
calculate_value(N_color, Value1, b):- N_color =:= 5, !, Value1 is 1.
calculate_value(_N_color, Value1, _Color):- Value1 is 0.

% Sees color that will give points to the player
point_color(r,1).
point_color(b,2).

next_to(1,[2,5,6],_).
next_to(2,[1,3,6,7],_).
next_to(3,[2,4,7,8],_).
next_to(4,[3,8,9],_).
next_to(5,[1,6,10,11],_).
next_to(9,[4,8,14,15],_).
next_to(10,[5,11,16,17],_).
next_to(15,[9,14,21,22],_).
next_to(16,[10,17,23],_).
next_to(22,[15,21,28],_).
next_to(23,[16,17,24,29],_).
next_to(28,[21,22,27,33],_).
next_to(29,[23,24,30,34],_).
next_to(33,[27,28,32,37],_).
next_to(34,[29,30,35],_).
next_to(35,[30,31,34,36],_).
next_to(36,[31,32,35,37],_).
next_to(37,[32,33,36],_).

% Checks cells that are next to the middle row cell N ((Line_length is the length of the line - 1), in this case 6 (7-1))
next_to(N, List, 6) :- 
    Line_length is 6,
    Near1 is N - Line_length - 1,
    Near2 is N - Line_length,
    Near3 is N-1,
    Near4 is N+1,
    Near5 is N + Line_length,
    Near6 is N + Line_length + 1,
    append([Near1,Near2,Near3,Near4,Near5,Near6], [], List).

% Checks cells that are next to bottom row cell N (Line_length is the length of the line - 1)
next_to(N, List, Line_length) :- 
    N>22, !,
    Near1 is N - Line_length - 2,
    Near2 is N - Line_length -1,
    Near3 is N-1,
    Near4 is N+1,
    Near5 is N + Line_length,
    Near6 is N + Line_length + 1,
    append([Near1,Near2,Near3,Near4,Near5,Near6], [], List).

% Checks cells that are next to top row cell N (Line_length is the length of the line - 1)
next_to(N, List, Line_length) :- 
    Near1 is N - Line_length - 1,
    Near2 is N - Line_length,
    Near3 is N-1,
    Near4 is N+1,
    Near5 is N + Line_length + 1,
    Near6 is N + Line_length + 2,
    append([Near1,Near2,Near3,Near4,Near5,Near6], [], List).
