a(a1,1).
a(A,2).
a(a3,N).
b(1,b1).
b(2,B).
b(N,b3).
c(X,Y) :- a(X,N), b(N,Y).
d(X,Y) :- a(X,N), b(Y,N).
d(X,Y) :- a(N,X), b(N,Y).

?- a(X,2).                  % Yes
?- b(X,kalamazoo).          % X = 2
?- c(X,b3).                 % X = a1 ; X = a3; Yes; 
?- c(X,Y).                  % Yes
?- d(X,Y).                  % Yes