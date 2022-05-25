:- [utils].


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
