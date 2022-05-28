
% :- dynamic return/1.

% return([]).

% Insert=..[return,MetaPredicate_Modificated],
% Remove=..[return,[]],

% assert(Insert),
% retract(Remove)


:-op(350, xfx, [was_assigned_to, was_increased_in, was_equal_to]).
:-op(100, xf, [is_zero, available, does_not_have_any_azulejos_available]).
:-op(150, xfy, [has, does_not_have]).


Value was_assigned_to Variable :- 
    assignment(Variable, Value) 
. 

Variable was_increased_in Add :- 
    addition(Variable, Add)
. 

Variable is_zero :- 
    MetaVariable=..[Variable, Value], 
    call(MetaVariable), Value = 0
. 

Variable was_equal_to Value :- 
    MetaVariable=..[Variable, Value],
    call(MetaVariable)
.

Dictionary has Azulejos available :-
    MetaPredicate=..[Dictionary, Azulejos, Value],
    call(MetaPredicate),
    Value > 0, !
. 

Dictionary does_not_have Azulejos available :-
    not(Dictionary has Azulejos available)
. 

Dictionary does_not_have_any_azulejos_available :-
    Dictionary does_not_have _ available
. 

transducer(MetaPredicate, Transducer, Args) :-
    MetaPredicate_Transducer=..[Transducer, 
        MetaPredicate, MetaPredicate_Modificated,Args],    
    call(MetaPredicate_Transducer),

    assertz(MetaPredicate_Modificated),
    retract(MetaPredicate), !
. 

% Type of Transducer
addition_transducer(MetaPredicate, MetaPredicate_Modificated, [Add]) :- 
    MetaPredicate=..[Predicate, Variable, Value],
    Addition is Value + Add,
    MetaPredicate_Modificated=..[Predicate, Variable, Addition]
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

addition(Predicate, Key, Add) :-
    MetaPredicate=..[Predicate,Key,_], 
    call(MetaPredicate), 
    transducer(MetaPredicate,addition_transducer,[Add])
.   

generated_random(L, U, X):-
    random(L, U, X), !
. 
        
generated_random(L, U, X) :- 
    generated_random(L, U, X)
.     




index([X|_],0,X):-!.
index([_|R],N,X):- N1 is N - 1,
    index(R,N1,X).

searching(X,[X|_],Count,Pos):-!,Pos is Count.
searching(X,[_|R],Count,Pos):-Count1 is Count+1,searching(X,R,Count1,Pos).

maxlista([X],X):-!.
maxlista([X|T],N):- maxlista(T,N1),max(N1,X,N).

max(X,Y,X):- X>Y,!.
max(X,Y,Y):-X=<Y.

length_mine([_],N):-N1 is N, N is N1+1,!.
length_mine([_|R],N):-length_mine(R,N1),N is N1+1.

