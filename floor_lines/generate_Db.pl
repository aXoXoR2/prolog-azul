
:- [floor_line_Db].


generate_floor_lines(0) :- !.

generate_floor_lines(Amount) :-
    
    MetaPredicate=..[floor_line, Amount, 0],
    asserta(MetaPredicate),

    New_amount is Amount - 1,
    generate_floor_lines(New_amount)
. 
