
:- ['../collections/collections_management',
    '../walls/walls_management']
. 


is_a_valid_move(Azulejo,[[Azulejo,Amount,Top]|_],_) :-
    
    Amount \= Top, !
. 

is_a_valid_move(Azulejo,[[empty,_,Top]|_],Wall):- 

    Row_index is Top - 1,
    wall(Tiled_wall),
    index_in_the_list(Tiled_wall, Row_index, Row),
    index_in_the_list(Row, Col_index, Azulejo),

    index_in_the_matrix(Wall, Row_index, Col_index, 0), !
. 

is_a_valid_move(Azulejo,[_|Rest_of_the_pattern_lines],
    Wall):- 
    
    Rest_of_the_pattern_lines \= [],

    is_a_valid_move(Azulejo,Rest_of_the_pattern_lines,
    Wall), !
. 
