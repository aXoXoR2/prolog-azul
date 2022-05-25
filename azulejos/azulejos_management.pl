:- [add_azulejos, get_azulejos, center_of_the_table, box_cover, bag]. 


:-op(150, xfx, [from_the, to_the]).
:-op(150, xfy, [of]).
:-op(150, fy, [add, get]).


add Azulejos to_the Predicate :-
    Azulejos = [Azulejo|Rest_of_azulejos],
    add_azulejos(Predicate, [Azulejo|Rest_of_azulejos])
.    


get Amount of Azulejo from_the Predicate :-
    get_all_azulejos(Predicate, Azulejo, Amount)
. 
