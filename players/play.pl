
:- [random_player/play, player_Db].


play(Id_player, Factory_index, Azulejos, Pattern_line_index) :-
    player(Id_player, Strategy),
    MetaStrategy=..[Strategy, Factory_index, Azulejos, Pattern_line_index],
    call(MetaStrategy)
. 
