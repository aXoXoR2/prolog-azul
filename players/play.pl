
:- [random_player/play, player_Db].


play(Id_player, Factory_index, Azulejos) :-
    player(Id_player, Strategy),
    MetaStrategy=..[Strategy, Factory_index, Azulejos],
    call(MetaStrategy)
. 
