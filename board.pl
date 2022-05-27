:- [utils].



:- dynamic
    wall/1,
    muro_del_jugador/2,
    estado_puntuaciones/2,
    estado_zona_final/2,
    estado_zona_preparacion/2,
    dictionary_colors/2,
    azulejos_zona_final/2
.





iniciar_dictionary(0):-asserta(dictionary_colors(1,black)),
    asserta(dictionary_colors(2,red)),
    asserta(dictionary_colors(3,blue)),
    asserta(dictionary_colors(4,yellow)),
    asserta(dictionary_colors(5,green)).
% black-1, red-2, blue-3, yellow-4, green-5
iniciar_wall(0):- retractall(wall(_)),
    asserta(wall([[3,4,2,1,5],[5,3,4,2,1],[1,5,3,4,2],[2,1,5,3,4],[4,2,1,5,3,4]])).

inicializar_puntuaciones([]).
inicializar_puntuaciones([X|Otros]):-asserta(estado_puntuaciones(X,0)),
    inicializar_puntuaciones(Otros).

inicializar_zona_final([]).
inicializar_zona_final([X|Otros]):-
    asserta(estado_zona_final(X,0)),
    inicializar_zona_final(Otros).

inicializar_zona_de_preparacion([]).
inicializar_zona_de_preparacion([X|Otros]):-
    asserta(estado_zona_preparacion(X,[[empty,0,1],[empty,0,2],[empty,0,3],[empty,0,4],[empty,0,5]])),
    inicializar_zona_de_preparacion(Otros).

inicilizar_muros([]).
inicilizar_muros([X|Otros]):-
    asserta(muro_del_jugador(X,[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]])),
    inicilizar_muros(Otros).

cambiar_estado_muro(X,Muro):-muro_del_jugador(X,Muro_anterior),
    retract(muro_del_jugador(X,Muro_anterior)),
    asserta(muro_del_jugador(X,Muro)).

aumentar_zona_final(X,L):- estado_zona_final(X,N),
    N_1 is n+L,
    retract(estado_zona_final(X,N)),
    asserta(estado_zona_final(X,N_1)).

aumenta_color_zona_final(J,Color,C,R):-
    estado_zona_final(J,E),
    7<E+C,!,
    C1 is 7-E,
    R is C-C1,
    azulejos_zona_final(J,A),
    dictionary_colors(N,Color),
    forma_nueva_zona_final(A,N,C1,1,L),
    retract(azulejos_zona_final(J,A)),
    asserta(azulejos_zona_final(J,L))
    .
aumenta_color_zona_final(J,Color,C,R):-R is 0,!,
    azulejos_zona_final(J,A),
    dictionary_colors(N,Color),
    forma_nueva_zona_final(A,N,C,1,L),
    retract(azulejos_zona_final(J,A)),
    asserta(azulejos_zona_final(J,L))
    .
forma_nueva_zona_final([],_,_,_,[]):-!.
forma_nueva_zona_final([A|R],N,C,N,[L|Resto]):-!,
    L is A+C,
    forma_nueva_zona_final(R,N,C,6,Resto)
.
forma_nueva_zona_final([A|R],N,C,Count,[L|Resto]):-Count1 is Count+1,
    L is A,
    forma_nueva_zona_final(R,N,C,Count1,Resto).

inicializar_azulejos_zona_final([]).
inicializar_azulejos_zona_final([X|R]):-
    asserta(azulejos_zona_final(X,[0,0,0,0,0])),
    inicializar_azulejos_zona_final(R).

nueva_zona_preparacion(J,Dispo,Fila,Color,Cant,Ubicados,R):- Dispo>=Cant,!,
    N is Ubicados+Cant,
    estado_zona_preparacion(J,A),
    form(A,Fila,N,Color,1,A1),
    retract(estado_zona_preparacion(J,A)),
    asserta(estado_zona_preparacion(J,A1)),
    R is 0
    .
nueva_zona_preparacion(J,Dispo,Fila,Color,Cant,_,R):-
    Resto is Cant-Dispo,
    estado_zona_preparacion(J,A),
    form(A,Fila,Dispo,Color,1,A1),
    retract(estado_zona_preparacion(J,A)),
    asserta(estado_zona_preparacion(J,A1)),
    aumenta_color_zona_final(J,Color,Resto,R),
    Resto1 is Resto-R,
    aumentar_zona_final(J,Resto1)
    .


form([],_,_,_,_,[]):-!.
form([_|R],0,N,Color,Count,[A1|Resto]):-!,A1 = [Color,N,Count],form(R,-1,N,Color,Count,Resto).
form([A|R],Fila,N,Color,Count,[A1|Resto]):-
    Fila1 is Fila-1,
    A1 is A,
    Count1 is Count+1,
    form(R,Fila1,N,Color,Count1,Resto).


calcular_zona_final(0,0).
calcular_zona_final(1,-1).
calcular_zona_final(2,-2).
calcular_zona_final(3,-4).
calcular_zona_final(4,-6).
calcular_zona_final(5,-8).
calcular_zona_final(6,-11).
calcular_zona_final(7,-14).










































