r(a,b). r(a,c). r(b,a). r(a,d).
s(b,c). s(b,d). s(c,c). s(d,e).

?- r(X,Y), s(Y,Z), \+ (r(Y,X)), \+ (s(Y,Y)).

% 1a) X=a, Y=d, Z=e
% 1b) 3 vezes
