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
%collega(X,Y) :- lavora(X,Z), lavora(Y,Z), personeDiverse(X,Y). 



% Fatti: defincono le relazioni padre-figlio
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
m_max([],[_],_):-!,false. %
% Caso base: due liste vuote danno lista vuota
m_max([],[],[]).
% Se H1 >= H2, mette H1 nel risultato. Cut per evitare la regola successiva
m_max([H1|T1],[H2|T2],[H1|T3]):-H1>=H2,m_max(T1,T2,T3),!.
% Se H2 > H1, mette H2 nel risultato
m_max([H1|T1],[H2|T2],[H2|T3]):-H2>H1,m_max(T1,T2,T3).



% maggioriLista(N,L1,L2)
% N numero intero 
% L1 lista di input
% L2 lista output con soli primi N elementi
% undersplit(L1,N,L2).
undersplit(0,_,[]).
undersplit(0,N,N).
undersplit(N,[H1|T1],[H1|T2]):-undersplit(N1,T1,T2),N is N1+1.



% Si scriva in Prolog il predicato delList(L1,L2,L3), che risulta vero quando L3 rappresenta la 
% lista degli elementi di L2 in
% cui sono stati eliminati tutti gli elementi che compaiono in L1. A tal fine si utilizzi opportunamente
% (riportandolo
% anche nella soluzione) il predicato delete presentato anche a lezione.



% ?- delList([1,2,3], [1,2,3,4,2,1,5],X)
% X = [4, 5]
% ?-delList([8], [1,2,3,4,2,1,5],X)
% X = [1, 2, 3, 4, 2, 1, 5]
delList(_,[],[]):-!.
delList([], L, L) :- !.
delList([H|T],L2,R):-delete(L2,H,RIS),delList(T,RIS,R).



mmmax([],[],[]):-!.
mmmax(_,[],_):-false,!.
mmmax([],_,_):-false,!.
mmmax([H1|T1],[H2|T2],[H1|T3]):- H1>=H2,!,mmmax(T1,T2,T3).
mmmax([H1|T1],[H2|T2],[H2|T3]):- H2>H1,mmmax(T1,T2,T3).



% Si scriva un predicato Prolog split(L1, N, L2) che data in ingresso la lista L1 e l'intero N,
%  restituisce la lista L2
% contenente i primi N elementi di L1 . Se N è maggiore della lunghezza della lista L1
%  (si veda secondo esempio sotto),
% il predicato fallisce. Esempi:
% ?- split([a,b,c,d,e,f,g,h,i,k], 3, L).
% Yes L = [a,b,c]
% ?- split([i,k], 3, L).
% No
mmsplit([H|T],N,[H|T2]):-mmsplit(T,N1,T2),N is N1+1.
mmsplit(_,0,[]).
mmsplit(L,0,L).





mmin([],[],[]).
mmin([H1|T1],[H2|T2],[H1|T3]) :- H1<H2,!,mmin(T1,T2,T3).
mmin([H1|T1],[H2|T2],[H2|T3]) :- H2<H1,mmin(T1,T2,T3).




pianeta_spritz([],[],[]).
pianeta_spritz([H1|T1],[H2|T2],[H3|T3]) :- H3 is sqrt((H1+H2)/2),pianeta_spritz(T1,T2,T3).



divsegno([],[],[]).
divsegno([H1|T1],[H1|SP],SN) :- H1 > 0,!,divsegno(T1,SP,SN).
divsegno([H1|T1],SP,[H1|SN]) :- H1 < 0,divsegno(T1,SP,SN).



selectlist([],_,_,[]).
selectlist([H1|T1],M,L2,[H1|R]):-
    H1>M,!,
    member(H1,L2),
    selectlist(T1,M,L2,R).
selectlist([_|T1],M,L2,R):-
    selectlist(T1,M,L2,R),!.



merge([],L,L) :- !.
merge(L,[],L) :- !.
merge([H|T],[H2|T2],[H|T3]) :- H<H2,!, merge(T,[H2|T2],T3).
merge([H|T],[H2|T2],[H2|T3]) :- merge([H|T],T2,T3).


mmmsplit(L,0,L).
mmmsplit([],_,[]):-false,!.
mmmsplit([H|T],N,[H|T2]):- mmmsplit(T,N1,T2),N is N1+1.


delete(_,[],[]):-!.
delete(H,[H|L1],L2) :- !, delete(H,L1,L2).
delete(H,[X|L1],[X|L2]) :- delete(H,L1,L2).

ddellist(_,[],[]):-!.
ddellist([],L,L):-!.
ddellist([H|L1],L2,L3) :- delete(H,L2,LN),ddellist(L1,LN,L3).


% DOMANDE POSTE DA IA PER MIGLIORARE UN PO!
%## **Livello Base**

%
%1. **`member/2`** - Verifica se un elemento appartiene a una lista
%   - `member(3, [1,2,3,4])` → `true`
%   - `member(5, [1,2,3,4])` → `false`

hmember(N,[N|T]):-!.
hmember(N,[_|T]):-hmember(N,T).



%2. **`append/3`** - Concatena due liste
%   - `append([1,2], [3,4], X)` → `X = [1,2,3,4]`

happend([],L,L).
happend([H|T1],T2,[H|T3]):-append(T1,T2,T3).



%3. **`last/2`** - Trova l'ultimo elemento di una lista
%   - `last([1,2,3,4], X)` → `X = 4`
hlast([X],X):-!. % [X] UN SOLO ELEMENTO X
hlast([_|X],T1) :- hlast(X,T1).

%## **Livello Intermedio**

%5. **`count/3`** - Conta quante volte un elemento compare in una lista
%   - `count(3, [1,3,2,3,3], N)` → `N = 3`

hcount(_,[],0).
hcount(N,[N|T],S) :- hcount(N,T,S1),S is S1+1,!.
hcount(N,[_|T],S) :- hcount(N,T,S).



6. **`substitute/4`** - Sostituisce tutte le occorrenze di un elemento con un altro
   - `substitute(2, 9, [1,2,3,2], X)` → `X = [1,9,3,9]`

msubstitute(_,_,[],_).
msubstitute(_, _, [], []).
msubstitute(N, M, [M|R1], [N|R2]) :- msubstitute(N, M, R1, R2).
msubstitute(N, M, [X|R1], [X|R2]) :- X \= M, msubstitute(N, M, R1, R2).



%7. **`remove_duplicates/2`** - Rimuove i duplicati da una lista
%   - `remove_duplicates([1,2,2,3,1,4], X)` → `X = [1,2,3,4]`

remove_duplicates([],[]). 
remove_duplicates([H|T], [H|R]) :- not(member(H,T)),remove_duplicates(T, R),!.
remove_duplicates([_|T], R) :- remove_duplicates(T, R).



%8. **`intersection/3`** - Trova l'intersezione tra due liste
%   - `intersection([1,2,3], [2,3,4], X)` → `X = [2,3]`

miamember(A,[A|R2]):-!.
miamember(A,[_|R2]):-miamember(A,R2).


intersection([],_,[]).
intersection([],L1,L2).
intersection([A|B],L2,[A|REST]):-miamember(A,L2),intersection(B,L2,REST),!.
intersection([A|B],L2,L3):-intersection(B,L2,L3).


%## **Livello Avanzato (simili al tuo esempio)**

%9. **`delete_first/3`** - Elimina solo la prima occorrenza di un elemento
%   - `delete_first(2, [1,2,3,2], X)` → `X = [1,3,2]`

delete_first(N,[],[]).
delete_first(N,[N|R],RIS):-not(member(N,R)),delete_first(N,R,RIS),!.
delete_first(N,[A|R],[A|RIS]):-delete_first(N,R,RIS).


delete_first_no_member(N,[],[]).
delete_first_no_member(N,[N|R],RIS):-delete_first(nothing,R,RIS),!.
delete_first_no_member(N,[A|R],[A|RIS]):-delete_first(N,R,RIS).


%10. **`delete_all_list/3`** - Elimina da una lista tutti gli elementi che compaiono in un'altra lista (come il tuo `ddellist`)
%    - `delete_all_list([2,4], [1,2,3,4,5], X)` → `X = [1,3,5]`
delete_all_list([],C,C).
delete_all_list([A|B],C,X):-delete(A,C,R),!,delete_all_list(B,R,X).
delete_all_list([_|B],C,X):-delete_all_list(B,R,X).
                                                                    
%11. **`split_at/4`** - Divide una lista in due parti alla posizione N
%    - `split_at(2, [1,2,3,4,5], L1, L2)` → `L1 = [1,2], L2 = [3,4,5]`
split_at(_,[],[],[]).
split_at(N,[H|T],[H|T2],L2):-N>0,!,N1 is N-1,split_at(N1,T,T2,L2).
split_at(N,[H|T],L2,[H|T2]):-split_at(N,T,L2,T2).



%12. **`partition/4`** - Partiziona una lista in base a un predicato (elementi che soddisfano vs non soddisfano)
%    - `partition(>(3), [1,4,2,5,3], Maggiori, Minori)` → `Maggiori = [4,5], Minori = [1,2,3]`
partition(_,[],[],[]).
partition(N, [H|T], [H|T2], L3):- H>N,!,partition(N, T, T2, L3).
partition(N, [H|T], T2, [H|L3]):- partition(N, T, T2, L3).



tremax(A,B,L) :- tremax(A,B,L,0).
tremax(_,_,L,3):-!.
tremax([],[C|B],[C|R],N):- !,N1 is N+1, tremax([],B,R,N1).
tremax([C|B],[],[C|R],N):- !,N1 is N+1, tremax(B,[],R,N1).
tremax([A|B],[C|B2],[A|B3],N) :- N1 is N+1, A > C,!,tremax(B,B2,B3,N1).
tremax([_|B],[C|B2],[C|B3],N) :- N1 is N+1, tremax(B,B2,B3,N1).


genericmax([],[],[]).
genericmax([H1|T1],[H2|T2],[H1|T3]):- H1>H2,!,genericmax(T1,T2,T3).
genericmax([_|T1],[H2|T2],[H2|T3]):-genericmax(T1,T2,T3).


%a([]):-write("qui0"),nl,!.
a([_|R]):-write("qui!!"),a(R),nl.
a([_]):-write("qui1"),nl.
a([[]|_]):-write("qui2"),nl.
a([_|[]]):-write("qui3"),nl,!.

gmember([A|_],A):-!.
gmember([_|R],A):-gmember(R,A).

inserisciOrdL([],[],[]).
inserisciOrdL([],L,L).
inserisciOrdL(L,[],L).
inserisciOrdL([A|R1],[B|R2],[A|R3]):-A<B,!,inserisciOrdL(R1,[B|R2],R3).
inserisciOrdL([A|R1],[B|R2],[B|R3]):-inserisciOrdL([A|R1],R2,R3).


inserisciOrd(N,[],[N]).
inserisciOrd(N,[H|T1],[N,H|T1]):-N<H,!.
inserisciOrd(N,[H|T1],[H|T2]):-inserisciOrd(N,T1,T2).


%inserisciOrd2(N,[],[N]).
inserisciOrd2(N,[H|T1],[H|T2]):-N>H,!,inserisciOrd2(N,T1,T2).
inserisciOrd2(N,L2,[N|L2]).%inserisciOrd2(N,[H|T1],[N,H|T1]).


cl([],_):-true,!.
cl([A,_],N):- \+(gmember(A,N)),!.
cl([_|T],N):-cl(T,N).


gdelete(_,[],[]).
gdelete(A,[A|R],R):-!,gdelete(A,R,R).
gdelete(A,[B|R2],[B|R]):-gdelete(A,R2,R).

gdl([],L,L).
gdl([A|R],R2,R4) :- gdelete(A,R2,R3),!,gdl(R,R3,R4).
gdl([_|R],R2,R3) :- gdl(R,R2,R3).

max([X], X).
max([H|T], H) :- max(T, MT), H >= MT,!.
max([H|T], MT) :- max(T, MT).


lla([A|B]):-write(A),lla(B).


d_delete(_,[],[]).
d_delete(A,[B|R],[B|L2]):- not(A==B),!,d_delete(A,R,L2).
d_delete(A,[A|R],R1):- d_delete(A,R,R1).


lllast([A],A).
lllast([A|R],B):-lllast(R,B).


seallorasplit(_,[],[]).
seallorasplit(N,[H|T],[H|T2]) :- (N>(20+H)),!,seallorasplit(N,T,T2).
seallorasplit(N,[_|T],T2):-seallorasplit(N,T,T2).


hmin([A],A):-!.
hmin([A|N],A) :- hmin(N,M),A < M,!.
hmin([A|N],M) :- hmin(N,M).


remove_dups([],_,[]).
remove_dups([A|B],L2,[A|R]):- \+(member(A,L2)),!,remove_dups(B,L2,R).
remove_dups([_|B],L2,R):- remove_dups(B,L2,R).




membro(_,[]):-false,!.
membro(H,[H|_]).
membro(H,[_|R]):-membro(H,R).



pisaunicalista([],[]).
pisaunicalista([A|R],[A|R2]):-membro(A,R),!,pisaunicalista(R,R2).
pisaunicalista([_|R],R2):-pisaunicalista(R,R2).



stacca([],_,[]).
stacca(_,0,[]):-!.
stacca([A|R],N,[A|R2]):-N1 is N-1,stacca(R,N1,R2).



ssl([_|R],RA):-write("cazzo"),ssl(R,RA).


m(_,[]).
m(N,[N|_]).
m(N,[_|T]):-m(N,T).



scelgolista([],_,_,[]).
scelgolista([A|R1],M,L2,[A|RES]):- A>M, \+(member(A,L2)),scelgolista(R1,M,L2,RES).
scelgolista([A|R1],M,L2,RES):-scelgolista(R1,M,L2,RES).









moltiplicazione([],[],[]).
moltiplicazione([H1|R1],[H2|R2],[P|R]):- P is H1*H2,!,moltiplicazione(R1,R2,R).










tictac([],[],_):-!.
tictac(A,B):-tictac(A,B,1).
tictac([A|R1],[C|R2],N):- 1 is N mod 2, !, C is A*A*A, N1 is N+1,tictac(R1,R2,N1).
tictac([A|R1],[Q|R2],N):- Q is A*A, N1 is N+1,tictac(R1,R2,N1).




dl(L,N):-dl(L,1,N).
dl([],_,[]):-!.
dl([A|R1],N,[A|R2]):- 1 is N mod 2, !, N1 is N+1, dl(R1,N1,R2).
dl([A|R1],N,R2):- N1 is N+1, dl(R1,N1,R2).


plz([],0).
plz([A|R],N):-plz(R,N1),N is N1+1.


dio(N,[],[N]).
dio(N,[A|R],[N,A|R]):-N<A,!.
dio(N,[A|R],[A|R2]):-dio(N,R,R2).





divisionerumorosa(L,0,[]):-!.
divisionerumorosa([],_,[]):-!.
divisionerumorosa([A|L],N,[A|L2]):- N1 is N-1,divisionerumorosa(L,N1,L2).




sommatoria([],N,_):-N>0,!,false.
sommatoria(_,0,0):-!.
sommatoria([A|R],N,S):- N>0, N1 is N-1, sommatoria(R,N1,S1), S is S1+A.




















