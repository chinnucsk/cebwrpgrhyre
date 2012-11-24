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
	case is_prime(PrimeCandidate) of
		true ->
			NewSum = Sum + PrimeCandidate,
			sum_of_primes_tr(StopValue, PrimeCandidate + 1, NewSum);
		false ->
			sum_of_primes_tr(StopValue, PrimeCandidate + 1, Sum)
	end.

is_prime(Number) when Number rem 2 /= 0 ->
	is_prime_tr(Number, 2, math:sqrt(Number));
is_prime(_) ->
	false.

is_prime_tr(_Number, Divisor, MaxTestVal) when Divisor > MaxTestVal ->
	true;
is_prime_tr(Number, Divisor, _MaxTestVal) when Number rem Divisor =:= 0 ->
	false;
is_prime_tr(Number, Divisor, MaxTestVal) ->
	is_prime_tr(Number, Divisor + 1, MaxTestVal).