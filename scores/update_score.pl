
:- ['../walls/wall_Db','../utils/utils', score_Db, calculate_score]. 


update_the_player_score(Id_player) :- 

    MetaPredicate=..[score,Id_player,_], 
    call(MetaPredicate), 
    
    transducer(MetaPredicate,addition_transducer,[])
. 

player_score_transducer(MetaPredicate, MetaPredicate_Modificated) :-

    MetaPredicate=..[score, Id_player, Score],

    calculate_player_score(Id_player, Current_score),

    New_score is Score + Current_score,
    MetaPredicate_Modificated=..[score, Id_player, New_score]
. 
