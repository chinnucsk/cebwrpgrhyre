#!/usr/bin/env escript

% A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. 
% If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. 
% The lexicographic permutations of 0, 1 and 2 are:
% 012   021   102   120   201   210
% What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

-mode(compile).

main(_) ->
  code:add_path("../ebin"),
  Permutations = permutations([0,1,2,3,4,5,6,7,8,9]),
  Answer       = eulerlib:numlist_to_integer(lists:nth(1000000, Permutations)),
  io:format("Answer: ~w~n", [Answer]).

permutations([]) -> 
  [[]];
permutations(List) ->
  [[H|T] || H <- List, T <- permutations(List--[H])].