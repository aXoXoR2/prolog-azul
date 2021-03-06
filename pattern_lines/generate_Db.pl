
:- [pattern_line_Db, '../collections/collections_management'].


generate_pattern_lines(0) :- !.

generate_pattern_lines(Amount) :-
    
    Pattern_line = [[empty,0,1],
                    [empty,0,2],
                    [empty,0,3],
                    [empty,0,4],
                    [empty,0,5]],

    MetaPredicate=..[pattern_line, Amount, Pattern_line],
    asserta(MetaPredicate),

    New_amount is Amount - 1,
    generate_pattern_lines(New_amount)
. 
