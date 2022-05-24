
:- [utils].


:- dynamic 
    initialized_game/2, 
    number_of_players/1
.

% Relation between number of factories and players
number_of_factories_per_players(5, 2).
number_of_factories_per_players(7, 3).
number_of_factories_per_players(9, 4).


dictionary_of_chip(1, black).
dictionary_of_chip(2, red).
dictionary_of_chip(3, blue).
dictionary_of_chip(4, yellow).
dictionary_of_chip(5, green).


% Variables
number_of_players(2).


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
    Number_of_Players was_assigned_to number_of_players,
    initialized_game(Number_of_Factories, Number_of_Players),
    finished_game
. 
