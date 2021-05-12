:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).

% generate_crypto(+N, -LeftExpr, -RightExpr, -ResultExpr)
% Generates a crypto puzzle of dimension N. The dimension refers to the sum of lengths of the left and right expressions
% The three output variables are lists of unitialized variables
% N: the pretended dimension of the puzzle
% LeftExpr: a lits of unitialized variables corresponding to the left expression of the puzzle
% RightExpr: a lits of unitialized variables corresponding to the left expression of the puzzle
% ResultExpr: a lits of unitialized variables corresponding to the left expression of the puzzle
generate_crypto(N, LeftExpr, RightExpr, ResultExpr):-
    
    % Each unitilizaded variable corresponds to an digit
    Numbers = [Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine],

    % The length of left expression is determinated at random
    random(1, N, LenExprLeft),
    LenExprRigth is N - LenExprLeft,

    % Gets 10 power to the length of the expression (the max number)
    ten_power(LenExprLeft, MaxExprLeft),
    random(1, MaxExprLeft, NumberLeft),

    ten_power(LenExprRigth, MaxExprRigth),
    random(1, MaxExprRigth, NumberRigth),

    NumberResult is NumberLeft * NumberRigth,    
    
    % transforms each number to a list of unitialized variables (with each digit being represented by the same variable)
    number_to_expr(NumberLeft, LeftExpr, Numbers),
    number_to_expr(NumberRigth, RightExpr, Numbers),
    number_to_expr(NumberResult, ResultExpr, Numbers).
    

% number_to_expr(+Number, -Expr, +Numbers)
% Transforms a number into a list of unitialized variables. For example, 121 transforms to [One, Two, One].
% Number: the number pretended to transform
% Expr: the result of the transformation
% Numbers: The list of digit, 0 to 9, in form of unitialized variables
number_to_expr(Number, Expr, Numbers):-
    number_to_expr_acc(Number, ExprReversed, Numbers),

    % the list comes reversed from number_to_expr_acc, so it needs to be reversed to get the pretended result
    reverse(ExprReversed, Expr).


% Base case: only one digit 
number_to_expr_acc(Number, [Expr], Numbers):-
    Number < 10,
    nth0(Number, Numbers, Ele),         % transforms the number to a variable     
    Expr = Ele.      


number_to_expr_acc(Number, [Expr | Acc], Numbers):-
    
    Digit is Number mod 10,         % gets the digit
    Rest is Number // 10,           % gets the rest of the number
    
    nth0(Digit, Numbers, Ele),      % transforms the number to a variable
    Expr = Ele,

    number_to_expr_acc(Rest, Acc, Numbers).     % recursive call

% Calculates the 10 power N number and puts it on Rresult
ten_power(N, Result):-
    ten_power_rec(N, 1, Result).

ten_power_rec(0, Res, Res).
ten_power_rec(N, Acc, Result):-
    NewAcc is Acc * 10,
    NewN is N - 1, 
    ten_power_rec(NewN, NewAcc, Result).

    
    