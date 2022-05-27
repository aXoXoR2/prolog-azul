
:- ['../walls/wall_Db', '../pattern_lines/pattern_line_Db',
    '../collections/collection_management',
    '../floor_lines/floor_line_Db', score_Db]
. 


%!!!!!!!

calculate_player_score(Id_player, Score) :-
    
    wall(Id_player, Wall),
    pattern_line(Id_player, Pattern_line),
    
    calculates_the_score_of_the_pattern_line(Wall, 
        Pattern_line, Pattern_line_score),
    
    floor_line(Id_player, Amount_of_azulejos_on_the_floor_line),
    floor_line(Floor_line),

    Tmp is Amount_of_azulejos_on_the_floor_line - 1,
    indexed_in_the_list(Floor_line, Tmp, Penalty),

    Score is Pattern_line_score - Penalty
.  


% !!!!!!!

calculates_the_score_of_the_pattern_line(Wall, 
        [Pattern_line|[]], Score) :- 
    
    calculates_the_score_of_a_row_of_the_pattern_line(
        Wall, Pattern_line, Score
    ), !
. 

calculates_the_score_of_the_pattern_line(Wall, [Pattern_line|Rest_of_the_pattern_lines], Score) :-
    
    calculates_the_score_of_the_pattern_line(Wall, Rest_of_the_pattern_lines, Previous_score),

    calculates_the_score_of_a_row_of_the_pattern_line(Wall, Pattern_line, Current_score),

    Score is Current_score + Previous_score
. 


% !!!!!!!!

calculates_the_score_of_a_row_of_the_pattern_line(Wall, Pattern_line, Amount_of_adjacents) :-
     
    Pattern_line = [Color, Top, Top], 
    
    Row_index is Top - 1,
    wall(Tiled_wall),
    indexed_in_the_list(Tiled_wall, Row_index, Row),
    indexed_in_the_list(Row, Col_index, Color),
    % write('siiii'),

    move_next(Row_index, Col_index, Row_index_right, Col_index_right, right),
    go_as_far_as_you_can(Wall, Row_index_right, Col_index_right, right, Amount_right),

    move_next(Row_index, Col_index, Row_index_left, Col_index_left, left),
    go_as_far_as_you_can(Wall, Row_index_left, Col_index_left, left, Amount_left),

    Amount_moving_horizontally is Amount_right + Amount_left,

    move_next(Row_index, Col_index, Row_index_up, Col_index_up, up),
    go_as_far_as_you_can(Wall, Row_index_up, Col_index_up, up, Amount_up),
    
    move_next(Row_index, Col_index, Row_index_down, Col_index_down, down),
    go_as_far_as_you_can(Wall, Row_index_down, Col_index_down, down, Amount_down),

    Amount_moving_vertically is Amount_up + Amount_down,

    calculate_adjacents(Amount_moving_horizontally, Amount_moving_vertically, Amount_of_adjacents)
.  

calculates_the_score_of_a_row_of_the_pattern_line(Wall, Pattern_line, Amount_of_adjacents) :-
    
    Pattern_line = [Color, Amount, Top], 
    
    Amount \= Top, Amount_of_adjacents = 0
. 


% !!!!!!!!

go_as_far_as_you_can(Wall, Row_i, Col_j, _, Amount_in_line) :- 
  
    not(is_valid(Wall, Row_i, Col_j)),

    Amount_in_line = 0, !
. 

go_as_far_as_you_can(Wall, Row_i, Col_j, _, Amount_in_line) :-
    
    index_in_the_matrix(Wall, Row_i, Col_j, 0),

    Amount_in_line = 0, !
. 

go_as_far_as_you_can(Wall, Row_i, Col_j, Direction, Amount_in_line) :-
    
    index_in_the_matrix(Wall, Row_i, Col_j, 1),

    move_next(Row_i, Col_j, Next_row_i, Next_col_j, Direction),
    go_as_far_as_you_can(Wall, Next_row_i, Next_col_j, Direction, New_amount_in_line),

    Amount_in_line is New_amount_in_line + 1, !
. 


% calculate the number of adjacent in line

calculate_adjacents(Amount_moving_horizontally, Amount_moving_vertically, Amount_of_adjacents) :-
    
    Amount_moving_horizontally \= 0, Amount_moving_vertically \= 0,

    Amount_of_adjacents is Amount_moving_horizontally + Amount_moving_vertically + 2, !
. 

calculate_adjacents(Amount_moving_horizontally, Amount_moving_vertically, Amount_of_adjacents) :-

    Amount_of_adjacents is Amount_moving_horizontally + Amount_moving_vertically + 1, !
. 






% [[0,0,0,0,0],
%  [0,0,0,0,0],
%  [0,0,0,0,0],
%  [0,0,0,0,0],
%  [0,0,0,0,0]]

% [
% [0,0,0,0,0,0,0,0,0,0,0,0,0],
% [0,0,0,0,0,0,0,0,0,0,0,0,0],
% [0,0,0,0,0,0,1,0,0,0,0,0,0],
% [0,0,0,0,0,0,1,0,0,0,0,0,0],
% [0,0,0,0,0,0,1,0,0,0,0,0,0],
% [0,0,0,0,1,1,0,1,1,1,1,1,1],
% [0,0,0,0,0,0,1,0,0,0,0,0,0],
% [0,0,0,0,0,0,1,0,0,0,0,0,0],
% [0,0,0,0,0,0,1,0,0,0,0,0,0],
% [0,0,0,0,0,0,1,0,0,0,0,0,0],
% [0,0,0,0,0,0,1,0,0,0,0,0,0],
% [0,0,0,0,0,0,0,0,0,0,0,0,0],
% [0,0,0,0,0,0,0,0,0,0,0,0,0],
% ]


% testing_pattern_line([[0,1,1,0,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0,0,0,0,0,0],[1,0,0,0,0,0,1,0,0,0,0,0,0],[1,0,0,0,0,0,1,0,0,0,0,0,0],[0,0,0,0,0,0,1,0,0,0,0,0,0],[0,0,0,0,1,1,0,1,1,1,1,1,1],[0,0,0,0,0,0,1,0,0,0,0,0,0],[0,0,0,0,0,0,1,0,0,0,0,0,0],[0,0,0,0,0,0,1,0,0,0,0,0,0],[0,0,0,0,0,0,1,0,0,0,0,0,0],[0,0,0,0,0,0,1,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0]],5,6, Amount), Amount = 18. 


% testing(Score) :-
    
%     Wall = [
%         [0,0,1,0,0],
%         [0,0,1,0,0],
%         [1,1,0,1,1],
%         [0,0,1,0,0],
%         [0,0,1,0,0]
%     ],
    
%     Pattern_line = [
%         [yellow,1,1],
%         [black,1,2],
%         [blue,3,3],
%         [empty,0,4],
%         [yellow,5,5]
%     ],
    
%     calculates_the_score_of_the_pattern_line(Wall, 
%         Pattern_line, Pattern_line_score),
%     write('-------------------------------------------------------Pattern_line_score-------------------------------------------------------  '),
%     write(Pattern_line_score),
%     write('    -------------------------------------------------------Pattern_line_score-------------------------------------------------------  '),
    
%     Amount_of_azulejos_on_the_floor_line = 3,
%     floor_line(Floor_line),

%     Tmp is Amount_of_azulejos_on_the_floor_line - 1,
%     indexed_in_the_list(Floor_line, Tmp, Penalty),

%     Score is Pattern_line_score + Penalty
% .  


% testing(Current_score) :-
%     Wall = [
%         [0,0,1,0,0],
%         [0,0,1,0,0],
%         [1,1,0,1,1],
%         [0,0,1,0,0],
%         [0,0,1,0,0]
%     ],
    
%     Pattern_line = [yellow,1,1],
%     calculates_the_score_of_a_row_of_the_pattern_line(Wall, Pattern_line, Current_score)
% . 


% :- trace(is_valid).
% :- trace(testing).
% :- trace(calculate_adjacents).
% :- trace(move_next).
% :- trace(is_previous).
% :- trace(index_in_the_matrix).
% :- trace(go_as_far_as_you_can).
% :- trace(calculates_the_score_of_the_pattern_line).
% :- trace(calculates_the_score_of_a_row_of_the_pattern_line).



% testing_pattern_line(Wall, Row_index, Col_index, Amount_of_adjacents) :-

%     move_next(Row_index, Col_index, Row_index_right, Col_index_right, right),
%     go_as_far_as_you_can(Wall, Row_index_right, Col_index_right, right, Amount_right),

%     move_next(Row_index, Col_index, Row_index_left, Col_index_left, left),
%     go_as_far_as_you_can(Wall, Row_index_left, Col_index_left, left, Amount_left),

%     Amount_moving_horizontally is Amount_right + Amount_left,

%     move_next(Row_index, Col_index, Row_index_up, Col_index_up, up),
%     go_as_far_as_you_can(Wall, Row_index_up, Col_index_up, up, Amount_up),
    
%     move_next(Row_index, Col_index, Row_index_down, Col_index_down, down),
%     go_as_far_as_you_can(Wall, Row_index_down, Col_index_down, down, Amount_down),

%     Amount_moving_vertically is Amount_up + Amount_down,

%     calculate_adjacents(Amount_moving_horizontally, Amount_moving_vertically, Amount_of_adjacents)


% %   calcula el score de las fila llena
% %       recorrer el Pattern Line y toma es que este lleno
% %           busca su posicion en el Wall
% %           busca los adyacentes en fila y columna
% %           
% .  