/*
12 carros estão parados, em fila, num semáforo. Sabe-se que :
- A distribuição de cores é: 4 amarelos (1), 2 verdes(2), 3 vermelhos(3), 3 azuis(4)
- O primeiro e último têm a mesma cor
- O segundo e o penúltimo têm a mesma cor
- O quinto é azul
- Todas as sub-sequências de 3 carros têm 3 cores diferentes
- Do primeiro para o último, a sequência amarelo-verde-vermelho-azul aparece uma única vez
*/

:-use_module(library(clpfd)).

car_line(Cars):-
    Cars = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12],         % Colour of every car in line

    domain(Cars, 1, 4),

    global_cardinality(Cars, [1-4, 2-2, 3-3, 4-3]),
    C1 #= C12, C2 #= C11, C5 #= 4,

    subsquece_three(Cars),
    one_time_sequence(Cars, 1),

    labeling([], Cars), write(Cars).



subsquece_three([C1, C2, C3 | Cars]):-
    C1 #\= C2, C1 #\= C3, C2 #\= C3,
    subsquece_three([C2, C3 | Cars]).

subsquece_three(Cars):-
    length(Cars, N), N < 3.



one_time_sequence([C1, C2, C3, C4 | Cars], N):-
    (C1 #= 1 #/\ C2 #= 2 #/\ C3 #= 3 #/\ C4 #= 4) #<=> N1,
    N #= N1 + N2,
    one_time_sequence([C2, C3, C4 | Cars], N2).

one_time_sequence(Cars, 0):-
    length(Cars, N), N  < 4.
    

    


