% Basic number sequences
sequence(fibonacci, [1,1,2,3,5,8,13,21]) :-
    description('Each number is the sum of the previous two numbers'),
    properties([
        growth_rate(1.618034),
        also_known_as('Golden Sequence'),
        applications(['Nature', 'Art', 'Architecture'])
    ]).

sequence(square, [1,4,9,16,25,36]) :-
    description('Sequence of perfect square numbers'),
    properties([
        growth_rate('n^2'),
        formula('n * n'),
        applications(['Geometry', 'Area Calculation'])
    ]).

sequence(triangular, [1,3,6,10,15,21]) :-
    description('Numbers that can form triangular arrangements'),
    properties([
        formula('n * (n + 1) / 2'),
        applications(['Combinatorics', 'Game Theory'])
    ]).

% Pattern matching rules
matches_sequence(Numbers, Type) :-
    sequence(Type, Pattern),
    pattern_growth(Numbers, Pattern).

pattern_growth([A,B|Rest], [C,D|Pattern]) :-
    Growth1 is B / A,
    Growth2 is D / C,
    approximately_equal(Growth1, Growth2, 0.01),
    (Rest = [] ; pattern_growth([B|Rest], [D|Pattern])). 