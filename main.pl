
:- ['azulejos/azulejos_management',
    'pattern_lines/pattern_lines_management',
    'floor_lines/floor_lines_management',
    'initialization/game_initialization',
    'collections/collections_management',
    'factories/factories_management',
    'players/players_management',
    'scores/scores_management',
    'utils/utils_management',
    'walls/walls_management',
    'rounds/execute']
. 


% Relation between number of factories and players
number_of_factories_per_players(5, 2).
number_of_factories_per_players(7, 3).
number_of_factories_per_players(9, 4).


dictionary_of_id_chip(1, black).
dictionary_of_id_chip(2, red).
dictionary_of_id_chip(3, blue).
dictionary_of_id_chip(4, yellow).
dictionary_of_id_chip(5, green).


testing :-

    Players = [random,random,random,random],
    
    generate_players(Players),
    assert(number_of_players(4)),

    game_initialization(4)

. 
