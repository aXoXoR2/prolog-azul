
% :- dynamic return/1.

% return([]).

% Insert=..[return,MetaPredicate_Modificated],
% Remove=..[return,[]],

% assert(Insert),
% retract(Remove)


:-op(350, xfx, [was_assigned_to]).
:-op(350, xfx, [was_increased_in]).
:-op(100, xf, [is_zero]).
:-op(100, xfx, [was_equal_to]).


Value was_assigned_to Variable :- 
    assignment(Variable, Value) 
. 

Variable was_increased_in Add :- 
    addition(Variable, Add)
. 

Variable is_zero :- 
    MetaVariable=..[Variable, Value], 
    call(T), Value = 0
. 

Variable was_equal_to Value :- 
    MetaVariable=..[Variable, Value],
    call(MetaVariable)
.

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

assignment(Variable, Value) :-
    Insert=..[Variable, Value],
    Remove=..[Variable,_],
    call(Remove),
    assertz(Insert),
    retract(Remove)
.   

addition(Variable, Add) :-
    MetaVariable=..[Variable, Current_Value], 
    call(MetaVariable),
    Addition is Current_Value + Add, 
    Addition was_assigned_to Variable
. 
