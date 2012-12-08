-module (eulerlib_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("eulerlib.hrl").

-compile(export_all).

abs_test() ->
  Expected = 12345,
  Actual   = eulerlib:abs(-12345),
  ?assertMatch(Expected, Actual).

count_digits_test() ->
  Expected1 = 4,
  Actual1   = eulerlib:count_digits(4566),
  ?assertMatch(Expected1, Actual1),  
  Expected2 = 1,
  Actual2   = eulerlib:count_digits(0),
  ?assertMatch(Expected2, Actual2),
  Expected3 = 1,
  Actual3   = eulerlib:count_digits(1),
  ?assertMatch(Expected3, Actual3).

numlist_to_integer_test() ->
  Expected = 12345,
  Actual   = eulerlib:numlist_to_integer([1,2,3,4,5]),
  ?assertMatch(Expected, Actual),
  Expected2 = 0,
  Actual2   = eulerlib:numlist_to_integer([0]),
  ?assertMatch(Expected2, Actual2),
  Expected3 = 1,
  Actual3   = eulerlib:numlist_to_integer([1]),
  ?assertMatch(Expected3, Actual3).

fac_test() ->
  Expected = round(6 * 5 * 4 * 3 * 2 * 1), 
  Actual   = eulerlib:fac(6), 
  ?assertMatch(Expected, Actual).  

fib_iter_test() ->
  S  = #fibstate{},
  S2 = eulerlib:fib_iter(S),
  S3 = eulerlib:fib_iter(S2),
  S4 = eulerlib:fib_iter(S3),
  ?assertMatch(2, S2#fibstate.first),
  ?assertMatch(3, S2#fibstate.n),
  ?assertMatch(3, S3#fibstate.first),
  ?assertMatch(4, S3#fibstate.n),
  ?assertMatch(5, S4#fibstate.first).

is_prime_test() ->
  Expected  = false,
  Actual    = eulerlib:is_prime(10),
  ?assertMatch(Expected, Actual),
  Expected2 = true,
  Actual2   = eulerlib:is_prime(13),
  ?assertMatch(Expected2, Actual2),
  Expected3 = true,
  Actual3   = eulerlib:is_prime(29),
  ?assertMatch(Expected3, Actual3).

mapreduce_test() ->
  A       = [6,5],
  B       = [5,4],
  C       = [4,3],
  D       = [3,2],
  E       = [2,1],
  F       = [5,1],
  Data    = [A, B, C, D, E, F],
  Mapper  = fun (X) -> 
             lists:reverse(X)
            end,
  Reducer = fun (X, Acc) ->
              lists:umerge(X, Acc)
            end,
  Answer  = eulerlib:mapreduce(Mapper, Reducer, Data, []),  
  ?assertMatch([1,2,3,4,5,6], Answer).

parse_digits_test() ->
  Expected = [1,2,3,4,5],
  Actual   = eulerlib:parse_digits(12345),
  ?assertMatch(Expected, Actual),  
  Expected2 = [0],
  Actual2   = eulerlib:parse_digits(0),
  ?assertMatch(Expected2, Actual2).  

proper_divisors_test() ->
  Actual   = eulerlib:proper_divisors(28),
  ?assertMatch([14, 7, 4, 2, 1], Actual).