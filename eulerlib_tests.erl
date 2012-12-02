-module (eulerlib_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("eulerlib.hrl").

-compile(export_all).

list_to_integer_test() ->
  Expected = 12345,
  Actual   = eulerlib:numlist_to_integer([1,2,3,4,5]),
  ?assertMatch(Expected, Actual).

fib_iter_test() ->
  S  = #fibstate{},
  S2 = eulerlib:fib_iter(S),
  S3 = eulerlib:fib_iter(S2),
  S4 = eulerlib:fib_iter(S3),
  ?assertMatch(3, S2#fibstate.first),
  ?assertMatch(3, S2#fibstate.n),
  ?assertMatch(5, S3#fibstate.first),
  ?assertMatch(4, S3#fibstate.n),
  ?assertMatch(8, S4#fibstate.first).

proper_divisors_test() ->
  Actual   = eulerlib:proper_divisors(28),
  ?assertMatch([14, 7, 4, 2, 1], Actual).

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



