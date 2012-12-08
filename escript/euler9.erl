#!/usr/bin/env escript

% Problem9:
% A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
% a2 + b2 = c2

% For example, 32 + 42 = 9 + 16 = 25 = 52.

% There exists exactly one Pythagorean triplet for which a + b + c = 1000.
% Find the product abc.

-define (TARGET, 1000).

main(_) ->
	{A, B, C} = find_pythagorian_triplet(),
	Answer = round(A * B * C),
	io:format("Answer: ~w~n", [Answer]).

find_pythagorian_triplet() ->
	find_pythagorian_triplet_tr(1, 2, 3). % Not actually a triplet but just to start the algorithm

find_pythagorian_triplet_tr(A, B, C) when A + B + C == ?TARGET ->
	{A, B, C};
find_pythagorian_triplet_tr(A, B, C) when A + B + C > ?TARGET ->
	ANew = A + 1,
	BNew = ANew + 1,
	CNew = math:sqrt(math:pow(ANew, 2) + math:pow(BNew, 2)),
	find_pythagorian_triplet_tr(ANew, BNew, CNew);
find_pythagorian_triplet_tr(A, B, _C) ->
	BNew = B + 1,
	CNew = math:sqrt(math:pow(A, 2) + math:pow(BNew, 2)),
	find_pythagorian_triplet_tr(A, BNew, CNew).