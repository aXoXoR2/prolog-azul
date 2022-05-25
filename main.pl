
:- [utils, factory, board].


% Relation between number of factories and players
number_of_factories_per_players(5, 2).
number_of_factories_per_players(7, 3).
number_of_factories_per_players(9, 4).


dictionary_of_id_chip(1, black).
dictionary_of_id_chip(2, red).
dictionary_of_id_chip(3, blue).
dictionary_of_id_chip(4, yellow).
dictionary_of_id_chip(5, green).


% Variables
number_of_players(2).


generation_of_factories_tested(Amount) :-
    filled_factories(factories, number_of_factories, 
                    factories_generation_transducer, 
                    factories_were_generated_random, 
                    dictionary_of_id_chip, 
                    amount_of_chip_in_the_bag, Amount)
.  


selection_of_a_factory_randomly_tested(Item) :-    
    selected_a_random_factory(factories,
        number_of_factories,
        selected_a_random_factory_transducer,
        selected_a_random_item_of_the_list,
        removed_item_of_the_list, Item)
.   


master_tester :-
    generation_of_factories_tested(7),
    selection_of_a_factory_randomly_tested(Item1),
    selection_of_a_factory_randomly_tested(Item2),
    selection_of_a_factory_randomly_tested(Item3),
    selection_of_a_factory_randomly_tested(Item4),
    selection_of_a_factory_randomly_tested(Item5),
    selection_of_a_factory_randomly_tested(Item6),
    selection_of_a_factory_randomly_tested(Item7). 

