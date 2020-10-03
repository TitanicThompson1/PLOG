male(aldoBurrows).
male(lincolnBurrows).
male(michaelScofield).
male(lJBurrows).

female(christinaRoseScofield).
female(lisaRix).
female(saraTancredi).
female(ellaScofield).

parent(aldoBurrows, michaelScofield).
parent(christinaRoseScofield, michaelScofield).
parent(aldoBurrows, lincolnBurrows).
parent(cristinaRoseScofield, lincolnBurrows).
parent(lincolnBurrows, lJBurrows).
parent(lisaRix, lJBurrows).
parent(michaelScofield, ellaScofield).
parent(saraTancredi, ellaScofield).

parent(X, michaelScofield), male(X).
parent(X, michaelScofield), female(X).

parent(aldoBurrows, X).