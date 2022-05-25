:- [utils].

:- dynamic amount_of_chip_in_the_bag/2, box_cover/2, center_of_the_table/2.



% Variables
amount_of_chip_in_the_bag(red, 20).
amount_of_chip_in_the_bag(blue, 20).
amount_of_chip_in_the_bag(green, 20).
amount_of_chip_in_the_bag(black, 20).
amount_of_chip_in_the_bag(yellow, 20).



box_cover(red, 0).
box_cover(blue, 0).
box_cover(green, 0).
box_cover(black, 0).
box_cover(yellow, 0).



center_of_the_table(red, 0).
center_of_the_table(blue, 0).
center_of_the_table(green, 0).
center_of_the_table(black, 0).
center_of_the_table(yellow, 0).



%%%%% OPERATORS %%%%%

:-op(100, xf, []).
:-op(150, xfx, [to_the, from_the]).
:-op(150, xfy, [of]).
:-op(150, fy, [add, get]).


add Azulejos to_the Predicate :-
    Azulejos = [Azulejo|Rest_of_azulejos],
    add_azulejos(Predicate, [Azulejo|Rest_of_azulejos])
.    

get Amount of Azulejo from_the Predicate :-
    get_all_azulejos(Predicate, Azulejo, Amount)
. 


add_azulejos(_,[]) :- !.


add_azulejos(Predicate, [Azulejo|Rest_of_azulejos]):-
    addition(Predicate, Azulejo, 1),
    add_azulejos(Predicate, Rest_of_azulejos)
.  

get_all_azulejos(Predicate, Azulejo, Amount):-
    Predicate has Azulejo available,

    MetaPredicate=..[Predicate,Azulejo,Amount], 
    call(MetaPredicate),

    addition(Predicate, Azulejo, -Amount), !
. 

get_all_azulejos(Predicate, Azulejo, Amount):-
    Predicate does_not_have Azulejo available,
    Amount = 0
.  

