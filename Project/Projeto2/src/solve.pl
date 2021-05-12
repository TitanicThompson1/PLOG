% crypto_product([R], [G, R], [B, G]).

:- use_module(library(clpfd)).
:- ensure_loaded('timer.pl').


% crypto_product(+LeftExp, +RightExp, +Result)
% Resolves the equation and prints the result
% LeftExp: List of digits of the first number to be multiplied.
% RightExp: List of digits of the second number to be multiplied.
% Result: List of digits correspondent to the result of the multiplication.
solver(LeftExp, RightExp, Result):-
    % Sets domain for each list of numbers
    domain(LeftExp, 0, 9), domain(RightExp, 0, 9), domain(Result, 0, 9),

    % Joins the three lists in a single one without duplicates
    join_without_dup(LeftExp, RightExp, Result, AllInOne), 

    all_distinct(AllInOne), 
    
    % Imposes the first digit to be not 0
    first_diff_zero(RightExp),
    first_diff_zero(LeftExp),
    first_diff_zero(Result),

    % Turns the Set of digits into a number
    exp_to_number(RightExp, RightNumber),
    exp_to_number(LeftExp, LeftNumber),
    exp_to_number(Result, ResultNumber), !,

    % Verifies if the multiplication of the two numbers is the same as the result
    ResultNumber #= LeftNumber * RightNumber,

    % Gets the result values for each variable from the three Sets
    labeling([ff, bisect], [ResultNumber, LeftNumber, RightNumber]),

    % Prints the numbers corresponding to the solution
    print_result(LeftNumber, RightNumber, ResultNumber).



% Verifies if the first digit is not 0
first_diff_zero([First | _]):-  
    First #\= 0.

% Joins three lists and removes duplicates
join_without_dup(List1, List2, List3, AllInOne):-
    join_rec(List1, List2, List3, [], AllInOne).


join_rec([], [], [], Acc, Acc).

% Joining the three lists for the case of none being already fully-added
join_rec([F1 | Rest1], [F2 | Rest2], [F3 | Rest3], Acc, AllInOne):-
    add_to_acc(F1, Acc, Acc1),
    add_to_acc(F2, Acc1, Acc2),
    add_to_acc(F3, Acc2, Acc3),
    join_rec(Rest1, Rest2, Rest3, Acc3, AllInOne).

% Joining the three lists for the case of the first set being already fully-added
join_rec([], [F2 | Rest2], [F3 | Rest3], Acc, AllInOne):-
    add_to_acc(F2, Acc, Acc2),
    add_to_acc(F3, Acc2, Acc3),
    join_rec([], Rest2, Rest3, Acc3, AllInOne).
    
% Joining the three lists for the case of the second set being already fully-added
join_rec([F1 | Rest1], [], [F3 | Rest3], Acc, AllInOne):-
    add_to_acc(F1, Acc, Acc1),
    add_to_acc(F3, Acc1, Acc3),
    join_rec(Rest1, [], Rest3, Acc3, AllInOne).

% Joining the three lists for the case of both the first and second list being already-fully added
join_rec([], [], [F3 | Rest3], Acc, AllInOne):-
    add_to_acc(F3, Acc, Acc3),
    join_rec([], [], Rest3, Acc3, AllInOne).

% Adds variable to the list
add_to_acc(Ele, Acc, [Ele | Acc]):-
    \+my_member(Ele, Acc).

add_to_acc(_, Acc, Acc).

% Verifies if a variable is already in the list
my_member(_, []):- fail.
my_member(Ele, [First | _]):-
    Ele == First.
my_member(Ele, [_ | Rest]):-
    my_member(Ele, Rest).

    
equal_lists([], []).

% Verifies if two lists are equal
equal_lists([], _):- fail.
equal_lists(_, []):- fail.

equal_lists([F1 | Rest1], [F2 | Rest2]):-
    F1 #= F2,
    equal_lists(Rest1, Rest2).

% Concatenates list into a number
exp_to_number([X], X).
exp_to_number([First | Rest], Res):-
    length(Rest, LenRest),
    exp_restr(First, LenRest, ToAdd),
    Res #= NewRes + ToAdd,
    exp_to_number(Rest, NewRes).


% Does the operation Res = X * 10^Y
exp_restr(X, Y, Res):-
    exp_restr_rec(X, Y, Mult),
    Res #= X * Mult.

exp_restr_rec(_, 0, 1).
exp_restr_rec(X, Y, Res):-
    Res #= Res1 * 10,
    Y1 is Y - 1,
    exp_restr_rec(X, Y1, Res1).

% Prints in the console the solution for the expression
print_result(LeftNumber, RightNumber, ResultNumber):-
    write('The corresponding solution is: '),
    write(LeftNumber), write(' X '), 
    write(RightNumber), write(' = '), 
    write(ResultNumber).