% NOTE: Module must be compiled to beam, escript not possible.

% Problem7:
% By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
% What is the 10 001st prime number?

-module (euler7).

-export ([start/0]).

-define (TARGET_PRIME, 10001).

start() ->
	Answer = get_prime(?TARGET_PRIME),
	io:format("Answer: ~w~n", [Answer]).

get_prime(TargetPrime) ->
	get_prime_tr(TargetPrime, 1, 2). % we start the algoritm so that 3 is the first number evaluated. The number '1' is not considered a prime...

get_prime_tr(TargetPrime, TargetPrime, LastCandidate) ->
	LastCandidate;
get_prime_tr(TargetPrime, NFoundPrimes, LastCandidate) ->
	NewCandidate = LastCandidate + 1,
	case is_prime(NewCandidate) of 
		true ->
			get_prime_tr(TargetPrime, NFoundPrimes + 1, NewCandidate);
		false ->
			get_prime_tr(TargetPrime, NFoundPrimes, NewCandidate)
	end.

is_prime(Number) when Number rem 2 /= 0 ->
	is_prime_tr(Number, 2);
is_prime(_) ->
	false.

is_prime_tr(Number, Divisor) when Number div Divisor =:= 1 ->
	true;
is_prime_tr(Number, Divisor) when Number rem Divisor =:= 0 ->
	false;
is_prime_tr(Number, Divisor) ->
	is_prime_tr(Number, Divisor + 1).
 