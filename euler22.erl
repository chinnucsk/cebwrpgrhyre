#! /usr/bin/env escript

% Using euler22data.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, 
% begin by sorting it into alphabetical order. 
% Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
% For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. 
% So, COLIN would obtain a score of 938 × 53 = 49714. What is the total of all the name scores in the file?

-mode(compile).

-define(ASCII_ALPHA_DIFF, 64). % The diff between a names ascii decimal value and its alphabetical "score".

main(_) ->
	Names        = parse_file("euler22data.txt"),
  NamesSorted  = lists:sort(Names),
  ListOfScores = list_of_scores(NamesSorted),
  Ans          = total_score(ListOfScores),
  io:format("Names: ~p~n", [Ans]).

list_of_scores(NamesSorted) -> 
  [name_to_score(X) || X <- NamesSorted].

name_to_score(Name) ->
  LetterValues = [X - ?ASCII_ALPHA_DIFF || X <- Name],
  lists:sum(LetterValues).

total_score(ListOfScores) -> 
  total_score(ListOfScores, 1, []).

total_score([], _, Acc) ->
  lists:sum(Acc);
total_score([H|T], Idx, Acc) ->
  total_score(T, Idx + 1, [H*Idx|Acc]). 

parse_file(Filename) -> 
  {ok, [ListOfNames]} = file:consult(Filename),
  ListOfNames.