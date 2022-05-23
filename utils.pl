
% :- dynamic return/1.

% return([]).

% Insert=..[return,MetaPredicate_Modificated],
% Remove=..[return,[]],

% assert(Insert),
% retract(Remove)


transducer(MetaPredicate, Transducer, Args) :-
    MetaPredicate_Transducer=..[Transducer, 
        MetaPredicate, MetaPredicate_Modificated,Args],    
    call(MetaPredicate_Transducer),

    assertz(MetaPredicate_Modificated),
    retract(MetaPredicate), !
. 


% Type of Transducer
addition_transducer(MetaVariable, MetaPredicate_Modificated, [Add]) :- 
    MetaVariable=..[Predicate,Value],
    Addition is Value + Add,
    MetaPredicate_Modificated=..[Predicate,Addition]
. 


addition(Variable, Value) :-
    T=..[Variable, _], 
    call(T), 
    transducer(T, addition_transducer, [Value])
. 

% increase(Variable) :- 
%     addition(Variable, 1)
% . 

% decrease(Variable) :- 
%     addition(Variable, -1)
% . 
