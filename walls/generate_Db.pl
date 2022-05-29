:- [wall_Db, '../collections/collections_management'].


generate_walls(0) :- !.


generate_walls(Amount) :-
    
    generate_list(5, 0, Row),
    generate_list(5, Row, Wall),

    MetaPredicate=..[wall,Amount,Wall],
    asserta(MetaPredicate),

    New_amount is Amount - 1,
    generate_walls(New_amount)
. 
 