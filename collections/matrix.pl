:- [list].


index_in_the_matrix(Matrix, Row, Col, Item) :-
    indexed_in_the_list(Matrix, Row, X),
    indexed_in_the_list(X, Col, Item)
. 


is_previous(Matrix, Row, Col, Row, Col, _) :- !.


is_previous(Matrix, Row, Col, Row_i, Col_j, Direction) :-

    move_next(Previous_row_i, Previous_col_j, Row_i, Col_j, Direction),

    is_valid(Matrix, Previous_row_i, Previous_col_j),

    is_previous(Matrix, Row, Col, Previous_row_i, Previous_col_j, Direction)

.  


move_next(Row, Col, Row, Col_j, right) :-
    nonvar(Col_j), Col is Col_j - 1, !
. 

move_next(Row, Col, Row, Col_j, right) :-
    nonvar(Col), Col_j is Col + 1, !
. 


move_next(Row, Col, Row, Col_j, left) :-
    nonvar(Col_j), Col is Col_j + 1, !
. 

move_next(Row, Col, Row, Col_j, left) :-
    nonvar(Col), Col_j is Col - 1, !
. 


move_next(Row, Col, Row_i, Col, up) :-
    nonvar(Row_i), Row is Row_i + 1, !
. 

move_next(Row, Col, Row_i, Col, up) :-
    nonvar(Row), Row_i is Row - 1, !
. 


move_next(Row, Col, Row_i, Col, down) :-
    nonvar(Row_i), Row is Row_i - 1, !
. 

move_next(Row, Col, Row_i, Col, down) :-
    nonvar(Row), Row_i is Row + 1, !
. 



is_valid(Matrix, Row, Col) :-
    Row >= 0, Col >= 0,

    length_of_the_list(Matrix, Amount_of_rows),

    Matrix = [First_row|_],
    length_of_the_list(First_row, Amount_of_cols),

    Row < Amount_of_rows, Col < Amount_of_cols
. 
