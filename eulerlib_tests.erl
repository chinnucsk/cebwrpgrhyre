-module (eulerlib_tests).

-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

list_to_integer_test() ->
  Expected = 12345,
  Actual   = eulerlib:numlist_to_integer([1,2,3,4,5]),
  ?assertMatch(Expected, Actual).

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

