-module(pmap).
-export([pmap/2, timesTow/1]).

pmap(Function, List) ->
    %% spawnされたプロセスが計算を行った後Selfに結果を送る
    Self = self(),
    Pids = lists:map(fun(E1) -> spawn(
                                  fun() -> execute(Self, Function, E1) end) end, List),
    gather(Pids).

execute(To, Function, Element) ->
    To ! {self(), Function(Element)}.

%% 計算結果を回収する
gather([]) ->
    [];
gather([From|Rest]) ->
    receive

        {From, Ret} ->
            [Ret|gather(Rest)]
    end.

%% test function for pmap
timesTow(N) ->
    N * 2.

%% Usage
%% pmap:pmap(fun pmap:timesTwo/1, [1,2,3,4,5,6,7,8,9]).
