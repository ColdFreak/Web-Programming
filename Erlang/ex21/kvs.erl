-module(kvs).
%% all exported functions are for the client to use them
-export([start/0, store/2, lookup/1]).

start() -> register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) -> rpc({store, Key, Value}).

lookup(Key) -> rpc({lookup, Key}).


rpc(Message) ->
    kvs ! {self(), Message},
    receive
        {kvs, Reply} ->
            Reply
    end.

loop() ->
    receive 
        {From, {store, Key, Value}} ->
            put(Key, {ok, Value}),
            From ! {kvs, true},
            loop();
        {From, {lookup, Key}} ->
            From ! {kvs, get(Key)}, 
            loop()
    end.
%%================================================
%% ProBox:
%% /etc/hosts
%% 192.168.100.100 AirBox
%% 192.168.100.102 ProBox
%%
%% $ erl -sname gandalf -setcookie abc
%% > kvs:start().
%%
%%
%% AirBox:
%% /etc/hosts
%% 192.168.100.100 AirBox
%% 192.168.100.102 ProBox
%%
%% $ erl -sname bilbo -setcookie abc
%% > rpc:call(gandalf@ProBox, kvs, store, [weather, cold]).
%%================================================


