
:- ['../factories/factories_management', 
    '../players/players_management',
    '../azulejos/azulejos_management']
. 


execute_turn(Id_player) :-
    factories(Factories),
    Factories \= [],

    play(Id_player, Factory_index, Azulejo),

    get_all_items_of_the_list(Factory_index, Azulejo, 
        Azulejos, Rest_of_the_azulejos),

    add_azulejos(center_of_the_table, Rest_of_azulejos),



    number_of_players(Number_of_players),
    Id_next_player is (Id_player + 1) mod Number_of_players,

    execute_turn(Id_next_player)
. 
