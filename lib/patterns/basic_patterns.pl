% Basic pattern definitions
:- module(basic_patterns, [is_square/1, find_patterns/2]).

is_square(N) :- 
    number(N),
    R is sqrt(N),
    abs(R * R - N) < 0.000001.

find_patterns(Numbers, Patterns) :-
    findall([Type, Nums, Desc],
        identify_pattern(Numbers, Type, Nums, Desc),
        Patterns).

identify_pattern(Numbers, square, Nums, 'Square numbers') :-
    include(is_square, Numbers, Nums),
    Nums \= [].