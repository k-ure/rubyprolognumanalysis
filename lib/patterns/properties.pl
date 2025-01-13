% Mathematical properties
property(perfect_number, N) :-
    sum_of_factors(N, N).

property(prime, N) :-
    N > 1,
    \+ (between(2, sqrt(N), X), N mod X =:= 0).

property(palindromic, N) :-
    number_chars(N, Chars),
    reverse(Chars, Chars).

% Property checking rules
check_properties(N, Properties) :-
    findall(P, (property(P, N)), Properties).

sum_of_factors(N, Sum) :-
    findall(F, (between(1, N-1, F), N mod F =:= 0), Factors),
    sum_list(Factors, Sum). 