:-use_module(library(clpfd)). 
:-use_module(library(lists)). 
:-use_module(library(between)).


optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs):-
	
	% 
    length(MenHeights, NMen),
    length(WomenHeights, NWoman), 
    length(ChosenWomen, Size),

	domain(ChosenWomen, 1, Size), 
	all_distinct(ChosenWomen),
	
	choose_women(WomenHeights, MenHeights, ChosenWomen, Delta), 
	
	findall(N, between(1, Size, N), AllMen), 
	
	labeling([], ChosenWomen), 

	keys_and_values(Pairs, AllMen, ChosenWomen).
	
	
choose_women(_,[], [], _). 
choose_women(WomenHeights, [Men|MenHeights], [WomanPos | ChosenWomen], Delta):-
	element(WomanPos, WomenHeights, Woman), 
	abs(Men-Woman) #< Delta, 
	Men #>= Woman, 
	choose_women(WomenHeights, MenHeights, ChosenWomen, Delta). 
	