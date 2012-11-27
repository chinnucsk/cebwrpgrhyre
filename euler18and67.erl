#!/usr/bin/env escript

% Problems 18 and 67: 
% By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
%    3
%   7 4
%  2 4 6
% 8 5 9 3
% That is, 3 + 7 + 4 + 9 = 23.
% Find the maximum total from top to bottom of the triangle below:
%               75
%              95 64
%             17 47 82
%            18 35 87 10
%           20 04 82 47 65
%          19 01 23 75 03 34
%         88 02 77 73 07 63 67
%        99 65 04 28 06 16 70 92
%       41 41 26 56 83 40 80 70 33
%      41 48 72 33 47 32 37 16 94 29
%     53 71 44 65 25 43 91 52 97 51 14
%    70 11 33 28 77 73 17 78 39 68 17 57
%   91 71 52 38 17 14 91 43 58 50 27 29 48
%  63 66 04 68 89 53 67 30 73 16 69 87 40 31
% 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
%
% (Triangle is in external file.)

-mode(compile).

main(_) ->
  
  Problem18File = "euler18data.txt",
  Problem67File = "euler67data.txt",

  TestTriangle       = [[3],[7,4],[2,4,6],[8,5,9,3]],
	[LastTestRow|_]    = create_acc_triangle(TestTriangle),
  AnswerTestTriangle = lists:max(LastTestRow),
  io:format("Test Triangle Answer : ~w~n", [AnswerTestTriangle]),

  Problem18Triangle = parse_problem_file(Problem18File),
  [Last18Row|_]       = create_acc_triangle(Problem18Triangle),
  Problem18Answer   = lists:max(Last18Row),
  io:format("Problem18 Answer : ~w~n", [Problem18Answer]),

  Problem67Triangle = parse_problem_file(Problem67File),
  [Last67Row|_]       = create_acc_triangle(Problem67Triangle),
  Problem67Answer   = lists:max(Last67Row),
  io:format("Problem67 Answer : ~w~n", [Problem67Answer]).

%% ----------------------------------
%% @doc Creates a new accumulated triangle.
%% @end
%% ----------------------------------
create_acc_triangle(OrigTriangle) -> 
  create_acc_triangle(OrigTriangle, []).

create_acc_triangle([H|T], []) -> % Init the algo. Just swap top of triangle.
  create_acc_triangle(T, [H]);
create_acc_triangle([], Acc) -> % End the algo. No more rows to sum.
  Acc;
create_acc_triangle(OrigTriangle, Acc) ->
  [CurrentOrigRow|T] = OrigTriangle,
  [PrevAccRow|_]     = Acc,
  NextAccRow         = create_acc_row(PrevAccRow, CurrentOrigRow),
  create_acc_triangle(T, [NextAccRow|Acc]).

%% ----------------------------------
%% @doc Creates a new accumulated row in the triangle. 
%% The row is created from the current row that is evaluated 
%% and the previous ('above' in the triangle) row. Each number 
%% in the accumulated row is the maximum of the sums of each of the
%% neighbouring numbers of the previous row with the evaluated 
%% number in the current row.
%% @end
%% ----------------------------------
create_acc_row(PrevAccRow, CurrentOrigRow) ->
  create_acc_row(PrevAccRow, CurrentOrigRow, []).

create_acc_row([HPrev|_] = PrevAccRow, [HCurr|TCurr], []) -> % Init the algo.
  Acc = HPrev + HCurr,
  create_acc_row(PrevAccRow, TCurr, [Acc]);
create_acc_row([HPrev|[]], [HCurr|[]], AccRow) -> % Last number in both rows. End the algo.
  Acc     = HPrev + HCurr,
  AccRow2 = [Acc|AccRow],
  lists:reverse(AccRow2);
create_acc_row(PrevAccRow, CurrentOrigRow, Acc) ->
  [HPrev1|TPrev] = PrevAccRow,
  [HPrev2|_]     = TPrev,
  [HCurr|TCurr]  = CurrentOrigRow,
  Sum1           = HCurr + HPrev1,
  Sum2           = HCurr + HPrev2,
  MaxSum         = eulerlib:max(Sum1, Sum2),
  create_acc_row(TPrev, TCurr, [MaxSum|Acc]).

%% ----------------------------------
%% @doc Parses the file containig the problem data.
%% @end
%% ----------------------------------
parse_problem_file(Filename) ->
  {ok, IoDevice} = file:open(Filename, [read]),
  parse_problem_file(IoDevice, []).

parse_problem_file(IoDevice, Acc) ->
  case file:read_line(IoDevice) of
    {ok, Data} ->
      Data2    = string:strip(Data, right, $\n),
      Data3    = string:tokens(Data2, " "),
      IntList  = [list_to_integer(X) || X <- Data3],
      parse_problem_file(IoDevice, [IntList|Acc]);
    eof ->
      lists:reverse(Acc);
    _ ->
      io:write("Errrrrrror when parsing file~n"),
      error
  end. 