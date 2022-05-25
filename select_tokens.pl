
:-[list].

:- dynamic list_of_factories/1, amount_of_factories/1.

list_of_factories([  
    [blue, black, black, yellow], 
    [yellow, black, blue, black], 
    [blue, red, black, green], 
    [blue, black, red, green], 
    [red, green, red, red], 
    [blue, yellow, green, green], 
    [black, blue, black, red]
]).

amount_of_factories(7).

