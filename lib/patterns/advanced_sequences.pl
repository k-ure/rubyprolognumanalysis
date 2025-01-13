% More advanced number patterns
sequence(geometric, [A,B|Rest]) :-
    B > A,
    Ratio is B / A,
    all_have_ratio([B|Rest], Ratio).

sequence(arithmetic, [A,B|Rest]) :-
    B > A,
    Diff is B - A,
    all_have_difference([B|Rest], Diff).

sequence(polynomial, Numbers) :-
    length(Numbers, Len),
    Len >= 4,
    differences_approach_zero(Numbers, 3).

% Helper predicates
all_have_ratio([A,B|Rest], Ratio) :-
    approximately_equal(B/A, Ratio, 0.001),
    (Rest = [] ; all_have_ratio([B|Rest], Ratio)).

all_have_difference([A,B|Rest], Diff) :-
    approximately_equal(B-A, Diff, 0.001),
    (Rest = [] ; all_have_difference([B|Rest], Diff)).

differences_approach_zero(Numbers, Level) :-
    differences(Numbers, Diffs),
    (Level =:= 1 ; 
    differences_approach_zero(Diffs, Level-1)). 