-module (eulerlib).

-export ([parse_digits/1, fac/1, proper_divisors/1, max/2, min/2]).

%% ----------------------------------
%% @doc Parses a base 10 number into its individual digits.
%% Returns all the digits of the number that was passed as an argument
%% as an array of (integer) digits.
%% @end
%% ----------------------------------
parse_digits(Number) ->
	StringList = integer_to_list(Number),
	[list_to_integer([X]) || X <- StringList].

%% ----------------------------------
%% @doc Calculates the faculty of the number passed as an argument. 
%% @end
%% ----------------------------------
fac(Number) ->
	fac_tr(Number, 1).

fac_tr(0, Acc) ->
	Acc;
fac_tr(Number, Acc) ->
	fac_tr(Number - 1, Acc * Number).

%% ----------------------------------
%% @doc Returns all the proper divisors of a number.
%% @end
%% ----------------------------------
proper_divisors(Number) ->
	proper_divisors(Number, 1, []).

proper_divisors(Number, Candidate, Acc) when Candidate > Number div 2 ->
	Acc;
proper_divisors(Number, Candidate, Acc) ->
	Acc2 = case Number rem Candidate of 
		0 ->
      [Candidate|Acc];
    _ ->
      Acc
  end,
  proper_divisors(Number, Candidate + 1, Acc2).

%% ----------------------------------
%% @doc Returns the maximum of Num1 and Num2.
%% If both numbers are equal Num1 is returned.
%% @end
%% ----------------------------------
max(Num1, Num2) ->
  if
    Num1 >= Num2 ->
      Num1;
    true ->
      Num2
  end.

%% ----------------------------------
%% @doc Returns the minimum of Num1 and Num2.
%% If both numbers are equal Num1 is returned.
%% @end
%% ----------------------------------
min(Num1, Num2) ->
  if
    Num1 =< Num2 ->
      Num1;
    true ->
      Num2
  end.