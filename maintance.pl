:-[utils,select_tokens,factory,board].


realizar_cambios(Player,Jugada):-index(Jugada,0,X),
    X == -1,!,
    centro_de_mesa(F),
    index(Jugada,1,C_F),
    index(C_F,0,C),
    index(C_F,1,Fila),
    cantidad_en_fabrica(F,C,Cant),
    ubica(Player,Fila,Cant,C,F)
    .

realizar_cambios(Player,Jugada):-
    index(Jugada,0,X),
    index(Jugada,1,C_F),
    list_of_factories(Fabri),
    index(Fabri,X,Fabrica),
    index(C_F,0,C),
    index(C_F,1,Fila),
    cantidad_en_fabrica(Fabrica,C,Cant),
    ubica(Player,Fila,Cant,C,Fabrica).


ubica(Player,Fila,_,Color,Fabrica):-
    Fila == -1,!,
    estado_zona_final(Player,Z),
    RESTO is 7-Z,
    modifica_zona_final(Player,Fabrica,Color,RESTO)
    .

ubica(Player,Fila,Cant,Color,Fabrica):-
    estado_zona_preparacion(Player,A),
    index(A,Fila,F),
    index(F,1,Ubicados),
    index(F,2,Top),
    modifica_zona_preparacion(Player,Fila,Cant,Color,Fabrica,Ubicados,Top).

modifica_zona_final(_,[],_,_):-!.

modifica_zona_final(Player,[Color|R],Color,0):- !,
    modifica_tapa(Color,1),
    modifica_zona_final(Player,R,Color,0).

modifica_zona_final(Player,[Color|R],Color,Resto):-!,
    aumentar_zona_final(Player,1),
    Resto1 is Resto-1,
    aumenta_color_zona_final(Player,Color,1,_),
    modifica_zona_final(Player,R,Color,Resto1).

modifica_zona_final(Player,[X|R],Color,Resto):-
 %   modifica_centro_mesa(X,1),
    modifica_zona_final(Player,R,Color,Resto).

modifica_zona_preparacion(Player,Fila,Cant,Color,Fabrica,Ubicados,Top):-
    N is Top-Ubicados,
    nueva_zona_preparacion(Player,N,Fila,Color,Cant,Ubicados,R),
    modifica_tapa(Color,R)
    .
limpia_fabrica([],_):-!.
limpia_fabrica([Color|R],Color):-!,limpia_fabrica(R,Color).
limpia_fabrica([_|R],Color):- modifica_centro_mesa(Color,1),
    limpia_fabrica(R,Color)
.






























