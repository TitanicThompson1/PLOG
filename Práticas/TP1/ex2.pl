/* Pilotos  */

piloto(lamb).
piloto(besenyei).
piloto(chambliss).
piloto(maclean).
piloto(mangold).
piloto(jones).
piloto(bonhomme).

/* Equipas */

equipa(lamb, breitling).
equipa(besenyei,redBull).
equipa(chambliss, redBull).
equipa(maclean, mediterraneanRacingTeam).
equipa(mangold, cobra).
equipa(jones, matador).
equipa(bonhomme,matador).

/* Avião */

aviao(lamb, mx2).
aviao(besenyei,edge540).
aviao(chambliss, edge540).
aviao(maclean, edge540).
aviao(mangold, edge540).
aviao(jones, edge540).
aviao(bonhomme, edge540).

/* Circuitos */

circuitos(instanbul).
circuitos(budapest).
circuitos(porto).

/* Vitorias */

vitoria(jones,porto).
vitoria(mangold, budapest).
vitoria(mangold, instanbul).

/* Numero de gates */

gates(instanbul, 9).
gates(budapest, 6).
gates(porto, 5).

/* Vitoria da equipa */

vitoriaEquipa(Equipa,Circuito) :-  equipa(Piloto, Equipa), vitoria(Piloto,Circuito), circuitos(Circuito).

/* Queries 

vitoria(X, porto).

vitoriaEquipa(X, porto).

vitoria(Piloto, Circuito1), vitoria(Piloto, Circuito2), Circuito1 \== Circuito2.

gates(Circuito, Gates), Gates @>8.  

aviao(Piloto, Aviao), Aviao \== edge540.
OU
\+ aviao(Piloto, 'edge540'). ??? NÂO FUNCIONA

*/