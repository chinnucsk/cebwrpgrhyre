-module (eulerlib_tests).

-include_lib("eunit/include/eunit.hrl").

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

invert_list_test() ->
  InvertMe = [1,3,5,7,10],
  Expected = [2,4,6,8,9],
  Actual   = eulerlib:invert_list(InvertMe),
  ?assertMatch(Expected,Actual).