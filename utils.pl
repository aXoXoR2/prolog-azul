
:- dynamic return/1.

return([]).


transducer(MetaPredicate, Transducer, Args) :-
    MetaPredicate_Transducer=..[Transducer, 
        MetaPredicate, MetaPredicate_Modificated,Args],
    call(MetaPredicate_Transducer),
    return(MetaPredicate_Modificated),
    
    Insert=..[return,[]],
    Remove=..[return,MetaPredicate_Modificated],
    
    assertz(Insert),
    retract(Remove),

    assertz(MetaPredicate_Modificated),
    retract(MetaPredicate), !
. 


% Type of Transducer
addition_transducer(MetaVariable, _, [Add]) :- 
    MetaVariable=..[Predicate,Value],
    Addition is Value + Add,
    MetaPredicate_Modificated=..[Predicate,Addition],
    
    Insert=..[return,MetaPredicate_Modificated],
    Remove=..[return,[]],
    
    assert(Insert),
    retract(Remove)
. 


addition(Variable, Value) :-
    T=..[Variable, _], 
    call(T), 
    transducer(T, addition_transducer, [Value])
. 

increase(Variable) :- 
    addition(Variable, 1)
. 

decrease(Predicate) :- 
    addition(Variable, -1)
.
% T=..[amount_of_black_chip_in_the_bag, X], call(T), transducer(T, addition, [56]), amount_of_black_chip_in_the_bag(Result).
