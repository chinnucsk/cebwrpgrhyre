#!/usr/bin/env escript
% Problem16:
% 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
% What is the sum of the digits of the number 2^1000?

main(_) ->
	StringList = integer_to_list(round(math:pow(2,1000))),
	IntegerList = [list_to_integer([X]) || X <- StringList],
	Answer = lists:sum(IntegerList),
	io:format("Answer: ~w~n", [Answer]).