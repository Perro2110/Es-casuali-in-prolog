odioversopaolo(alice,marco). % fatto
odioversopaolo(marco,lorenzo). % fatto
odioversopaolo(X,Z) :- odioversopaolo(X,Y), odioversopaolo(Y,Z). % regola


lavora(emp1,ibm).
lavora(emp2,ibm).
lavora(emp3,google).
lavora(emp4,crif).
lavora(emp5,google).
personeDiverse(X,Y) :- X\==Y. 
collega(X,Y) :- lavora(X,Z), lavora(Y,Z), personeDiverse(X,Y). 

padre(ugo,luisa).
padre(iolo,ugo).
padre(mario,luigi).
padre(mario,giovanna).
padre(marco,giorgio).
padre(giorgio,andrea).
padre(giorgio,ilaria).
padre(flavio,mario).
padre(carlo,flavio).

% A partire da alcuni fatti del tipo padre(X,Y) e madre(X,Y), nei quali X è padre
% (madre) di Y, si definiscano le relazioni nonno(X,Y), bisnonno(X,Y),
% nipote(X,Y), pronipote(X,Y) e antenato(X,Y)

nonno(X,Y) :- padre(X,Z), padre(Z,Y).
bisnonno(X,Y) :- nonno(X,Z), padre(Z,Y).
nipote(X,Y) :- nonno(Y,X). 
pronipote(X,Y) :- bisnonno(Y,X).
antenato(X,Y) :- padre(X,Y).
antenato(X,Y) :- nonno(X,Y).
antenato(X,Y) :- bisnonno(X,Y).


    









    


