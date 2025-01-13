% Mathematical relationships and properties
relationship(golden_ratio, A, B) :-
    Ratio is A / B,
    approximately_equal(Ratio, 1.618034, 0.001).

relationship(perfect_square_difference, A, B) :-
    Diff is A - B,
    integer(sqrt(Diff)),
    sqrt(Diff) * sqrt(Diff) =:= Diff.

relationship(consecutive_squares, A, B) :-
    sqrt(A) + 1 =:= sqrt(B).

% Helper predicates
approximately_equal(X, Y, Tolerance) :-
    abs(X - Y) < Tolerance.

find_relationships(Numbers, Relationships) :-
    findall(Rel, (
        member(A, Numbers),
        member(B, Numbers),
        A < B,
        relationship(Type, A, B),
        Rel = relationship(Type, A, B)
    ), Relationships). 