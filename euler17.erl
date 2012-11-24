#!/usr/bin/env escript

% Problem17:
% If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
% If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
% NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

main(_) ->
	LetterNumbers = [nletters(X) || X <- lists:seq(1, 1000)],
	Answer = lists:sum(LetterNumbers),
	% Answer = nletters(100),
	io:format("Answer: ~w~n", [Answer]).

nletters(Number) when Number div 1000 >= 1 ->
	Next = rm_top_digit(Number),
	nletters(Next) + length("onethousand");
nletters(Number) when Number >= 100 ->
	And = case Number rem 100 of 
		0 ->
			0;
		_ -> 
			length("and")
	end,
	case Number div 100 of 
		0 ->
			nletters(Number) + And;
		1 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("onehundred") + And;
		2 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("twohundred") + And;
		3 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("threehundred") + And;
		4 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("fourhundred") + And;
		5 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("fivehundred") + And;
		6 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("sixhundred") + And;
		7 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("sevenhundred") + And;
		8 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("eighthundred") + And;
		9 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("ninehundred") + And
	end;
nletters(Number) when Number >= 20 ->
	case Number div 10 of 
		2 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("twenty");
		3 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("thirty");
		4 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("forty");
		5 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("fifty");
		6 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("sixty");
		7 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("seventy");
		8 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("eighty");
		9 -> 
			Next = rm_top_digit(Number),
			nletters(Next) + length("ninety")
	end;
nletters(19) ->
	length("nineteen");
nletters(18) ->
	length("eighteen");
nletters(17) ->
	length("seventeen"); 
nletters(16) ->
	length("sixteen");
nletters(15) ->
	length("fifteen");
nletters(14) ->
	length("fourteen");
nletters(13) ->
	length("thirteen");
nletters(12) ->
	length("twelve");
nletters(11) ->
	length("eleven");
nletters(10) ->
	length("ten");
nletters(9) ->
	length("nine");
nletters(8) ->
	length("eight");
nletters(7) ->
	length("seven");
nletters(6) ->
	length("six");
nletters(5) ->
	length("five");
nletters(4) ->
	length("four");
nletters(3) ->
	length("three");
nletters(2) ->
	length("two");
nletters(1) ->
	length("one");
nletters(0) ->
	0.

rm_top_digit(Number) ->
	NumString = integer_to_list(Number),
	NumList = [list_to_integer([X]) || X <- NumString],
	[_|T] = NumList,
	merge_to_number(T, 0).

merge_to_number([] ,Acc) ->
	Acc;
merge_to_number([H|T], Acc0) ->
	Factor = math:pow(10, length([H|T]) - 1),
	Acc = Acc0 + round(Factor) * H,
	merge_to_number(T, Acc).