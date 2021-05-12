
% valid_moves(+GameState, +Player, -ListOfMoves)
% This predicate returns a list with all valid moves in a certain given state of the game.
% GameState: Current GameState and GameBoard
% Player: Player that will make the play
% ListOfMoves: All valid moves for current game state and player

valid_moves([_First|GameState], _Player, Final) :-

    % Initiates the cycle to find all valid moves, returned in the variable Final
    check_valid_moves(GameState, 0, [], Final).

% Removes last row of the Board, since it only has void cells, meaning they are unplayable.
check_valid_moves([_GameState], _Counter, _ListOfMoves, Final) :-                                             

    % Gives the Final variable the list of valid moves calculated in ListOfMoves
    append(_ListOfMoves, [], Final).

% Removes first row of the board, since it only has void cell, which are unplayable.
check_valid_moves([_GameState|Tail], 0, ListOfMoves, Final) :- 

    check_valid_moves(Tail, 1, ListOfMoves, Final).     

% Checks valid positions in each one of the middle lines of the board, removing the first cell, since it is a void space
check_valid_moves([GameState|Tail], Counter, ListOfMoves, Final) :-        

    valid_moves_line(GameState, Counter, ListOfMoves, 0, Tail, Final).

% Finishes evaluating the line. Does not count last cell because it is a void cell (unplayable).
valid_moves_line([_Last], Counter, ListOfMoves, 1, Tail, Final) :- 
    check_valid_moves(Tail, Counter, ListOfMoves, Final).

% Calls the function that checks valid positions in the line. Removes the first cell because it is a void cell.
valid_moves_line([_First|Tail], Counter, ListOfMoves, 0, Tail2, Final) :- 

    valid_moves_line(Tail, Counter, ListOfMoves, 1, Tail2, Final).

% Checks valid positions in the line.
valid_moves_line([Line|Tail], Counter, ListOfMoves, 1, Tail2, Final) :-

    check_character(Line, Tail, Counter, ListOfMoves, Tail2, Final).

% Checks if cell is valid move. It is valid move if the first argument is 0
check_character(0, Tail, Counter, ListOfMoves, Tail2, Final) :-
    append(ListOfMoves, [Counter], ListOfMoves2),
    Counter2 is Counter + 1,
    valid_moves_line(Tail, Counter2, ListOfMoves2, 1, Tail2, Final).

% Checks if cell has a red piece, being invalid for a move.
check_character(1, Tail, Counter, ListOfMoves, Tail2, Final) :- 
    Counter2 is Counter + 1,
    valid_moves_line(Tail, Counter2, ListOfMoves, 1, Tail2, Final).

% Checks if cell has a blue piece, being invalid for a move.
check_character(2, Tail, Counter, ListOfMoves, Tail2, Final) :- 
    Counter2 is Counter + 1,
    valid_moves_line(Tail, Counter2, ListOfMoves, 1, Tail2, Final).
