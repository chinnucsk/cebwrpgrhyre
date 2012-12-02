%#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable

% A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. 
% For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
% A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
% As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. 
% By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. 
% However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be 
% expressed as the sum of two abundant numbers is less than this limit.
% Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

%-mode(compile).

-module(euler23).

-export([main/1]).

-define (MAX_SEARCH, 14062).

main(_) ->
  io:format("Finding all abduant numbers...~n"),
  AbduantNumbers = all_abduant_numbers(?MAX_SEARCH),
  Mapper  = fun ([H|_] = AbudantNumbers) -> 
             [H + X || X <- AbudantNumbers]
            end,
  Reducer = fun (X, Acc) ->
              lists:umerge(X, Acc)
            end,  
  io:format("Preparing to Map-Reduce...~n"),         
  Data = prepare_mapreduce(AbduantNumbers, []),
  io:format("Map-Reduce ready! nMappers = ~w~n", [length(Data)]),         
  io:format("Map-Reducing...~n"),
  AbduantCombinations = eulerlib:mapreduce(Mapper, Reducer, Data, []),
  io:format("Sorting...~n"),
  AbudantCombinationsSorted = lists:sort(AbduantCombinations),
  io:format("Extracting non-abudant numbers...~n"),
  AllNumbers = lists:seq(1,28123),
  NonAbudantNumbers = eulerlib:sieve_list(AllNumbers, AbudantCombinationsSorted),
  io:format("NonAbudantNumbers: ~w~n", [NonAbudantNumbers]).

prepare_mapreduce([], Acc) ->
  Acc;
prepare_mapreduce([_|T] = AllAbudantNumbers, Acc) ->
  Acc2 = [AllAbudantNumbers|Acc],
  prepare_mapreduce(T, Acc2).

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

  