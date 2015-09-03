%% @doc イベントハンドラを実装
-module(curling_scoreboard).
-behaviour(gen_event).

-export([init/1, handle_event/2, handle_call/2, handle_info/2, code_change/3, terminate/2]).

init([]) ->
    {ok, []}.

%% @doc gen_eventのコールバックモジュールの核となるものです。
%% 非同期に働くという点で、gen_serverのhandle_cast/2と似た動作をする
%% 戻り値は{ok, NewState, hibernate}の場合は、イベントマネージャ全体が
%% ハイバネートすることになる
handle_event(_, State) ->
    {ok, State}.

handle_call(_, State) ->
    {ok, ok, State}.

handle_info(_, State) ->
    {ok, State}.

%% @doc 個々のイベントハンドラに対してのもの
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.

