:- [score_Db].


generated_scores(0) :- !.


generated_scores(Amount) :-
    
    MetaPredicate=..[score, Amount, 0],
    asserta(MetaPredicate),

    New_amount is Amount - 1,
    generated_scores(New_amount)
. 
