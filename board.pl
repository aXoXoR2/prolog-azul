:- [utils].



:- dynamic
    wall/1,
    muro_del_jugador/2,
    estado_puntuaciones/2,
    estado_zona_final/2,
    estado_zona_preparacion/3,
    dictionary_colors/2
.
           




iniciar_dictionary(0):-asserta(dictionary_colors(1,black)),
    asserta(dictionary_colors(2,red)),asserta(dictionary_colors(3,blue)),asserta(dictionary_colors(4,yellow)),asserta(dictionary_colors(5,green)).
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
    asserta(estado_zona_preparacion(X,[[0,0,1],[0,0,2],[0,0,3],[0,0,4],[0,0,5]])),
    inicializar_zona_de_preparacion(Otros).

inicilizar_muros([]).
inicilizar_muros([X|Otros]):-
    asserta(muro_del_jugador(X,[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]])),
    inicilizar_muros(Otros).

cambiar_estado_muro(X,Muro):-muro_del_jugador(X,Muro_anterior),
    retract(muro_del_jugador(X,Muro_anterior)),
    asserta(muro_del_jugador(X,Muro)).

pedir_fila(X,Number,Fila):-muro_del_jugador(X,Muro),
    Fila is index(Muro,Number).

aumentar_zona_final(X,L):- estado_zona_final(X,N),
    N_1 is n+L,
    retract(estado_zona_final(X,N)),
    asserta(estado_zona_final(X,N_1)).

calcular_zona_final(0,0).
calcular_zona_final(1,-1).
calcular_zona_final(2,-2).
calcular_zona_final(3,-4).
calcular_zona_final(4,-6).
calcular_zona_final(5,-8).
calcular_zona_final(6,-11).
calcular_zona_final(7,-14).