#!/usr/bin/env escript

% Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
% If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

% For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

% Evaluate the sum of all the amicable numbers under 10000.

-mode(compile).

main(_) ->
  code:add_path("../ebin"),
	AmicableNumbers = amicable_numbers(1, 10000),
  Sum = lists:sum(AmicableNumbers),
  io:format("Amicable Numbers: ~w~n", [AmicableNumbers]),
  io:format("Answer: ~w~n", [Sum]).

amicable_numbers(From, To) ->
  amicable_numbers(From, To, From, []).

amicable_numbers(_, To, To, Acc) -> % We hit the last number (which is not included in the interval)
  Acc;
amicable_numbers(From, To, Current, Acc) ->
  Acc2 = case is_amicable_number(Current) of 
    true ->
      [Current|Acc];
    false ->
      Acc
  end,
  amicable_numbers(From, To, Current + 1, Acc2).

is_amicable_number(Number) ->
	A = lists:sum(eulerlib:proper_divisors(Number)),
  B = lists:sum(eulerlib:proper_divisors(A)),
  (Number =:= B) and (Number =/= A).