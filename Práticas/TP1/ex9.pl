aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).

funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).

/* 
a) Quem são os alunos do professor X?
b) Quem são as pessoas da universidade X? (alunos ou docentes)
c) Quem é colega de quem? Se aluno: é colega se for colega de disciplina ou colega de curso ou colega
de universidade. Se professor: se for professor da mesma universidade.
*/

?- professor(X, Cadeira), aluno(Aluno, Cadeira), frequenta(Aluno, Faculdade), funcionario(Faculdade).
?- frequenta(Aluno, X); funcionario(Funcionario, X).
?- ((aluno(Aluno1, Cadeira), aluno(Aluno2, Cadeira)); (curso(Aluno1, Curso), curso(Aluno2, Curso)); (frequenta(Aluno1, Faculdade), frequenta(Aluno2, Faculdade)), Aluno1 \== Aluno2)  
            ; (funcionario(Funcionario1, Faculdade), funcionario(Funcionario2, Faculdade), Funcionario1 \== Funcionario2)