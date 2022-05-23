:- [list, utils, main].

:-dynamic factories/1, number_of_factories/1.

% Variables
factories([]).
number_of_factories(0).


generated_factories(Number_of_Factories) :-
    generated_list(Number_of_Factories, [], List), 
    List was_assigned_to factories,
    number_of_factories was_increased_in Number_of_Factories
. 

filled_factories(Dictionary_of_chip) :- 
    not(there_were_factories)
. 

filled_factories(Dictionary_of_chip) :- 
    not(there_were_chips)
. 

filled_factories(Dictionary_of_chip) :- 
    there_were_factories,
    there_were_chips,
    filled_factory(Dictionary_of_chip),
    number_of_factories was_increased_in 1,
    filled_factories(Dictionary_of_chip), !
. 

there_were_factories.
there_were_chips.


filled_factory(Dictionary_of_chip).
there_are_chips :- true.


there_were_factories :- 
    number_of_factories(Current_amount_of_factories),
    number_of_players(Amount_of_players),
    number_of_factories_per_players(Amount_of_factories, Amount_of_players),
    Current_amount_of_factories < Amount_of_factories
.  

fill_factories(
    Amount_of_black_chip_in_the_bag,
    Amount_of_red_chip_in_the_bag,
    Amount_of_blue_chip_in_the_bag,
    Amount_of_yellow_chip_in_the_bag,
    Amount_of_green_chip_in_the_bag       
    ) :- 
        Amount_of_black_chip_in_the_bag is_zero,
        Amount_of_red_chip_in_the_bag is_zero,
        Amount_of_blue_chip_in_the_bag is_zero,
        Amount_of_yellow_chip_in_the_bag is_zero,
        Amount_of_green_chip_in_the_bag is_zero
        % rellena la bolsa
.   
