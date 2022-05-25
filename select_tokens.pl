
:-[lists/list, factory, board, utils].

:- dynamic list_of_factories/1, amount_of_factories/1, jugada/3.


list_of_factories([  
    [blue, black, black, yellow], 
    [yellow, black, blue, black], 
    [blue, red, black, green], 
    [blue, black, red, green], 
    [red, green, red, red], 
    [blue, yellow, green, green], 
    [black, blue, black, red]
]).

amount_of_factories(7).


turno(Player,Fabricas_con_azulejos,Jugada):-
    length_mine(Fabricas_con_azulejos,N),
    N1 is N+1,
    random(0,N1,X),!,
    call(factories(X,F)),
    escoger_jugada_valida(F,Player,J),
    Jugada = [X,J]
   .
select_factory([],N,_,Correct):-random(0,N,X1),factories(X1,F),!,select_factory(F,N,X1,Correct),!.
select_factory([F|Resto],N,X,Correct):-Correct is X.

escoger_jugada_valida(T,Player,J):-
    escoger_color(T,P),
    cantidad_en_fabrica(T,P,X),
    X =\= 4,
    call(dictionary_colors(C,P)),
    call(estado_zona_preparacion(Player,A)),
    call(muro_del_jugador(Player,M)),
    %verificar si esa cantidad de colores se pueden poner en alguna fila de la zona de preparacion
    select_zona_preparacion(A,M,C,X,1,Fila),
    % si lo anterior devuelve -1 indica que deben ir a la zona final obligado
    Fila == -1,!,
    choose(A,M,C,X,1,Selection,Min),
    maxlista(Min,Minimo),
    searching(Minimo,Min,0,Pos),
    index(Selection,Pos,Fila_final),
    J = [C,Fila_final]
    .
escoger_jugada_valida(T,Player,J):-
    escoger_color(T,P),
    cantidad_en_fabrica(T,P,X),
    call(dictionary_colors(C,P)),
    call(estado_zona_preparacion(Player,A)),
    call(muro_del_jugador(Player,M)),
    %verificar si esa cantidad de colores se pueden poner en alguna fila de la zona de preparacion
    select_zona_preparacion(A,M,C,X,1,Fila),
    % si lo anterior devuelve -1 indica que deben ir a la zona final obligado
    J = [C,Fila].

choose([],[],_,_,_,[],[]):-!.
choose([A|R],[M|Resto],C,X,Count,[Selection|Y],[Min|Z]):-
    escoger_la_mejor_entre_las_peores(A,M,C,X,Count,Selection1,Min1),!,
    Selection is Selection1,
    Min is Min1,
    Count1 is Count +1,
    choose(R,Resto,C,X,Count1,Y,Z).
choose([A|R],[M|Resto],C,X,Count,[Selection|Y],[Min|Z]):-Count1 is Count+1,Selection is -1, Min is -40,choose(R,Resto,C,X,Count1,Y,Z).



escoger_la_mejor_entre_las_peores(A,_,C,X,Count,Selection,Min):-
    index(A,0,Color),
    Color==C,
    index(A,1,Cant),
    Aux is Count-1,
    Min is Count-Cant+X,
    Selection is Aux.

escoger_la_mejor_entre_las_peores(A,M,C,X,Count,Selection,Min):-
    index(A,0,Color),
    Color==0,
    call(wall(W)),
    Aux is Count-1,
    index(W,Aux,F),
    searching(C,F,0,Pos),
    index(M,Pos,Valid),
    Valid ==0,
    Min is Count-X,
    Selection is Aux .

select_zona_preparacion([],[],_,_,_,Fila):-Fila is -1,!.
select_zona_preparacion([A|_],_,C,X,Count,Fila):-index(A,0,Color),
    Color==C,
    index(A,1,Cant),
    Count>=X+Cant,
    Aux is Count-1,
    Fila is Aux.
select_zona_preparacion([A|_],[M|_],C,X,Count,Fila):-index(A,0,Color),
    Color==0,
    Count>=X,
    call(wall(W)),
    Aux is Count-1,
    index(W,Aux,F),
    searching(C,F,0,Pos),
    index(M,Pos,Valid),
    Valid ==0,!,
    Fila is Aux.
select_zona_preparacion([_|Rest],[_|R],C,X,Count,Fila):-C1 is Count+1,
    select_zona_preparacion(Rest,R,C,X,C1,Fila).

cantidad_en_fabrica([],_,X):-X is 0,!.
cantidad_en_fabrica([P|Resto],P,X):-!,cantidad_en_fabrica(Resto,P,X1),X is X1+1.
cantidad_en_fabrica([_|Resto],P,X):-cantidad_en_fabrica(Resto,P,X).


escoger_color(T,P):-random(0,4,X),
   index(T,X,C),P = C.