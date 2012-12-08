#!/usr/bin/env escript

% Problem1:
% If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
% Find the sum of all the multiples of 3 or 5 below 1000.

-define(MAX, 999).

main(_) ->
	Candidates = [X || X <- lists:seq(1, ?MAX), (X rem 3 =:= 0) or (X rem 5 =:= 0)],
    Answer = lists:sum(Candidates),
    io:format("Answer: ~w~n", [Answer]).