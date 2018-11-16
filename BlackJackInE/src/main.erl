%%%-------------------------------------------------------------------
%%% @author Bence
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Nov 2018 20:00
%%%-------------------------------------------------------------------
-module(main).
-author("Bence").

%% API
-export([main/0]).


main()->
  %Command=read_command("Type Start or End: "),
  %main_loop(Command),
  %io:write(generate_deck([2,3,4,5,6,7,8,9,10,"J","Q","K","A"],[2,3,4,5,6,7,8,9,10,10,10,10,0],0)),
  io:write(get_rand()),
  io:format("\n"),
  init:stop().


main_loop(Command)->
  if Command == "Start" -> main_loop(inside_loop(flop()));
    true->halt()
  end.

inside_loop(PreviousState)->
  InsideCommand=read_command("You can Hit/Stand/Surr "),
  if InsideCommand=="Hit" -> Points=hit();
    InsideCommand=="Stand" -> Points=-1, dealers_round(), calculate_winner(); %jelen pillanatben meg belul kell kiirni az eredmenyt
    InsideCommand=="Surr"->Points=-1
  end,
  NewState=PreviousState,
  if Points>21 -> io:write("You Lose with Burst"), read_command("Type Start or End: ") ;
    Points==21->dealers_round(), calculate_winner(), read_command("Type Start or End: ");
    Points==-1->read_command("Type Start or End: ");
    Points<21->inside_loop(NewState)
  end.

generate_deck([],[],_)->[];
generate_deck([HC|Cards],[HV|Values],Amount)->
  New_element=[HC,HV,Amount],
  Result=lists:append([New_element],generate_deck(Cards,Values,Amount)),
  Result.

increase_deck([H|T],Index)->
  if Index=/=0->
    increase_deck(T,Index-1);
    Index==0->halt()
  end.



      reduce_deck([H|T],Index)->
halt().





flop()->
  halt().

dealers_round()->
  halt().
calculate_winner()->
  halt().
hit()->
  halt().
get_points()->
  halt().


get_rand()->
  rand:uniform(100) rem 12.

read_command(Text)->
  {ok,[Command]}=io:fread(Text,"~s"),
  Command.

% io:write(read_command()).
% Y=io:get_line("Enter a string"),  %hozzaolvas egy ujsor karaktert is!
%io:write(Y),
%io:format("~s",[X]),  %stringkent irja ki, de dupla []-ben kell lennie!
%io:format("~nmukodj!").