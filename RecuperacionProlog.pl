% Joan Martorell Ferriol

compta :- asserta(comptador(0)), permutacion([a,b,c,-],F1),permutacion([a,b,c,-],F2),permutacion([a,b,c,-],F3),permutacion([a,b,c,-],F4),contador(F1,F2,F3,F4).
compta :- nl,write("Hi ha "),
	comptador(X),
	write(X), write(" solucions.").

contador(F1,F2,F3,F4) :- solucion(F1,F2,F3,F4), comptador(X), X1 is X + 1, retract(comptador(X)), asserta(comptador(X1)), fail.

lletres(N,E,S,W) :- permutacion([a,b,c,-],F1),permutacion([a,b,c,-],F2),permutacion([a,b,c,-],F3),permutacion([a,b,c,-],F4), solucion(F1,F2,F3,F4),
	nth0(0,N,N1),nth0(1,N,N2),nth0(2,N,N3),nth0(3,N,N4),
	nth0(0,E,E1),nth0(1,E,E2),nth0(2,E,E3),nth0(3,E,E4),
	nth0(0,S,S1),nth0(1,S,S2),nth0(2,S,S3),nth0(3,S,S4),
	nth0(0,W,W1),nth0(1,W,W2),nth0(2,W,W3),nth0(3,W,W4),

	nth0(0,F1,F11),nth0(1,F1,F12),nth0(2,F1,F13),nth0(3,F1,F14),
	nth0(0,F2,F21),nth0(1,F2,F22),nth0(2,F2,F23),nth0(3,F2,F24),
	nth0(0,F3,F31),nth0(1,F3,F32),nth0(2,F3,F33),nth0(3,F3,F34),
	nth0(0,F4,F41),nth0(1,F4,F42),nth0(2,F4,F43),nth0(3,F4,F44),

	%restricciones de esquinas
	esquina(N1,W4,F11), esquina(N4,E1,F14), esquina(E4,S1,F44), esquina(S4,W1,F41),

	%restricciones de los lados
	lado(N2,F12), lado(N3,F13), lado(E2,F24), lado(E3,F34), lado(S2,F43), lado(S3,F42), lado(W2,F31), lado(W3,F21),	

	%restricciones centrales
	centro(N2,F12,F22), centro(N3,F13,F23), centro(E2,F24,F23), centro(E3,F33,F32), centro(S2,F43,F33), centro(S3,F42,F32), centro(W2,F31,F32), centro(W3,F21,F22),

	tab(3), write(N1), tab(1), write(N2), tab(1), write(N3), tab(1), write(N4), nl,
	write(W4), tab(1), write(F1), tab(1), write(E1), nl, 
	write(W3), tab(1), write(F2), tab(1), write(E2), nl, 
	write(W2), tab(1), write(F3), tab(1), write(E3), nl,
	write(W1), tab(1), write(F4), tab(1), write(E4), nl,
	tab(3), write(S4), tab(1), write(S3), tab(1), write(S2), tab(1), write(S1), nl.

permutacion([],[]).
permutacion([X|Y],Z) :- permutacion(Y,L),insertar(X,L,Z).	%Predicado que permuta los elementos de una lista

insertar(E,L,[E|L]).
insertar(E,[X|Y],[X|Z]) :- insertar(E,Y,Z).

solucion([F11,F12,F13,F14],[F21,F22,F23,F24],[F31,F32,F33,F34],[F41,F42,F43,F44]) :- 

	%restricciones de repetición en la misma fila o columna
	F11\=F12,F11\=F13,F11\=F14,F11\=F21,F11\=F31,F11\=F41,	%Fila 1 columna 1
	F12\=F13,F12\=F14,F12\=F22,F12\=F32,F12\=F42, 		%Fila 1 columna 2
	F13\=F14,F13\=F23,F13\=F33,F13\=F43, 			%Fila 1 columna 3
	F14\=F24,F14\=F34,F14\=F44,				%Fila 1 columna 4
	F21\=F22,F21\=F23,F21\=F24,F21\=F31,F21\=F41,		%Fila 2 columna 1
	F22\=F23,F22\=F24,F22\=F32,F22\=F42,			%Fila 2 columna 2
	F23\=F24,F23\=F33,F23\=F43,				%Fila 2 columna 3
	F24\=F34,F24\=F44,					%Fila 2 columna 4
	F31\=F32,F31\=F33,F31\=F34,F31\=F41,			%Fila 3 columna 1
	F32\=F33,F32\=F34,F32\=F42,				%Fila 3 columna 2
	F33\=F34,F33\=F43,					%Fila 3 columna 3
	F34\=F44,						%Fila 3 columna 4
	F41\=F42,F41\=F43,F41\=F44,				%Fila 4 columna 1
	F42\=F43,F42\=F44,					%Fila 4 columna 2
	F43\=F44.						%Fila 4 columna 3

%Restricciones

esquina(X, Y, Z) :- X\=Y, Z == '-'.	%Si las restricciones (X e Y) que hacen esquina son diferentes, el elemeto (Z) ha de ser un guión. Si son iguales, 
esquina(X, Y, Z) :- X == Y, X == Z. 	%el elemento (Z) ha de coincidir con las restricciones (X e Y)

lado(X,Y) :- X == Y.			%El elemento (Y) ha de coincidir con la restricción del lado (X), a menos que el elemento (Y) sea un guión
lado(X,Y) :- X\=Y, Y == '-'. 

centro(_,Y,_) :- Y \= '-'.		%Si el elemento central (Z) tiene al lado un guión (Y), entonces el elemeto (Z) ha de coincidir con la restricción
centro(X,Y,Z) :- Y == '-', X == Z.	%del lado (X)