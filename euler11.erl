#!/usr/bin/env escript

% In the 20×20 grid below, four numbers along a diagonal line have been marked in red.
% (The data itself is kept in an external file)

% The product of these numbers is 26 × 63 × 78 × 14 = 1788696.

% What is the greatest product of four adjacent numbers in any direction (up, down, left, right, or diagonally) in the 20×20 grid?

% Authors note: This solution really sucks. Its been a mess to write!
% Note: This code is currently not functional!!!!

-mode(compile).

-define(X_MAX, 20).
-define(Y_MAX, 20).

main(_) ->
	DataFile       = "euler11data.txt",
	DataAsList     = eulerlib:parse_int_problem_file(DataFile),
	DataAsTuples   = list_to_tuple([list_to_tuple(X) || X <- DataAsList]),
  Highest        = highest_product(DataAsTuples),
	io:format("Answer: ~w~n", [Highest]).

highest_product(Data) ->
	highest_product(Data, 1, 1, 0).

highest_product(Data, X, Y, Highest) -> 
  Res1 = vertical_product(Data, X, Y),
  Res2 = horizontal_product(Data, X, Y),
  Res3 = diagonal_product1(Data, X, Y),
  Res4 = diagonal_product2(Data, X, Y),
  Tmp  = eulerlib:max(Res1, Res2),
  Tmp2 = eulerlib:max(Tmp, Res3),
  Tmp3 = eulerlib:max(Tmp2, Res4),
  Max  = eulerlib:max(Tmp3, Highest),
  case next_coordinate(X, Y) of
    {X2,Y2} -> 
      highest_product(Data, X2, Y2, Max); 
    stop_this_shit ->
      Highest
  end.

vertical_product(Data, X, Y) when Y + 3 =< ?Y_MAX ->
  Elem1 = element(X, element(Y, Data)),
  Elem2 = element(X, element(Y + 1, Data)),
  Elem3 = element(X, element(Y + 2, Data)),
  Elem4 = element(X, element(Y + 3, Data)),
  Elem1 * Elem2 * Elem3 * Elem4;
vertical_product(_, _, _) ->
  -1.

horizontal_product(Data, X, Y) when X + 3 =< ?X_MAX ->
  Row = element(Y, Data),
  Elem1 = element(X, Row),
  Elem2 = element(X + 1, Row),
  Elem3 = element(X + 2, Row),
  Elem4 = element(X + 3, Row),
  Elem1 * Elem2 * Elem3 * Elem4;
horizontal_product(_, _, _) ->
  -1.

diagonal_product1(Data, X, Y) when (X + 3 =< ?X_MAX) and (Y + 3 =< ?Y_MAX) ->
  Elem1 = element(X, element(Y, Data)),
  Elem2 = element(X + 1, element(Y + 1, Data)),
  Elem3 = element(X + 2, element(Y + 2, Data)),
  Elem4 = element(X + 3, element(Y + 3, Data)),
  Elem1 * Elem2 * Elem3 * Elem4;
diagonal_product1(_, _, _) ->
  -1.

diagonal_product2(Data, X, Y) when (X + 3 =< ?X_MAX) and (Y >= 4) ->
  Elem1 = element(X, element(Y, Data)),
  Elem2 = element(X + 1, element(Y - 1, Data)),
  Elem3 = element(X + 2, element(Y - 2, Data)),
  Elem4 = element(X + 3, element(Y - 3, Data)),
  Elem1 * Elem2 * Elem3 * Elem4;
diagonal_product2(_, _, _) ->
  -1.

next_coordinate(X, Y) when X =:= ?X_MAX andalso Y =:= ?Y_MAX ->
  stop_this_shit;
next_coordinate(X, Y) when X =:= ?X_MAX ->
  {1, Y + 1};
next_coordinate(X, Y) ->    
  {X + 1, Y}.