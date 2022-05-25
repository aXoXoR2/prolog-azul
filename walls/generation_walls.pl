:- [wall, '../lists/list'].


generated_walls(0) :- !.


generated_walls(Amount) :-
    
    generated_list(5, 0, Row),
    generated_list(5, Row, Wall),

    MetaPredicate=..[wall,Amount,Wall],
    asserta(MetaPredicate),

    New_amount is Amount - 1,
    generated_walls(New_amount)
. 
 