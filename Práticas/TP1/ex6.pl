/*  
“Tweety é um pássaro. Goldie é um peixe. Molie é uma minhoca. Pássaros gostam de minhocas. Gatos
gostam de peixes. Gatos gostam de pássaros. Amigos gostam uns dos outros. O meu gato é meu amigo. O
meu gato come tudo o que gosta. O meu gato chama-se Silvester.”
*/

passaro(tweety).
peixe(goldie).
minhoca(molie).
gato(silvester).

gosta_de(Passaro, Minhoca) :- passaro(Passaro), minhoca(Minhoca).
gosta_de(Gato, Passaro) :- gato(Gato), passaro(Passaro).
gosta_de(Gato, Peixe) :- gato(Gato), passaro(Peixe).
gosta_de(Amigo1, Amigo2), gosta_de(Amigo2, Amigo1) :- amigos(Amigo1, Amigo2); amigos(Amigo2, Amigo1).   

come(Gato, Gosta) :- gato(Gato), meu(Gato), gosta_de(Gato, Gosta).

nome(Gato, silvester), amigos(eu, Gato) :- gato(Gato), meu(Gato).



