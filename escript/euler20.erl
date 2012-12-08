#!/usr/bin/env escript

% n! means n × (n − 1) × ... × 3 × 2 × 1
% For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
% and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
% Find the sum of the digits in the number 100!

main(_) ->
  code:add_path("../ebin"),
	Number  = eulerlib:fac(100),
	Digits  = eulerlib:parse_digits(Number),
	Sum     = lists:sum(Digits),
	io:format("Answer: ~w~n", [Sum]).