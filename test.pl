% Predicato che definisce la relazione transitiva di odio verso Paolo
odioversopaolo(alice,marco). % fatto: alice odia marco (verso paolo)
odioversopaolo(marco,lorenzo). % fatto: marco odia lorenzo (verso paolo)
% regola transitiva: se X odia Y e Y odia Z, allora X odia Z
odioversopaolo(X,Z) :- odioversopaolo(X,Y), odioversopaolo(Y,Z).


% Fatti: definiscono dove lavorano i dipendenti
lavora(emp1,ibm).
lavora(emp2,ibm).
lavora(emp3,google).
lavora(emp4,crif).
lavora(emp5,google).
% Verifica che due variabili siano diverse
personeDiverse(X,Y) :- X\==Y. 
% X e Y sono colleghi se lavorano nella stessa azienda Z e sono persone diverse
collega(X,Y) :- lavora(X,Z), lavora(Y,Z), personeDiverse(X,Y). 

% Fatti: definiscono le relazioni padre-figlio
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

% X è nonno di Y se X è padre di Z e Z è padre di Y
nonno(X,Y) :- padre(X,Z), padre(Z,Y).
% X è bisnonno di Y se X è nonno di Z e Z è padre di Y
bisnonno(X,Y) :- nonno(X,Z), padre(Z,Y).
% X è nipote di Y se Y è nonno di X (relazione inversa)
nipote(X,Y) :- nonno(Y,X). 
% X è pronipote di Y se Y è bisnonno di X (relazione inversa)
pronipote(X,Y) :- bisnonno(Y,X).
% X è antenato di Y se X è padre di Y (caso base)
antenato(X,Y) :- padre(X,Y).
% X è antenato di Y se X è nonno di Y
antenato(X,Y) :- nonno(X,Y).
% X è antenato di Y se X è bisnonno di Y
antenato(X,Y) :- bisnonno(X,Y).


% Restituisce l'ultimo elemento L di una lista
% Caso base: lista con un solo elemento (sintassi [L|[]] equivale a [L])
m_last([L|[]],L):- !. % cut per evitare backtracking
% Caso ricorsivo: scarta la testa e continua sulla coda
m_last([_|R],L):- m_last(R,L).

% Restituisce il primo elemento H di una lista
m_first([H|_],H).

% Calcola la lunghezza N di una lista
% Caso base: lista vuota ha lunghezza 0
m_length([], 0).
% Caso ricorsivo: lunghezza = 1 + lunghezza della coda
m_length([_|L], N) :- m_length(L, N1), N is N1 + 1.

% Inverte una lista (restituisce R)
% Caso base: lista vuota invertita è lista vuota
m_rev([], []).
% Caso ricorsivo: inverte la coda T2, poi appende la testa H alla fine
m_rev([H|T], R):- m_rev(T, T2),append(T2, [H], R).

% Appende due liste (L3 è concatenazione di lista1 e L2)
% Caso base: appendere lista vuota a L3 dà L3
m_app([], L3, L3).
% Caso ricorsivo: la testa H della prima lista diventa testa del risultato
m_app([H|T1], L2, [H|T3]) :- m_app(T1, L2, T3).

% Conta quante volte l'elemento A compare nella lista
% Caso base: lista vuota contiene 0 occorrenze
count([],_,0).
% Se la testa è A, incrementa il contatore e usa cut per evitare la regola successiva
count([A|REST],A,N):- count(REST,A,N1), N is N1+1,!.
% Se la testa non è A, non incrementa il contatore
count([_|REST],B,N):- count(REST,B,N).

% Definizione duplicata/ridondante di collega (già definita sopra)
collega(A,B).
collega(B,C).
% Transitività: A è collega di C se A è collega di B e B è collega di C
collega(A,C) :- collega(A,B),collega(B,C).


% Si definisca un predicato Prolog somma_segno(L, SP, SN) che riceve in ingresso 
% una lista di numeri interi L e
% restituisce: in SP la somma di tutti i numeri positivi che compaiono in L,
% in SN la somma di tutti i numeri negativi che
% compaiono in L. Se la lista L è vuota, allora sia SP che SN devono valere 0.
% Esempi:
% ?- somma_segno([-2, 4, -5, 1], SP, SN).
% Yes SP = 5 SN = -7
% ?- somma_segno([], SP, SN).
% Yes SP = 0 SN = 0

% Caso base: lista vuota, entrambe le somme sono 0
somma_segno([],0,0).
% Se H >= 0: somma H a SP, lascia SN invariato. Cut per evitare la regola successiva
somma_segno([H|T],SP,SN) :- H >= 0,!, somma_segno(T,SP1,SN), SP is SP1 + H.
% Se H < 0: somma H a SN, lascia SP invariato
somma_segno([H|T],SP,SN) :- H < 0, somma_segno(T,SP,SN1), SN is SN1 + H.

% tu devi fissare/mettere/esporre nel output un valore e come lo fai e con is 
% somma_segno([H|T],SP1+H,SN) :- H >= 0, somma_segno(T,SP1,SN)


% Si scriva un predicato Prolog split(L1, N, L2) che data in ingresso la
% lista L1 e l'intero N, restituisce la lista L2
% contenente i primi N elementi di L1 . Se N è maggiore della lunghezza della 
% lista L1 (si veda secondo esempio sotto),
% il predicato fallisce. Esempi:
% ? - split([a,b,c,d,e,f,g,h,i,k], 3, L).
%Yes L = [a,b,c]
% ?- split([i,k], 3, L).
% No

% Se N < 0, fallisce con cut
m_split([],N,_):-N<0,!.
% Caso base: se N=0, restituisce lista vuota (presi 0 elementi)
m_split(_,0,[]).
% IO HO MESSO N1 + 1 PERCHE N è SEMPRE UNO IN PIU DEL PROSSIMO N1 ESIMO 
% Caso ricorsivo: mette H nel risultato e decrementa N (N = N1 + 1)
m_split([H|T],N,[H|T1]):-m_split(T,N1,T1),N is N1 + 1.




%Esercizio 3 (4 punti)
%Si scriva un predicato Prolog prod(L1, L2, L3) che date in ingresso le
% liste L1 e L2 di interi e della stessa lunghezza,
%restituisce la lista L3 contenente gli interi che sono prodotto degli 
% elementi corrispondenti di L1 ed L2 . Esempi:
%?- prod([2,4,6], [1,2,3], L).
%Yes L = [2,8,18]
%?- prod([1], [1,2,3], L).
%No
%?- prod([1,2,3], [], L).
%No

% Caso base: due liste vuote danno lista vuota come risultato
m_prod([],[],[]).
% Se una lista è vuota e l'altra no, fallisce con cut
m_prod([],[_],_):-!.
m_prod([_],[],_):-!.
% Caso ricorsivo: C è il prodotto di A*B, poi continua sulle code
m_prod([A|T1],[B|T2],[C|T3]):- C is A*B, m_prod(T1,T2,T3).


% Si scriva un predicato Prolog max(L1, L2, L3) che, date in ingresso le 
% liste L1 e L2 di interi della stessa lunghezza,
% restituisce nella lista L3 gli interi che sono il massimo tra gli 
% elementi di L1 ed L2 di posizione corrispondente. Se le liste
% L1 e L2 sono di diversa lunghezza il predicato fallisce. Esempi:
% ?- max([4,7,9], [2,12,6], L).
% Yes L = [4, 12, 9]
% ?-max([4,7,9], [2,12], L).
% No

% Se una lista è vuota e l'altra no, fallisce (liste di lunghezza diversa)
m_max([_],[],_):-fail. % potevi non metterli ? bho
m_max([],[_],_):-fail. %
% Caso base: due liste vuote danno lista vuota
m_max([],[],[]).
% Se H1 >= H2, mette H1 nel risultato. Cut per evitare la regola successiva
m_max([H1|T1],[H2|T2],[H1|T3]):-H1>=H2,m_max(T1,T2,T3),!.
% Se H2 > H1, mette H2 nel risultato
m_max([H1|T1],[H2|T2],[H2|T3]):-H2>H1,m_max(T1,T2,T3).
