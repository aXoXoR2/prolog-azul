:- [list].

:-dynamic factories/1, number_of_factories/1.

factories([]).
number_of_factories(0).

generated_factories(Number_of_Factories, List) :-
    generated_list(Number_of_Factories, [], List) 
. 

