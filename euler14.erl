#!/usr/bin/env escript
% Problem14:
% The following iterative sequence is defined for the set of positive integers:

% n → n/2 (n is even)
% n → 3n + 1 (n is odd)

% Using the rule above and starting with 13, we generate the following sequence:
% 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

% It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

% Which starting number, under one million, produces the longest chain?

% NOTE: Once the chain starts the terms are allowed to go above one million.

-mode(compile).

-define (START, 999999).

main(_) ->
	{_, StartSec, _} = now(),
	{HighScore, HighScoreHolder} = longest_sequence(?START),
	{_, EndSec, _} = now(),
	io:format("HighScore: ~w, HighScoreHolder: ~w, ExecutionTime: ~w seconds~n", [HighScore, HighScoreHolder, EndSec - StartSec]).

longest_sequence(StartNumber) ->
	longest_sequence_tr(StartNumber, StartNumber, 1, 1, 1).

longest_sequence_tr(CurrentNumber, _, _, HighScore, HighScoreHolder) when CurrentNumber =:= 1 ->
	{HighScore, HighScoreHolder};
longest_sequence_tr(CurrentNumber, N, CurrentLen, HighScore, HighScoreHolder) when N =:= 1 ->
	case CurrentLen > HighScore of
		true ->
			longest_sequence_tr(CurrentNumber - 1, CurrentNumber - 1, 1, CurrentLen, CurrentNumber);
		false ->
			longest_sequence_tr(CurrentNumber - 1, CurrentNumber - 1, 1, HighScore, HighScoreHolder)
	end; 	
longest_sequence_tr(CurrentNumber, N, CurrentLen, HighScore, HighScoreHolder) when N rem 2 =:= 0 ->
	longest_sequence_tr(CurrentNumber, N div 2, CurrentLen + 1, HighScore, HighScoreHolder);
longest_sequence_tr(CurrentNumber, N, CurrentLen, HighScore, HighScoreHolder) ->
	longest_sequence_tr(CurrentNumber, 3*N + 1, CurrentLen + 1, HighScore, HighScoreHolder).