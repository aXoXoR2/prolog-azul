
generated_tokens(s).
generated_tables(s).
generated_factories(s).


initialized_game(Number_of_Factories, Number_of_Players) :- 
       generated_tables(Number_of_Players),
       generated_factories(Number_of_Factories)           
. 



