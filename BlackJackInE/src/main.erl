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
-export([main/0,main2/0,main_loop/1]).


main2()->
  X=generate_deck([2,3,4,5,6,7,8,9,10,"J","Q","K","A"],[2,3,4,5,6,7,8,9,10,10,10,10,0],0),
  Y=increase_deck(X,1),%A listák 1 től vannak számozva
  Z=reduce_deck(X,13),
  io:write(X),
  io:format("\n"),
  io:write(Y),
  io:format("\n"),
  io:write(Z).


main()->
  Command=read_command("Type Start or End: "),
  main_loop(Command),
  %io:write(generate_deck([2,3,4,5,6,7,8,9,10,"J","Q","K","A"],[2,3,4,5,6,7,8,9,10,10,10,10,0],0)),
  %io:write(get_rand()),
  io:format("\n"),
  init:stop().


main_loop(Command)->
  %main_loop(inside_loop(flop())).
  if Command == "Start" -> main_loop(inside_loop());
    Command=="End" -> halt()
  end.

inside_loop()->
  InsideCommand=read_command("You can Hit/Stand/Surr "),
  if InsideCommand=="Hit" -> Points=21;  %Points=hit();
    InsideCommand=="Stand" -> Points=-1; %, dealers_round(), calculate_winner(); %jelen pillanatben meg belul kell kiirni az eredmenyt
    InsideCommand=="Surr"->Points=-1
  end,
 % NewState=PreviousState,
  if Points>21 -> io:write("You Lose with Burst"), read_command("Type Start or End: ") ;
    Points==21-> read_command("Type Start or End: "); % dealers_round(), calculate_winner(),
    Points==-1->read_command("Type Start or End: ");
    Points<21->inside_loop()
  end.


flop()->  %legeneralja  a 3 listat, egy tupltetben adja majd tovabb, csak elobb valtoztat rajtuk
  Player=generate_deck([2,3,4,5,6,7,8,9,10,"J","Q","K","A"],[2,3,4,5,6,7,8,9,10,10,10,10,0],0),
  Dealer=Player,
  Bank=generate_deck([2,3,4,5,6,7,8,9,10,"J","Q","K","A"],[2,3,4,5,6,7,8,9,10,10,10,10,0],4),
  Rand=get_rand(),
  Temp=reduce_deck(Bank,Rand),
  if Temp=/="out of cards" -> NewBank=Temp, NewPlayer=increase_deck(Player,Rand)
  end,
  Rand1=get_rand(),
  Temp1=reduce_deck(NewBank,Rand),
  if Temp1=/="out of cards" -> NewBank1=Temp1, NewPlayer1=increase_deck(NewPlayer,Rand1)
  end,
  Rand2=get_rand(),
  Temp2=reduce_deck(NewBank1,Rand),
  if Temp2=/="out of cards" -> NewBank2=Temp2, NewDealer=increase_deck(Dealer,Rand2)
  end,
  Rand3=get_rand(),
  Temp3=reduce_deck(NewBank2,Rand),
  if Temp3=/="out of cards" -> NewBank3=Temp3, NewDealer1=increase_deck(NewDealer,Rand3)
  end,
  {NewBank3,NewPlayer1,NewDealer1}.




dealers_round()->
  halt().
calculate_winner()->
  halt().
hit()->
  halt().
get_points()->
  halt().



generate_deck([],[],_)->[]; %mukodik
generate_deck([HC|Cards],[HV|Values],Amount)->
  New_element=[HC,HV,Amount],
  Result=lists:append([New_element],generate_deck(Cards,Values,Amount)),
  Result.

increase_deck(List,Index)-> %mukodik
  Part= lists:nth(Index,List),
  New=  lists:sublist(Part,2) ++  [lists:nth(3,Part)+1],
  lists:sublist(List,Index-1) ++ [New] ++ lists:nthtail(Index,List).

reduce_deck(List,Index)-> %mukodik
  Part= lists:nth(Index,List),
  Prev=lists:nth(3,Part),
  if Prev >0  ->  New=  lists:sublist(Part,2) ++  [lists:nth(3,Part)-1],
    lists:sublist(List,Index-1) ++ [New] ++ lists:nthtail(Index,List);
    true -> "out of cards"                                                       %KEZELNI KELL HA KIFOGYOTT A PAKLIT!!!
  end.

get_rand()->  %mukodik
  rand:uniform(100) rem 12.

read_command(Text)->  %mukodik
  {ok,[Command]}=io:fread(Text,"~s"),
  Command.

