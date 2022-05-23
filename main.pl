
:- import(inicialization).
:- dynamic initialized_game/2.


% Relation between number of factories and players
number_of_factories_per_players(5, 2).
number_of_factories_per_players(7, 3).
number_of_factories_per_players(9, 4).


selected_tokens.
covered_wall.
maintenance_was_done.
finished.
stack_of_chips_is_empty.


finished_game :-
       stack_of_chips_is_empty 
. 

finished_game :-
    selected_tokens,
    covered_wall,
    maintenance_was_done,
    finished_game
. 

game_worked_correctly(Number_of_Players) :-
    number_of_factories_per_players(Number_of_Factories, Number_of_Players), 
    initialized_game(Number_of_Factories, Number_of_Players),
    finished_game
. 

