#!/usr/bin/env escript

% Problem16:
% 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
% What is the sum of the digits of the number 2^1000?

main(_) ->
  code:add_path("../ebin"),
	Number = round(math:pow(2,1000)),
	IntegerList = eulerlib:parse_digits(Number),
	Answer = lists:sum(IntegerList),
	io:format("Answer: ~w~n", [Answer]).