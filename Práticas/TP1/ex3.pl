/* Nacionalidade */

nacionalidade(ecadeQueiros, portugues).
nacionalidade(camiloCasteloBrnaco, portugues).
nacionalidade(gerogeOrwell, ingles).
nacionalidade(fernandoPessoa, portugues).
nacionalidade(jRRTolkien, ingles).

/* Genre */ 
tipo(osMaias, romance).
tipo(amordePerdicao, romance).
tipo('1984', ficcao).
tipo(mensagem, poesia).
tipo(senhorDosAneis, ficcao).
tipo('quintadosAnimais', romance).

/* Author */

escreveu(ecadeQueiros, osMaias).
escreveu(camiloCasteloBrnaco, amordePerdicao).
escreveu(gerogeOrwell, '1984').
escreveu(gerogeOrwell, quintadosAnimais).
escreveu(fernandoPessoa, mensagem).
escreveu(jRRTolkien, senhorDosAneis).



?- escreveu(Autor, osMaias).

?- nacionalidade(Autor, portugues), escreveu(Autor, _Livro), tipo(_Livro, romance).

?- escreveu(Autor, _Livro1), tipo(_Livro1, ficcao), escreveu(Autor, _Livro2), tipo(_Livro2, _Tipo), _Livro1 \== _Livro2, _Tipo \== ficcao.