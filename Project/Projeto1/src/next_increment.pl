

increment_column1(CurrentColumn, CurrentRow, -1, NewStartC):-
    next_increment1(CurrentRow, -1, Increment),
    NewStartC is CurrentColumn - Increment. 

increment_column1(CurrentColumn, CurrentRow, 1, NewStartC):-
    next_increment1(CurrentRow, 1, Increment),
    NewStartC is CurrentColumn + Increment.

% next_increment(+Row, +Direction, -Increment)

next_increment1(0, _, 1).
next_increment1(1, _, 1).
next_increment1(2, _, 1).
next_increment1(3, -1, 1).
next_increment1(3, 1, 0).
next_increment1(_, _, 0).



increment_column2(CurrentColumn, CurrentRow, -1, NewStartC):-
    next_increment2(CurrentRow, -1, Increment),
    NewStartC is CurrentColumn + Increment. 

increment_column2(CurrentColumn, CurrentRow, 1, NewStartC):-
    next_increment2(CurrentRow, 1, Increment),
    NewStartC is CurrentColumn - Increment.

next_increment2(6, _, 1).
next_increment2(5, _, 1).
next_increment2(4, _, 1).
next_increment2(3, -1, 0).
next_increment2(3, 1, 1).
next_increment2(_, _, 0).