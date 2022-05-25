:- [utils].

:- dynamic list/1.


% Se inicializo una lista se tamanno Size, con sus elementos Value
generated_list(0, Value, Value) :- !.

generated_list(Size, Value, [X|Y]) :-
    X = Value, 
    Size > 0, 
    Tmp is Size - 1,  
    generated_list(Tmp, Value, Y)
. 

list([  
    [blue, black, black, yellow], 
    [yellow, black, blue, black], 
    [blue, red, black, green], 
    [blue, black, red, green], 
    [red, green, red, red], 
    [blue, yellow, green, green], 
    [black, blue, black, red]
]).

list_number([
    1,2,3,4,5,6,7,8,9,0 % ,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
]).


selected_a_random_item_of_the_list(List, Lenght, Index, Element) :-
    Upper is Lenght + 1,
    generated_random(1, Upper, Index),
    indexed_in_the_list(List, Index, Element)
.  

indexed_in_the_list([Element|_], 1, Element).

indexed_in_the_list([_|Rest_of_the_list], Index, Element) :-
    indexed_in_the_list(Rest_of_the_list, New_Index, Element),
    Index is New_Index + 1
.  

removed_item_of_the_list([_|Rest_of_the_list], 1, Rest_of_the_list).

removed_item_of_the_list([First_element|Rest_of_the_list], Index, [First_element|Rest_of_the_resulting_list]) :-
    removed_item_of_the_list(Rest_of_the_list,New_Index,Rest_of_the_resulting_list),
    Index is New_Index + 1
.


length_of_the_list([_|[]], 1) :- !.

length_of_the_list([First_item|Rest_of_the_list], Lenght) :-
    length_of_the_list(Rest_of_the_list,Decreased_length),
    Lenght is Decreased_length + 1
.  
 
