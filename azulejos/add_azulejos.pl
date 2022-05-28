:- ['../utils/utils'].


add_azulejos(_,[]) :- !.


add_azulejos(Predicate, [Azulejo|Rest_of_azulejos]):-
    addition(Predicate, Azulejo, 1),
    add_azulejos(Predicate, Rest_of_azulejos)
. 
