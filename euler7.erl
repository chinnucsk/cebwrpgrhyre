#!/usr/bin/env escript

% Problem7:
% By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
% What is the 10 001st prime number?

-mode(compile).

-define (TARGET_PRIME, 10001).

main(_) ->
	Answer = get_prime(?TARGET_PRIME),
	io:format("Answer: ~w~n", [Answer]).

get_prime(TargetPrime) ->
	get_prime_tr(TargetPrime, 1, 2). % we start the algoritm so that 3 is the first number evaluated. The number '1' is not considered a prime...

get_prime_tr(TargetPrime, TargetPrime, LastCandidate) ->
	LastCandidate;
get_prime_tr(TargetPrime, NFoundPrimes, LastCandidate) ->
	NewCandidate = LastCandidate + 1,
	case eulerlib:is_prime(NewCandidate) of 
		true ->
			get_prime_tr(TargetPrime, NFoundPrimes + 1, NewCandidate);
		false ->
			get_prime_tr(TargetPrime, NFoundPrimes, NewCandidate)
	end. 