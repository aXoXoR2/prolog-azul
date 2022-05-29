
:- ['../collections/collections_management'].


set_pattern_line_transducer(Pattern_lines, Modified_pattern_lines, 
        [[Azulejo, Top, Top], Pattern_lines_index, Azulejos, Rest]
    ) :-
    
    Azulejos = [Azulejo|Rest_of_azulejos],

    length_of_the_list(Azulejos, Rest),

    New_Top is Pattern_lines_index + 1,

    assign_into_list(Pattern_lines, Modified_pattern_lines, 
        Pattern_lines_index, [Azulejo, New_Top, New_Top]),

    true

. 


set_pattern_line_transducer(Pattern_lines, Modified_pattern_lines, 
        [[Azulejo, Amount, Top], Pattern_lines_index, 
        [Azulejos|Rest_of_azulejos], Rest]
    ) :-

    % index_in_the_list(Pattern_lines, Pattern_lines_index, 
    %     [Azulejo, Amount, Top]),

    % Amount \= Top,
    
    % Azulejos = [Tile|_],
    % length_of_the_list(Azulejos, Length),


    set_pattern_line_transducer(Pattern_lines, Modified_pattern_lines, 
        [[Azulejo, Amount, New_Top], Pattern_lines_index, 
        Rest_of_azulejos, Rest]),
    
    Top is New_Top + 1,

    true
. 
