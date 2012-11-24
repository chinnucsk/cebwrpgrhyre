% NOTE: After some testing escript turned out to be too slow to solve this problem in a feasable time so this file has to be compiled traditionally

% Problem5:
% 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
% What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

-module (euler5).

-export ([start/0]).

-define (MAX_DENOMINATOR, 20).

start() ->
	Answer = smallest_common_numerator(),
	io:format("Answer: ~w~n", [Answer]).

smallest_common_numerator() ->
	smallest_common_numerator_tr(20, ?MAX_DENOMINATOR).

smallest_common_numerator_tr(NumeratorCandidate, CurrentDenominator) when CurrentDenominator > 1 ->
	case NumeratorCandidate rem CurrentDenominator of 
		0 ->
			smallest_common_numerator_tr(NumeratorCandidate, CurrentDenominator - 1);
		_ ->
			smallest_common_numerator_tr(NumeratorCandidate + 1, ?MAX_DENOMINATOR)
	end;

smallest_common_numerator_tr(NumeratorCandidate, _) ->
	NumeratorCandidate.