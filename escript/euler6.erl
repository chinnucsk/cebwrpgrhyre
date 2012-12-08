#!/usr/bin/env escript

% Problem6:
% The sum of the squares of the first ten natural numbers is,
% 1^2 + 2^2 + ... + 10^2 = 385

% The square of the sum of the first ten natural numbers is,
% (1 + 2 + ... + 10)^2 = 552 = 3025

% Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
% Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

-define (NUMBER, 100).

main(_) ->
	Num1 = sum_of_squares_upto(?NUMBER),
	Num2 = square_of_sum_upto(?NUMBER),
	Ans = round(Num2 - Num1),
	io:format("Answer: ~w~n", [Ans]).

sum_of_squares_upto(Number) ->
	Squares = [math:pow(X, 2) || X <- lists:seq(1, Number)],
	lists:sum(Squares).

square_of_sum_upto(Number) ->
	Sum = lists:sum(lists:seq(1,Number)),
	math:pow(Sum, 2).
