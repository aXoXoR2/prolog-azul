:- [score_Db].


generate_scores(0) :- !.

generate_scores(Amount) :-
    
    MetaPredicate=..[score, Amount, 0],
    asserta(MetaPredicate),

    New_amount is Amount - 1,
    generate_scores(New_amount)
. 
