-module(funs_server).
-export([start/0, find_list_max/2, loop/0]).

start() -> spawn(fun loop/0).

find_list_max(Pid, What) ->
    rpc(Pid, What).

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
        Response ->
            Response
    end.

loop() ->
    receive
        {From, L} ->
            From ! funs:list_max(L),
            loop()
    end.

