
:- ['../collections/collections_management',
    '../utils/utils', factory_Db]
. 


%%%%%%  

generate_factories(Bag) :-
    
    % se construye el metapredicado `factories` y se instancia
    MetaPredicate_factories=..[factories, _],
    call(MetaPredicate_factories),

    % se construye el metapredicado `number_of_factories_per_players` \
    % para saber la cantidad de fabricas que se necesitan construir
    MetaPredicate_number_of_players=..[number_of_players, Number_of_players],
    call(MetaPredicate_number_of_players),
    MetaPredicate_number_of_factories_per_players=..[number_of_factories_per_players, 
        Number_of_factories, Number_of_players],
    call(MetaPredicate_number_of_factories_per_players),

    transducer(MetaPredicate_factories, factory_generation_transducer,
        [Bag, Number_of_factories]),

    % se calcula la cantidad de fabricas que se construyeron, y se \
    % actualiza  el predicado `number_of_factories`
    MetaPredicate_factories_modificated=..[factories, List_of_factories],
    call(MetaPredicate_factories_modificated),
    length_of_the_list(List_of_factories, Length),

    Length was_assigned_to number_of_factories
.  


%%%%%

factory_generation_transducer(MetaPredicate_Factories, 
        MetaPredicate_Factories_Modificated, 
        [Bag, Number_of_Factories]
    ) :-
    
    MetaPredicate_Factories=..[factories, []],
    call(MetaPredicate_Factories),

    MetaPredicate_factories_were_generated_random=..[
        factories_were_generated_random, Bag, 
        Generated_factories, Number_of_Factories],
    call(MetaPredicate_factories_were_generated_random),
    
    MetaPredicate_Factories_Modificated=..[factories, Generated_factories]
. 


%%%%% 

factories_were_generated_random(_, [], 0) :- !.

factories_were_generated_random(Bag,[],_) :-
   
    Bag does_not_have_any_azulejos_available
. 

factories_were_generated_random(Bag, Factories, 
        Factories_are_missing_to_generate
    ) :-

    factory_was_generated_random(Bag, Factory, 4),
    Factory \= [],
    Factories = [Factory|Rest_of_factories],

    Factories_were_generated is Factories_are_missing_to_generate - 1,
    factories_were_generated_random(Bag, Rest_of_factories, 
        Factories_were_generated), !
.  


%%%%% FACTORIES GENERATION %%%%%  

factory_was_generated_random(_,[],0) :- !.

factory_was_generated_random(Bag,[],Amount_of_chip_in_Factory) :-
    
    Bag does_not_have_any_azulejos_available,
    Amount_of_chip_in_Factory = 0, !
. 

factory_was_generated_random(Bag,[],Amount_of_chip_in_Factory) :-
    
    Bag does_not_have_any_azulejos_available,
    Amount_of_chip_in_Factory \= 0, !
. 

factory_was_generated_random(Bag, Factory, Amount_of_chip_in_Factory) :-

    Bag has _ available,
    generated_random(1, 6, Random),
    
    MetaVariable=..[dictionary_of_id_chip, Random, Chip],
    call(MetaVariable),
    
    MetaPredicate=..[Bag, Chip, Amount_of_chip],
    call(MetaPredicate), Amount_of_chip > 0,

    transducer(MetaPredicate, addition_transducer, [-1]), 
    
    Tmp is Amount_of_chip_in_Factory - 1,  
    factory_was_generated_random(Bag, Rest_of_chips, Tmp),
    Factory = [Chip|Rest_of_chips], !
.   

factory_was_generated_random(Bag, Factory, Amount_of_chip_in_Factory) :-

    factory_was_generated_random(Bag, Factory, Amount_of_chip_in_Factory)
.  
