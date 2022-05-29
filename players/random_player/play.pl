
:- ['../../pattern_lines/pattern_lines_management',
    '../../collections/collections_management',
    '../../walls/walls_management',
    '../../factories/factory_Db',
    '../valid_move']
. 


:- dynamic factories_mask/1.


random_player_movement(Id_player, Factory_index, Azulejo) :-
    
    factories(Factories),
    number_of_factories(Number_of_factories),
    
    select_a_random_item_of_the_list(Factories, 
        Number_of_factories, Factory_index, Factory),

    select_a_random_item_of_the_list(Factory, 4, _, 
        Azulejo),

    pattern_line(Id_player, Pattern_line),
    wall(Id_player, Wall),

    is_a_valid_move(Azulejo, Pattern_line, Wall)
. 

random_player_movement(Id_player, Factory_index, Azulejo) :-
    
    factories(Factories),
    number_of_factories(Number_of_factories),

    select_a_random_item_of_the_list(Factories, 
        Number_of_factories, Factory_index, Factory),

    select_a_random_item_of_the_list(Factory, 4, 
        Azulejo_index, Azulejo),

    pattern_line(Id_player, Pattern_line),
    wall(Id_player, Wall),

    not(is_a_valid_move(Azulejo, Pattern_line, Wall)),

    factories_mask(Factories_mask),

    assign_into_matrix(Factories_mask, Modified_factories_mask, 
        Factory_index, Azulejo_index, 1),

    retractall(factories_mask),
    assert(factories_mask(Modified_factories_mask))
. 


generate_mask :- 

    number_of_factories(Number_of_factories),

    generate_list(4, 0, Factory),
    generate_list(Number_of_factories, Factory, Factories_mask),

    assert(factories_mask(Factories_mask))
. 
