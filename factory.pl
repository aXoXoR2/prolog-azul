:- [utils, board, lists/list].


:-dynamic factories/1, number_of_factories/1.


% Variables
factories([]).
number_of_factories(0).







%%%%% FACTORIES GENERATION %%%%%  

factory_was_generated_random(_,_,[],0) :- !.


factory_was_generated_random(_,Dictionary_of_chip_amount,[],Amount_of_chip_in_Factory) :-
    Dictionary_of_chip_amount does_not_have_any_azulejos_available,
    Amount_of_chip_in_Factory = 0, !
. 


factory_was_generated_random(_,Dictionary_of_chip_amount,[],Amount_of_chip_in_Factory) :-
    Dictionary_of_chip_amount does_not_have_any_azulejos_available,
    Amount_of_chip_in_Factory \= 0, !
. 


factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, 
        Factory, Amount_of_chip_in_Factory
    ) :-

    Dictionary_of_chip_amount has _ available,
    generated_random(1, 6, Random),
    
    MetaVariable=..[Dictionary_of_id_chip, Random, Chip],
    call(MetaVariable),
    
    MetaPredicate=..[Dictionary_of_chip_amount, Chip, Amount_of_chip],
    call(MetaPredicate), Amount_of_chip > 0,

    transducer(MetaPredicate, addition_transducer, [-1]), 
    
    Tmp is Amount_of_chip_in_Factory - 1,  
    factory_was_generated_random(Dictionary_of_id_chip, 
        Dictionary_of_chip_amount, Rest_of_chips, Tmp),
    Factory = [Chip|Rest_of_chips], !
.   


factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, 
        Factory, Amount_of_chip_in_Factory
    ) :-

    factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, 
        Factory, Amount_of_chip_in_Factory)
.  


factories_were_generated_random(_,_, [], 0) :- !.


factories_were_generated_random(_,Dictionary_of_chip_amount,[],_) :-
    Dictionary_of_chip_amount does_not_have_any_azulejos_available
. 


factories_were_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, 
        Factories, Factories_are_missing_to_generate
    ) :-

    factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, Factory, 4),
    Factory \= [],
    Factories = [Factory|Rest_of_factories],

    Factories_were_generated is Factories_are_missing_to_generate - 1,
    factories_were_generated_random(Dictionary_of_id_chip, 
        Dictionary_of_chip_amount, Rest_of_factories, Factories_were_generated), !
.  


factories_generation_transducer(MetaPredicate_Factories, MetaPredicate_Factories_Modificated, 
        [Dictionary_of_id_chip, Dictionary_of_chip_amount, Number_of_Factories, Generator]
    ) :-
    
    MetaPredicate_Factories=..[Predicate, []],
    call(MetaPredicate_Factories),

    MetaPredicate_Generator=..[Generator, Dictionary_of_id_chip, Dictionary_of_chip_amount, 
        Factories_Generated, Number_of_Factories],
    call(MetaPredicate_Generator),
    
    MetaPredicate_Factories_Modificated=..[Predicate, Factories_Generated]
. 







%%%%%% FILLED FACTORIES %%%%%% 

filled_factories(Predicate_Factories, Predicate_Number_of_Factories, Transducer, 
        Generator, Dictionary_of_id_chip, Dictionary_of_chip_amount, Number_of_Factories
    ) :-
    
    MetaPredicate_Factories=..[Predicate_Factories, _],
    call(MetaPredicate_Factories),

    transducer(MetaPredicate_Factories, Transducer, [Dictionary_of_id_chip, 
        Dictionary_of_chip_amount, Number_of_Factories, Generator]),
    
    MetaPredicate_Factories_Modificated=..[Predicate_Factories, List_of_factories],
    call(MetaPredicate_Factories_Modificated),
    length_of_the_list(List_of_factories, Length),

    Length was_assigned_to Predicate_Number_of_Factories
.  








%%%%%% SELECTION OF A RANDOM FACTORY FACTORIES %%%%%% 

selected_a_random_factory_transducer(
        MetaPredicate_Factories, MetaPredicate_Factories_Modificated,
        [Select_a_random_item_of_the_list, Remove_an_item_of_the_list, 
        Predicate_Number_of_Factories, Item]
    ):-

    MetaPredicate_Factories=..[Factories, List], 
    call(MetaPredicate_Factories),

    MetaPredicate_Number_of_Factories=..[Predicate_Number_of_Factories, Value],
    call(MetaPredicate_Number_of_Factories),

    MetaPredicate_Select=..[Select_a_random_item_of_the_list, List, Value, Index, Item],
    call(MetaPredicate_Select),

    MetaPredicate_Remove=..[Remove_an_item_of_the_list, List, Index, Resulting_list],
    call(MetaPredicate_Remove),

    MetaPredicate_Factories_Modificated=..[Factories, Resulting_list],
    New_value is Value - 1,
    New_value was_assigned_to Predicate_Number_of_Factories
. 


selected_a_random_factory(Predicate_Factories, Predicate_Number_of_Factories, Transducer, 
        Select_a_random_item_of_the_list, Remove_an_item_of_the_list, Item
    ) :-

    MetaPredicate_Factories=..[Predicate_Factories,List],
    call(MetaPredicate_Factories),
    List \= [],

    transducer(MetaPredicate_Factories, Transducer, 
        [Select_a_random_item_of_the_list, Remove_an_item_of_the_list, 
        Predicate_Number_of_Factories, Item]), !
.  


selected_a_random_factory(Predicate_Factories, _, _, _, _, _) :-

    MetaPredicate_Factories=..[Predicate_Factories,List],
    call(MetaPredicate_Factories),
    List = [], !
.  

