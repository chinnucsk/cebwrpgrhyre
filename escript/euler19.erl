#! /usr/bin/escript
% You are given the following information, but you may prefer to do some research for yourself.

%     1 Jan 1900 was a Monday.
%     Thirty days has September,
%     April, June and November.
%     All the rest have thirty-one,
%     Saving February alone,
%     Which has twenty-eight, rain or shine.
%     And on leap years, twenty-nine.
%     A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

% how many sundays fell on the first of the month during the twentieth century (1 jan 1901 to 31 dec 2000)?

-define(DAYS_IN_MONTHS_LEAPYEAR,    [31,29,31,30,31,30,31,31,30,31,30,31]).
-define(DAYS_IN_MONTHS_NO_LEAPYEAR, [31,28,31,30,31,30,31,31,30,31,30,31]).

-record(state, {dayofweek,
                dayofmonth,
                dayspermonth,
                hits}).
%% ----------------------------------
%% @doc Kickstart my heart!
%% (and print the answer).
%% @end
%% ----------------------------------
main(_) ->
  First         = 1900,
  Last          = 2000, 
  DaysPerMonth  = days_per_month(First),
  S = #state{dayofweek    = 0,
             dayofmonth   = 1,  
             dayspermonth = DaysPerMonth,
             hits         = 0},
  S2        = eval_yearspan(First, Last, S),
  S3        = eval_yearspan(First, First, S),
  HitsDiff  = S2#state.hits - S3#state.hits,
  io:format("Answer: ~w~n", [HitsDiff]).

%% ----------------------------------
%% @doc Find all sunday-first-day-in-the-month occurrences a specific year.
%% This function wraps eval_yearspan/4.
%% @end
%% ----------------------------------  
eval_yearspan(First, Last, InitialState) ->
  eval_yearspan(First, Last, First, InitialState).

%% ----------------------------------
%% @doc Find all sunday-first-day-in-the-month in a span of years.
%% @end
%% ----------------------------------
eval_yearspan(First, Last, Current, S) when Current =< Last ->
  S2 = eval_year(S),
  NextDayOfWeek = next_day_of_week(S2#state.dayofweek),
  DaysPerMonth  = days_per_month(Current + 1),
  S3 = S2#state{dayofweek    = NextDayOfWeek, 
                dayofmonth   = 1, 
                dayspermonth = DaysPerMonth},
  eval_yearspan(First, Last, Current + 1, S3);
eval_yearspan(_,_,_,S) -> 
  S.

%% ----------------------------------
%% @doc Find all sunday-first-day-in-the-month occurrences a specific year.
%% @end
%% ----------------------------------
eval_year(S = #state{dayofmonth = 31, dayspermonth = [_|[]]}) -> % Last day of year => we are done!
  S;
eval_year(S = #state{dayofweek  = 6, dayofmonth = 1}) -> % First day of month is a sunday! => wohoo!
  NextDayOfWeek  = next_day_of_week(S#state.dayofweek),
  NextDayInMonth = S#state.dayofmonth + 1,
  Hits2          = S#state.hits + 1,
  S2             = S#state{dayofweek  = NextDayOfWeek, 
                           dayofmonth = NextDayInMonth, 
                           hits       = Hits2},
  eval_year(S2); 
eval_year(S = #state{dayofmonth = LastDayOfMonth, dayspermonth = [LastDayOfMonth|T]}) -> % Last day of month => roll over 
  NextDayOfWeek       = next_day_of_week(S#state.dayofweek),
  FirstDayInNextMonth = 1,
  DaysPerMonth        = T,
  S2                  = S#state{dayofweek    = NextDayOfWeek, 
                                dayofmonth   = FirstDayInNextMonth, 
                                dayspermonth = DaysPerMonth},
  eval_year(S2);
eval_year(S = #state{}) ->  % Just another day in life...
  NextDayOfWeek  = next_day_of_week(S#state.dayofweek),
  NextDayInMonth = S#state.dayofmonth + 1,
  S2             = S#state{dayofweek  = NextDayOfWeek, 
                           dayofmonth = NextDayInMonth},
  eval_year(S2).   

%% ----------------------------------
%% @doc Calculates the number of the next day of the week. 
%% Monday = 0, Sunday = 6.
%% @end
%% ----------------------------------
next_day_of_week(Day) -> 
  (Day + 1) rem 7.

%% ----------------------------------
%% @doc Returns a list with the number of days each month for a specific year. 
%% The output of this function will differ depending on if the year
%% is a leapyear or not.
%% @end
%% ----------------------------------
days_per_month(Year) -> 
  case is_leapyear(Year) of 
    true -> 
      ?DAYS_IN_MONTHS_LEAPYEAR;
    false ->
      ?DAYS_IN_MONTHS_NO_LEAPYEAR
  end.

%% ----------------------------------
%% @doc Tests if a year is a leapyear or not.
%% Output: leapyear => true, not a leapyear => false.
%% @end
%% ----------------------------------
is_leapyear(Year) when Year rem 4 =:= 0 -> 
	case Year rem 1000 of 
		0 ->
			case Year rem 400 of
				0 -> 
					true;
				_->
					false
			end;
		_ ->
			true
	end;
is_leapyear(_) -> 
	false.