-module (eulerlib).

-include ("eulerlib.hrl").

-export ([parse_digits/1, fac/1, proper_divisors/1, 
          max/2, min/2, parse_int_problem_file/1, 
          mapreduce/4, numlist_to_integer/1,
          fib_iter/1, count_digits/1, is_prime/1,
          abs/1]).

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
%% @doc Interprets a list as a base-10 integer number.
%% List is interpreted in a big-endian sense, and each position in the 
%% list is interpreted as a power of 10 lower than the previous one (=the position to the left).
%% @end
%% ----------------------------------
numlist_to_integer(List) ->
  numlist_to_integer(List, 0).

numlist_to_integer([], Acc) ->
  round(Acc);
numlist_to_integer([H|T] = List, Acc) ->
  Factor = math:pow(10, length(List) - 1),
  Acc2 = Acc + (Factor * H),
  numlist_to_integer(T, Acc2).

%% ----------------------------------
%% @doc Counts the number of digits in a base-10 number.
%% @end
%% ----------------------------------
count_digits(Number) ->
  count_digits(Number, 0).

count_digits(Number, Acc) when Number > 0 ->
  NumberNext = Number div 10,
  count_digits(NumberNext, Acc + 1); 
count_digits(_, Acc) ->
  Acc.

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
%% @doc Iterate thorugh all fibonacci numbers, c-style. Returns an updated state with the newest number as next.
%% @end
%% ----------------------------------
fib_iter(S) ->
  #fibstate{first  = S#fibstate.first + S#fibstate.second,
            second = S#fibstate.first,
            n      = S#fibstate.n + 1}.

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
%% @doc Checks is a number is a prime or not. 
%% Number that is tested must be a true integer, e.g 123 (123.0 is not ok).
%% @end
%% ----------------------------------
is_prime(2) ->
  true;
is_prime(Number) when Number rem 2 /= 0 ->
  is_prime_tr(Number, 2, math:sqrt(Number));
is_prime(_) ->
  false.

is_prime_tr(_Number, Divisor, MaxTestVal) when Divisor > MaxTestVal ->
  true;
is_prime_tr(Number, Divisor, _MaxTestVal) when Number rem Divisor == 0 ->
  false;
is_prime_tr(Number, Divisor, MaxTestVal) ->
  is_prime_tr(Number, Divisor + 1, MaxTestVal).

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

%% ----------------------------------
%% @doc Parses a plain text file containing integer problem data.
%% The data in the file must have Unix file endings '\n' and
%% the individual tokens in the file must be space separated.
%% The file is returned as a list of lists, one for each row 
%% in the file.
%% @end
%% ----------------------------------
parse_int_problem_file(Filename) ->
  {ok, IoDevice} = file:open(Filename, [read]),
  parse_int_problem_file(IoDevice, []).

parse_int_problem_file(IoDevice, Acc) ->
  case file:read_line(IoDevice) of
    {ok, Data} ->
      Data2    = string:strip(Data, right, $\n),
      Data3    = string:tokens(Data2, " "),
      IntList  = [list_to_integer(X) || X <- Data3],
      parse_int_problem_file(IoDevice, [IntList|Acc]);
    eof ->
      lists:reverse(Acc);
    _ ->
      io:write("Errrrrrror when parsing file~n"),
      error
  end. 

%% ----------------------------------
%% @doc A simple map-reduce implementation.
%% MapFun    => Function that does the mapping
%% ReduceFun => Function that does the reduction
%% Data      => The data that the mappers should work on. 
%%              One mapper will be spawned for each term in this list.
%% Acc0      => Initial accumulator that will be passed to the reducer  
%% @end
%% ----------------------------------
mapreduce(MapFun, ReduceFun, Data, Acc0) ->
  SelfPid = self(),
  io:format("Processes before map-reduce spawn: ~w~n", [length(processes())]),
  ReducerPid = spawn(fun () -> reducer(SelfPid, ReduceFun, length(Data), Acc0) end),
  lists:foreach(fun (X) ->
                  spawn(fun () -> mapper(ReducerPid, MapFun, X) end)
                end, Data),
  io:format("Processes after map-reduce spawn: ~w~n", [length(processes())]),
  timer:sleep(1000),
  io:format("Processes 1 sec map-reduce spawn: ~w~n", [length(processes())]),
  timer:sleep(1000),
  io:format("Processes 2 sec map-reduce spawn: ~w~n", [length(processes())]),
  receive  
    {ReducerPid, Result} ->
      Result;
    Error ->
      Error
  end.

reducer(ParentPid, ReduceFun, Remaining, Acc) ->
  receive
    {mapper_done, Result} ->
      Remaining2 = Remaining - 1,
      Acc2 = ReduceFun(Result, Acc),
      case Remaining2 > 0 of
        true ->
          reducer(ParentPid, ReduceFun, Remaining2, Acc2);
        false ->
          ParentPid ! {self(), Acc2}
      end;
    Error ->
      Error
  end. 

mapper(ReducerPid, MapperFun, X) ->
  Result = MapperFun(X),
  ReducerPid ! {mapper_done, Result}.
%% ----------------------------------

abs(Num) when Num < 0 -> 
  -Num;
abs(Num) ->
  Num.