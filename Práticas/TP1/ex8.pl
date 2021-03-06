cargo(tecnico, rogerio).
cargo(tecnico, ivone).
cargo(engenheiro, daniel).
cargo(engenheiro, isabel).
cargo(engenheiro, oscar).
cargo(engenheiro, tomas).
cargo(engenheiro, ana).
cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).

chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, director).
chefiado_por(secretaria_exec, director).

/*
a) ?- chefiado_por(tecnico, X), chefiado_por(X,Y).
b) ?- chefiado_por(tecnico, X), cargo(X,ivone), cargo(Y,Z).                 ??? deve estar mal o enunciado
c) ?- cargo(supervisor, X); cargo(supervisor, X).
d) ?- cargo(J,P), (chefiado_por(J, supervisor_chefe);
chefiado_por(J, supervisor)).
e) ?- chefiado_por(P, director), not(cargo(P, carolina)).
*/

% a) Qual é o cargo que chefia o tecnico e é chefiado por algum cargo?
% b) Qual é o cargo que a Ivone possui, que chefia o tecnico e qual o cargo que alguem tem?
% c) Quem é que possui o cargo de supervisor?
% d) Qual é o cargo de quem é chefiado pelo supervisor_chefe ou pelo supervisor?
% e) Qual é o cargo de quem é, sem ser a carolina, chefiado pelo diretor?  