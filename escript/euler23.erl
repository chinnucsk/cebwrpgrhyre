#!/usr/bin/env escript

% A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. 
% For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
% A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
% As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. 
% By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. 
% However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be 
% expressed as the sum of two abundant numbers is less than this limit.
% Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

% NOTE: For some strange (memory) reason this program will crash if run with the -n flag on R15B01.

-mode(compile).

-define (MAXIMUM, 28123).

main(_) ->
  code:add_path("../ebin"),
  io:format("Finding all abduant numbers...~n"),
  AbduantNumbers = all_abduant_numbers(?MAXIMUM),

  io:format("Generating abduant pairs...~n"),
  AbduantPairs = [X + Y || X <- AbduantNumbers, Y <- AbduantNumbers],

  io:format("Sorting and removing duplicates...~n"),
  AbduantPairsSorted = lists:usort(AbduantPairs),

  io:format("Sieving non-abduant numbers...~n"),
  AllNumbers = lists:seq(1,?MAXIMUM),
  Residue    = lists:subtract(AllNumbers, AbduantPairsSorted),

  io:format("Answer: ~w~n", [lists:sum(Residue)]).

all_abduant_numbers(Limit) ->
  all_abduant_numbers(Limit, 1, []).

all_abduant_numbers(Limit, Candidate, Acc) when Candidate > Limit ->
  Acc;
all_abduant_numbers(Limit, Candidate, Acc) ->
  case is_abduant(Candidate) of
    true ->
      all_abduant_numbers(Limit, Candidate + 1, [Candidate|Acc]);
    false -> 
      all_abduant_numbers(Limit, Candidate + 1, Acc)
  end.

is_abduant(Number) ->
  Sum = lists:sum(eulerlib:proper_divisors(Number)),
  Sum > Number.

  