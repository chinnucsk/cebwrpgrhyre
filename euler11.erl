#!/usr/bin/env escript

% In the 20×20 grid below, four numbers along a diagonal line have been marked in red.
% (The data itself is kept in an external file)

% The product of these numbers is 26 × 63 × 78 × 14 = 1788696.

% What is the greatest product of four adjacent numbers in any direction (up, down, left, right, or diagonally) in the 20×20 grid?

% Authors note: This solution really sucks. Its been a mess to write!

-mode(compile).

main(_) ->
	DataFile       = "euler11data.txt",
	DataAsList     = eulerlib:parse_int_problem_file(DataFile),
	DataAsTuples   = list_to_tuple([list_to_tuple(X) || X <- DataAsList]),
  Highest        = highest_product(DataAsTuples),
	io:format("Answer: ~w~n", [Highest]).

highest_product(Data) ->
	highest_product(Data, 0, 0, 0).

highest_product(Data, X, Y, Highest) when X > tuple_size(element(Y, Data)) andalso Y =:= tuple_size(Data) ->
  Highest;
highest_product(Data, X, Y, Highest) -> 
  Res1 = vertical_product(Data, X, Y),
  Res2 = horizontal_product(Data, X, Y),
  Res3 = diagonal_product(Data, X, Y),
  Tmp  = eulerlib:max(Res1, Res2),
  Tmp2 = eulerlib:max(Tmp, Res3),
  Max  = eulerlib:max(Tmp2, Highest),
  if
    (Res1 =< 0) and (Res2 =< 0) and (Res3 =< 0) -> % go to next col
      highest_product(Data, 0, Y + 1, Max); 
    true -> % next element 
      highest_product(Data, X + 1, Y, Max)
  end.

vertical_product(Data, X, Y) ->
  if
    Y + 3 =< tuple_size(Data) - 1 ->
      Elem1 = element(X, element(Y, Data)),
      Elem2 = element(X, element(Y + 1, Data)),
      Elem3 = element(X, element(Y + 2, Data)),
      Elem4 = element(X, element(Y + 3, Data)),
      Elem1 * Elem2 * Elem3 * Elem4;
    true ->
      -1 
  end.

horizontal_product(Data, X, Y) ->
  Row = element(Y, Data),
  if
    (X + 3) =< (tuple_size(Row) - 1) ->
      Elem1 = element(X, Data),
      Elem2 = element(X + 1, Data),
      Elem3 = element(X + 2, Data),
      Elem4 = element(X + 3, Data),
      Elem1 * Elem2 * Elem3 * Elem4;
    true ->
      -1 
  end.

diagonal_product(Data, X, Y) ->
  Row = element(Y, Data),
  if
    ((X + 3) =< (tuple_size(Row) - 1)) and ((Y + 3) =< (tuple_size(Data) - 1)) ->
      Elem1 = element(element(Y, Data), X),
      Elem2 = element(element(Y + 1, Data), X + 1),
      Elem3 = element(element(Y + 2, Data), X + 2),
      Elem4 = element(element(Y + 3, Data), X + 3),
      Elem1 * Elem2 * Elem3 * Elem4;
    true ->
      -1
  end.
