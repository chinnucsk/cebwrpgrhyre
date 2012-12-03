#!/usr/bin/env escript
% Problem10:
% The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
% Find the sum of all the primes below two million.

-mode(compile).

-define (STOP_VALUE, 2000000).

main(_) ->
	Answer = sum_of_primes(?STOP_VALUE),
	io:format("Answer: ~w~n", [Answer]).	

sum_of_primes(StopValue) ->
	sum_of_primes_tr(StopValue, 3, 2). % algo starts at 3

sum_of_primes_tr(StopValue, PrimeCandidate, Sum) when PrimeCandidate =:= StopValue ->
	Sum;
sum_of_primes_tr(StopValue, PrimeCandidate, Sum) ->
	case eulerlib:is_prime(PrimeCandidate) of
		true ->
			NewSum = Sum + PrimeCandidate,
			sum_of_primes_tr(StopValue, PrimeCandidate + 1, NewSum);
		false ->
			sum_of_primes_tr(StopValue, PrimeCandidate + 1, Sum)
	end.