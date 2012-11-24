#!/usr/bin/env escript

% Problem4:
% A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
% Find the largest palindrome made from the product of two 3-digit numbers.

%NOTE: This is obviously not an efficient solution but is gets the job done. 
%Takes ~15 sec when utilizing 1/4 cores on an i3 processor @ 3.2Ghz  

-module(euler4).

-export ([main/1]).

main(_) -> 
	NumberSpace = [X*Y || X <- lists:seq(100, 999), Y <- lists:seq(100, 999)],
	Palindromes = [X || X <- NumberSpace, is_palindrome(X)],
	Highest = lists:max(Palindromes),
	io:format("Answer: ~w~n", [Highest]).

is_palindrome(Number) ->
	NumberAsList = integer_to_list(Number),
	NumberAsListReversed = lists:reverse(NumberAsList),
	is_equal(NumberAsList, NumberAsListReversed).

is_equal(List, List) -> 
	true;
is_equal(_, _) ->
	false.

	

