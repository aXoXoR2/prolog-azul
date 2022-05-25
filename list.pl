

% Se inicializo una lista de tamanno Size, con sus elementos Value
generated_list(0, Value, Value) :- !.
generated_list(Size, Value, [X|Y]) :-
    X = Value,
    Size > 0,
    Tmp is Size - 1,
    generated_list(Tmp, Value, Y)
.

