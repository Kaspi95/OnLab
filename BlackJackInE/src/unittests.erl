%%%-------------------------------------------------------------------
%%% @author Bence
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. Nov 2018 19:56
%%%-------------------------------------------------------------------
-module(unittests).
-author("Bence").

-include_lib("eunit/include/eunit.hrl").

get_point_on_Bank_at_start_test() ->
  X=main:get_points([[[50],2,4],[3,3,4],[4,4,4],[5,5,4],[6,6,4],[7,7,4],[8,8,4],[9,9,4],[10,10,4],[[jack],10,4],[[queen],10,4],[[king],10,4],[[ace],1,4]],0),
  ?assertEqual(X,340).

get_point_on_Player_at_start_test() ->
  X=main:get_points([[[50],2,0],[3,3,0],[4,4,0],[5,5,0],[6,6,0],[7,7,0],[8,8,0],[9,9,0],[10,10,0],[[jack],10,0],[[queen],10,0],[[king],10,0],[[ace],1,0]],0),
  ?assertEqual(X,0).

get_point_on_Player_in_game_test() ->
  X=main:get_points([[[50],2,0],[3,3,0],[4,4,1],[5,5,0],[6,6,0],[7,7,0],[8,8,1],[9,9,0],[10,10,0],[[jack],10,0],[[queen],10,0],[[king],10,0],[[ace],1,1]],0),
  ?assertEqual(X,13).