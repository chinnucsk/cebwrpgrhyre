#!/usr/bin/env escript

% Problem3:
% The prime factors of 13195 are 5, 7, 13 and 29.
% What is the largest prime factor of the number 600851475143?

-module (euler3).

-export ([main/1]).

main(_) ->
	Number = 600851475143,
	[HighestFactor | _] = factorize(Number),
	io:format("Answer: ~w~n", [HighestFactor]).

factorize(Number) ->
	factorize_tr(Number, 2, []).

factorize_tr(Number, Devisor, Factors) when Number == Devisor ->
	[Devisor | Factors];

factorize_tr(Number, Devisor, Factors) when Number rem Devisor == 0 ->
	factorize_tr(Number div Devisor, Devisor, [Devisor | Factors]);

factorize_tr(Number, Devisor, Factors) ->
	factorize_tr(Number, Devisor + 1, Factors).