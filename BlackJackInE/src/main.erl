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
-export([main/0,get_points/2]).

main() ->
  Command = read_command("Type Start or End: "),
  main_loop(Command),
  io:format("\n"),
  init:stop().


main_loop(Command) ->
  if
    Command == "Start" -> main_loop(inside_loop(flop()));
    true -> halt()
  end.

inside_loop(Tuple) ->

  InsideCommand = read_command("You can Hit/Stand/Surr "),
  if
    InsideCommand == "Hit" -> NewTuple = hit(Tuple), {_, Player, _} = NewTuple, Points = get_points(Player, 0);
    InsideCommand == "Stand" -> NewTuple = Tuple, Points = -1;
    InsideCommand == "Surr" -> NewTuple = Tuple, Points = -1;
    true -> Points = -1, NewTuple = Tuple
  end,
  if
    InsideCommand == "Surr" -> read_command("Type Start or End: ");
    InsideCommand == "Stand" -> DR = dealers_round(NewTuple), position(DR), calculate_winner(DR),
      read_command("Type Start or End: ");
    Points > 21 -> io:format("You Lose with Burst\n"),
      read_command("Type Start or End: ");                %ez minden listara igaz lenne!
    Points == 21 -> DR = dealers_round(NewTuple), position(DR), calculate_winner(DR),
      read_command("Type Start or End: ");
    InsideCommand == "Hit" -> inside_loop(NewTuple);  %eddigre lekezeltem ha mast kene csinalni
    true -> read_command("Type Start or End: ")
  end.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

position(Tuple) ->      %mukodik, kiirja  a konzolra az allast
  io:format("######################################################################################################\n"),
  {_, Player, Dealer} = Tuple,
  io:format("A Player pontszama es kartyai: "),
  io:write(get_points(Player, 0)),
  io:format("\n"),
  write_out_cards(Player),
  io:format("A Dealer pontszama es kartyai: "),
  io:write(get_points(Dealer, 0)),
  io:format("\n"),
  write_out_cards(Dealer).

write_out_cards([]) -> [];
write_out_cards([H | T]) ->
  [CardType, _, CardAmount] = H,
  if CardAmount > 0 -> io:format("~p", CardType), io:format(" X "), io:write(CardAmount), io:nl();
    true -> []
  end,
  write_out_cards(T).

calculate_winner(Tuple) ->      %a dealer es a player pontszamai alapjan eldonti a gyoztest
  {_, Player, Dealer} = Tuple,
  DealersPoints = get_points(Dealer, 0),
  PlayersPoints = get_points(Player, 0),
  if
    DealersPoints > 21 -> io:format("You won\n");
    DealersPoints < 22 -> if
                            DealersPoints >= PlayersPoints -> io:format("The Bank won!\n");
                            true -> io:format("You won\n")
                          end
  end.

dealers_round(Tuple) ->
  {Bank, Player, Dealer} = Tuple,
  DealersPoints = get_points(Dealer, 0),
  if
    DealersPoints < 17 ->
      Rand = get_rand(),
      NewBank = reduce_deck(Bank, Rand),
      if
        NewBank =/= "out of cards" -> NewDealer = increase_deck(Dealer, Rand), NewTuple = {NewBank, Player, NewDealer};
        true -> NewTuple = dealers_round(Tuple)
      end,
      Result = dealers_round(NewTuple);
    DealersPoints > 16 ->
      Result = Tuple
  end,
  Result.



hit(Tuple) ->  %mukodik, a bank-bol atrak egy lapot a player-be
  {Bank, Player, Dealer} = Tuple,
  Rand = get_rand(),
  NewBank = reduce_deck(Bank, Rand),
  if
    NewBank =/= "out of cards" -> NewPlayer = increase_deck(Player, Rand), NewTuple = {NewBank, NewPlayer, Dealer};
    true -> NewTuple = hit(Tuple)
  end,
  position(NewTuple),
  NewTuple.

get_points([[[_], _, AceAmount] | []], PrevPoints) ->     %mukodik, visszaadja a kapott pakli erteket
  if
    (PrevPoints + AceAmount * 11) < 22 -> (PrevPoints + AceAmount * 11);
    true -> (PrevPoints + AceAmount * 1)
  end;
get_points([H | T], PrevPoints) ->
  [_, CardValue, CardAmount] = H,
  ThisCardPoints = CardValue * CardAmount,
  NextCards = get_points(T, ThisCardPoints + PrevPoints),
  NextCards.

flop() ->  %mukodik, legeneralja  a 3 listat, egy tupltetben adja majd tovabb, csak elobb valtoztat rajtuk, /meg biztos nem fogy ki egy kartyafajta/
  Player = generate_deck([[2], [3], [4], [5], [6], [7], [8], [9], [10], [jack], [queen], [king], [ace]], [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1], 0),
  Dealer = Player,
  Bank = generate_deck([[50], 3, 4, 5, 6, 7, 8, 9, 10, [jack], [queen], [king], [ace]], [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1], 4),
  Rand = get_rand(),
  Rand1 = get_rand(),
  Rand2 = get_rand(),
  Rand3 = get_rand(),
  NewBank = reduce_deck(reduce_deck(reduce_deck(reduce_deck(Bank, Rand), Rand1), Rand2), Rand3),
  NewPlayer = increase_deck(increase_deck(Player, Rand), Rand1),
  NewDealer = increase_deck(increase_deck(Dealer, Rand2), Rand3),
  NewTuple = {NewBank, NewPlayer, NewDealer},
  position(NewTuple),
  NewTuple.

generate_deck([], [], _) ->
  []; %mukodik, a kapott parameterek alapjan elkesziti a megfelelo szintaktikaju listak listajat
generate_deck([HC | Cards], [HV | Values], Amount) ->
  New_element = [HC, HV, Amount],
  Result = lists:append([New_element], generate_deck(Cards, Values, Amount)),
  Result.

increase_deck(List, Index) -> %mukodik, a kapott pakliban noveli az index altal meghatarozott kartyafajta mennyiseget
  Part = lists:nth(Index, List),
  New = lists:sublist(Part, 2) ++ [lists:nth(3, Part) + 1],
  lists:sublist(List, Index - 1) ++ [New] ++ lists:nthtail(Index, List).

reduce_deck(List, Index) -> %mukodik, a kapott pakliban csokkenti az index altal meghatarozott kartyafajta mennyiseget
  Part = lists:nth(Index, List),
  Prev = lists:nth(3, Part),
  if
    Prev > 0 -> New = lists:sublist(Part, 2) ++ [lists:nth(3, Part) - 1],
      lists:sublist(List, Index - 1) ++ [New] ++ lists:nthtail(Index, List);
    true -> "out of cards"                                                       %KEZELNI KELL HA KIFOGYOTT A PAKLIT!!!
  end.

get_rand() ->  %mukodik
  (((rand:uniform(100) + rand:uniform(17)) * rand:uniform(20)) rem 13) + 1.

read_command(Text) ->  %mukodik, parameterben kapott string kiirasaval ker be egy masik sztringet
  {ok, [Command]} = io:fread(Text, "~s"),
  Command.

