#!/usr/bin/env escript

% Problem15:
% Starting in the top left corner of a 2×2 grid, there are 6 routes (without backtracking) to the bottom right corner.
% How many routes are there through a 20×20 grid?

-mode(compile).

-define (COLS, 20).
-define (ROWS, 20).

% Perhaps not the easiest code to read... be warned.
main(_)->
    MatrixBottomRow = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    Matrix = make_matrix([MatrixBottomRow], ?ROWS),
    [[Answer | _ ] | _] = Matrix,
    io:format("Answer: ~w~n", [Answer]).

make_matrix([LastRow|_] = MatrixInProgress, RemainingRows) when RemainingRows > 0 ->
	[_|T] = lists:reverse(LastRow), % flip the row and skip the first element (=the 1 at the far right which is already given)
	NextRow = make_row([1], 1, T),
	make_matrix([NextRow|MatrixInProgress], RemainingRows - 1);
make_matrix(MatrixInProgress, _) ->
	MatrixInProgress.

make_row([NPossibilitiesRight| _] = RowInProgress, Len, [NPossibilitiesDown|Rest]) when Len =< ?COLS->
    Possibilities = NPossibilitiesRight + NPossibilitiesDown,
    make_row([Possibilities | RowInProgress], Len + 1, Rest);
make_row(RowInProgress, _, _) ->
    RowInProgress.