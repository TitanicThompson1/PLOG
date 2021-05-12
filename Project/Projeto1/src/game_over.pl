:-ensure_loaded('auxiliar.pl').
:-ensure_loaded('display.pl').

% game_over(+Game, -Winner)
% This predicate verifies if the game is over (if there aren't disks to play). If it is, then calculates the score and displays the winner
% Game: the GameState and BoardGame
% Winner: None if the game isn't over. Otherwise, the player that won (Red or Blue)

game_over([GameState | BoardGame], Winner):-
    verify_game_over(GameState), !, 

    print_nl(40),
    display_game([GameState | BoardGame], _Player),
    print_nl(40),


    get_red_gain_area(GameState, GRed, RRed),
    get_blue_gain_area(GameState, GBlue, RBlue),
    
    count_void_disks(BoardGame, NumberRed, NumberBlue), 

    calculate_score(GRed, RRed, GBlue, RBlue, NumberRed, NumberBlue, FinalRedScore, FinalBlueScore),
    resolve_ties(RRed, RBlue, NumberRed, NumberBlue, FinalRedScore, FinalBlueScore, Winner),

    display_winner(Winner),
    display_scores(FinalRedScore, FinalBlueScore), !.

% if it fails in verify_game_over, goes to here
game_over(_, Winner):-
    Winner = 'None'.

% verifies if players have no disks
verify_game_over(GameState):-
    get_players_disks(GameState, N1, N2, N3, N4),
    equal_zero(N1, N2, N3, N4).

equal_zero(0, 0, 0, 0).

% Counts all the disks in the void area.
count_void_disks(BoardGame, NumberRed, NumberBlue):-
    count_void_disks_rec(BoardGame, NumberRed, NumberBlue).


count_void_disks_rec([], 0, 0).
count_void_disks_rec([Row | RestOfBoard], NumberRed, NumberBlue):-
    count_void_disks_rec(RestOfBoard,  N1, N2),
    count_row_void_disks(Row,  NumberRedRow, NumberBlueRow),
    NumberRed is NumberRedRow + N1, NumberBlue is NumberBlueRow + N2.

count_row_void_disks([], 0, 0).
count_row_void_disks([Piece | RestOfRow],  NumberRed, NumberBlue):-
    count_row_void_disks(RestOfRow,  N1, N2),
    count_void_disk(Piece, Add1, Add2),
    NumberRed is Add1 + N1, NumberBlue is N2 + Add2.

count_void_disk(4,  Add1, Add2):-
    Add1 is 1, 
    Add2 is 0.

count_void_disk(5,  Add1, Add2):-
    Add1 is 0, 
    Add2 is 1.

count_void_disk(_,  Add1, Add2):-
    Add1 is 0, 
    Add2 is 0.



% Calculates the score accordingly to the rules of the game
calculate_score(GRed, RRed, GBlue, RBlue, NumberRed, NumberBlue, FinalRedScore, FinalBlueScore):-

    calculate_final(ToSubtracteRed, ToSubtracteBlue, RRed, RBlue, NumberRed, NumberBlue),
    FinalBlueScore is GBlue - ToSubtracteBlue,
    FinalRedScore is GRed - ToSubtracteRed.

calculate_final(ToSubtracteRed, ToSubtracteBlue, _, RBlue, NumberRed, NumberBlue) :-
    NumberBlue > NumberRed,
    ToSubtracteBlue is RBlue,
    ToSubtracteRed is 0.

calculate_final(ToSubtracteRed, ToSubtracteBlue, RRed, _, NumberRed, NumberBlue) :-
    NumberRed > NumberBlue,
    ToSubtracteRed is RRed,
    ToSubtracteBlue is 0.


resolve_ties(_, _, _, _, FinalRedScore, FinalBlueScore, Winner) :-
    FinalRedScore > FinalBlueScore, 
    Winner = 'Red'.

resolve_ties(_, _, _, _, FinalRedScore, FinalBlueScore, Winner) :-
    FinalBlueScore > FinalRedScore, 
    Winner = 'Blue'.

resolve_ties(_, _, NumberRed, NumberBlue, _, _, Winner) :-
    NumberRed < NumberBlue,
    Winner = 'Red'.

resolve_ties(_, _, NumberRed, NumberBlue, _, _, Winner) :-
    NumberBlue < NumberRed,
    Winner = 'Blue'.

resolve_ties(RRed, RBlue, _, _, _, _, Winner):-
    RRed < RBlue,
    Winner = 'Red'.

resolve_ties(RRed, RBlue, _, _, _, _, Winner):-
    RBlue < RRed,
    Winner = 'Blue'.

resolve_ties(_, _, _, _, _, _, Winner) :-
    Winner = 'Both'.



display_winner('Red') :-
    write('Red is the winner! Congratulations!'), nl.

display_winner('Blue') :-
    write('Blue is the winner! Congratulations!'), nl.

display_winner('Both') :-
    write('Both players are the winner!'), nl.


display_scores(FinalRedScore, FinalBlueScore):-
    write('Red score: '), write(FinalRedScore), nl,
    write('Blue score: '), write(FinalBlueScore), nl.
