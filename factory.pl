:- [utils, board].

:-dynamic factories/1, number_of_factories/1.


% Variables
factories([]).
number_of_factories(0).

factory_was_generated_random(_,_,[],0) :- !.

factory_was_generated_random(_,Dictionary_of_chip_amount,_,_) :-
    Dictionary_of_chip_amount does_not_have_any_chips_available, !
. 

factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, Factory, Amount_of_chip_in_Factory) :-
    
    Dictionary_of_chip_amount has_chips_available,
    generated_random(1, 6, Random),
    
    MetaVariable=..[Dictionary_of_id_chip, Random, Chip],
    call(MetaVariable),

    Factory = [Chip|Rest_of_chips],
    
    MetaPredicate=..[Dictionary_of_chip_amount, Chip, Amount_of_chip],
    call(MetaPredicate), Amount_of_chip > 0,
    transducer(MetaPredicate, addition_transducer, [-1]), 
    
    Tmp is Amount_of_chip_in_Factory - 1,
    factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, Rest_of_chips, Tmp),
    !
.   

% :- trace(factory_was_generated_random).


factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, Factory, Amount_of_chip_in_Factory) :-
    
    factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, Factory, Amount_of_chip_in_Factory)

.  

factories_were_generated_random(_,_, [], 0) :- !.

factories_were_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, Factories, Factories_are_missing_to_generate) :-

    Factories = [Factory|Rest_of_factories],
    factory_was_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, Factory, 4),
 
    Tmp is Factories_are_missing_to_generate - 1,
    factories_were_generated_random(Dictionary_of_id_chip, Dictionary_of_chip_amount, Rest_of_factories, Tmp)

.  

generated_random(L, U, X):-
    random(L, U, X), !
. 
    
generated_random(L, U, X) :- 
    generated_random(L, U, X)
.  


factories_generation_transducer(MetaPredicate_Factories, MetaPredicate_Factories_Modificated, 
        [Dictionary_of_id_chip, Dictionary_of_chip_amount, Number_of_Factories, Generator]) :-
    
    MetaPredicate_Factories=..[Predicate, []],
    call(MetaPredicate_Factories),

    MetaPredicate_Generator=..[Generator, Dictionary_of_id_chip, Dictionary_of_chip_amount, Factories_Generated, Number_of_Factories],
    call(MetaPredicate_Generator),
    
    MetaPredicate_Factories_Modificated=..[Predicate, Factories_Generated]
. 


filled_factories([Predicate_Factories, Predicate_Number_of_Factories], Transducer, Generator, Dictionary_of_id_chip, Dictionary_of_chip_amount, Number_of_Factories) :-

    MetaPredicate_Factories=..[Predicate_Factories,_],
    call(MetaPredicate_Factories),

    transducer(MetaPredicate_Factories, Transducer, [Dictionary_of_id_chip, 
        Dictionary_of_chip_amount, Number_of_Factories, Generator]),

    Number_of_Factories was_assigned_to Predicate_Number_of_Factories
.  






% decrease_chips(Dictionary_of_chip_amount, []).

% decrease_chips(Dictionary_of_chip_amount, [Chip|Rest_of_chips]) :-
    
%     MetaPredicate=..[Dictionary_of_chip_amount,Chip,Amount],
%     call(MetaPredicate),
%     transducer(MetaPredicate, addition_transducer, [-1]), 
%     decrease_chips(Dictionary_of_chip_amount,Rest_of_chips), 
%     !
% . 