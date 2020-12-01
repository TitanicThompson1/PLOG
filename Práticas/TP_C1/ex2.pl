:-use_module(library(clpfd)).

zebra(Zeb, Agu):-
    
    % Declaração variáveis
    Sol = [Nac,Ani,Beb,Cor,Tab],
    Nac = [Ing, Esp, Nor, Ucr, Por],
    Ani = [Cao, Rap, Igu, Cav, Zeb],
    Beb = [Sum, Cha, Caf, Lei, Agu],
    Cor = [Verm,Verd,Bran,Amar,Azul],
    Tab = [Che, Win, LS, SG, Mar],
    %flatten(Sol,List), 
    List=[Ing, Esp, Nor, Ucr, Por, Cao, Rap, Igu, Cav, Zeb, Sum, Cha, Caf, Lei, Agu, Verm, Verd, Bran, Amar, Azul, Che, Win, LS, SG, Mar],
    
    % Declaração do domínio
    domain(List, 1, 5),

    %Declaração das restrições
    all_distinct(Nac),
    all_distinct(Ani),
    all_distinct(Beb),
    all_distinct(Cor),
    all_distinct(Tab),

    Ing #= Verm,
    Esp #= Cao,
    Nor #= 1,
    Amar #= Mar,
    abs(Che-Rap) #= 1
    abs(Nor-Azul) #= 1,
    Win #= Igu,
    LS #= Sum,
    Ucr #= Cha,
    Por #= SG,
    abs(Mar-Cav) #= 1,
    Verd #= Caf,
    Verd #= Bran + 1,
    Lei #= 3,

    labeling([], List).
    
    
    
    



    



