-module(dist_demo).
-export([rpc/4, start/1]).

start(Node) ->
    %% Returns the pid of a new process started 
    %% by the application of Fun to the empty 
    %% list [] on Node. 
    spawn(Node, fun() -> loop() end).

rpc(Pid, M, F, A) ->
    Pid ! {rpc, self(), M, F, A},
    receive
        {Pid, Response} ->
            Response
    end.

loop() ->
    receive
        {rpc, From, M, F, A} ->
            From ! {self(), (catch apply(M,F,A))},
            loop()
    end.

%% ProBox:
%% erl -sname gandalf -setcookie abc
%%
%% AirBox:
%% erl -sname bilbo -setcookie abc
%% 
%% 1> Pid = dist_demo:start('gandalf@ProBox').
%% 2> dist_demo:rpc(Pid, erlang, node, []).
%%

