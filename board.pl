:- [utils].

:- dynamic amount_of_black_chip_in_the_bag/1, 
           amount_of_red_chip_in_the_bag/1, 
           amount_of_blue_chip_in_the_bag/1, 
           amount_of_yellow_chip_in_the_bag/1, 
           amount_of_green_chip_in_the_bag/1 , 
           arc/4, arc/2.

% Variables
amount_of_black_chip_in_the_bag(20).
amount_of_red_chip_in_the_bag(20).
amount_of_blue_chip_in_the_bag(20).
amount_of_yellow_chip_in_the_bag(20).
amount_of_green_chip_in_the_bag(20).



arc(Args, MetaPredicate) :- 
    arc(A,B,C,D),
    Args = [A,B,C,D],
    MetaPredicate=..[arc,A,B,C,D]
. 

arc(ini, arg1, arg2, arg3).

:- trace(arc).