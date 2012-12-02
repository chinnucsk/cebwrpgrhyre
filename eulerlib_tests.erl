-module (eulerlib_tests).

-include_lib("eunit/include/eunit.hrl").

map_reduce_test() ->
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
  Answer  = eulerlib:map_reduce(Mapper, Reducer, Data),  
  ?assertMatch([1,2,3,4,5,6], Answer).