
:- ['../utils/utils'].

:- dynamic list/1.


% Se inicializo una lista se tamanno Size, con sus elementos Value
generate_list(0, _, []) :- !.

generate_list(Amount, Value, [Value | Rest_of_the_list]) :-

    Tmp is Amount - 1,  
    generate_list(Tmp, Value, Rest_of_the_list)
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


select_a_random_item_of_the_list(List, Lenght, Index, Element) :-

    generated_random(0, Lenght, Index),
    index_in_the_list(List, Index, Element)
.  


index_in_the_list([Element|_], 0, Element).

index_in_the_list([_|Rest_of_the_list], Index, Element) :-

    index_in_the_list(Rest_of_the_list, New_Index, Element),
    Index is New_Index + 1
.  


remove_this_item_from_the_list([_|Rest_of_the_list], 0, Rest_of_the_list).

remove_this_item_from_the_list([First_element|Rest_of_the_list], Index, [First_element|Rest_of_the_resulting_list]) :-

    remove_this_item_from_the_list(Rest_of_the_list,New_Index,Rest_of_the_resulting_list),
    Index is New_Index + 1
.


length_of_the_list([_|[]], 1) :- !.

length_of_the_list([_|Rest_of_the_list], Length) :-
    length_of_the_list(Rest_of_the_list,Decreased_length),
    Length is Decreased_length + 1
.  


get_all_items_of_the_list([], _, [], []) :- !. 

get_all_items_of_the_list([Item|Rest_of_the_list], Item, [Item|Rest_of_the_items], Resulting_list) :-

    get_all_items_of_the_list(Rest_of_the_list, Item, Rest_of_the_items, Resulting_list), !
.  

get_all_items_of_the_list([X|Rest_of_the_list], Item, Items, [X|Rest_of_the_resulting_list]) :-

    get_all_items_of_the_list(Rest_of_the_list, Item, Items, Rest_of_the_resulting_list), !
. 


assign_into_list([_|Rest_of_the_list], [Value|Rest_of_the_list], 0, Value).

assign_into_list([Item|Rest_of_the_list], [Item|Rest_of_the_resulting_list], Index, Value) :- 

    assign_into_list(Rest_of_the_list, Rest_of_the_resulting_list, New_Index, Value),
    Index is New_Index + 1
. 


% :-trace(select_a_random_item_of_the_list).
% :-trace(index_in_the_list).
% :-trace(generated_random).
% :-trace(remove_this_item_from_the_list).
