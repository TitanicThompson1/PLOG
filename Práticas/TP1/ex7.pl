/* Codigo original
traduza(Codigo, Significado) :- Codigo = 1, Significado = integer_overflow.

traduza(Codigo, Significado) :- Codigo = 2, Significado = divisao_por_zero.

traduza(Codigo, Significado) :- Codigo = 3, Significado = id_desconhecido.

*/

traduza(Codigo, Significado) :- (Codigo = 1, Significado = integer_overflow); (Codigo = 2, Significado = divisao_por_zero); (Codigo = 3, Significado = id_desconhecido).