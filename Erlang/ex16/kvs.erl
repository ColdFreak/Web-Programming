-module(kvs).
-export([start/0, store/2, lookup/1]).

start() ->
    register(kvs, spawn(fun() -> loop() end)).

%% クライアントはどのプロセスに
%% リクエストを送るかは興味ないから
%% 誰に送るかという情報はrpc()の内部
%% で実装する
store(Key, Value) ->
    rpc({store, Key, Value}).
lookup(Key) ->
    rpc({lookup, Key}).

rpc(Q) ->
    kvs ! {self(), Q},
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

%% 1> kvs:start().
%% true
%% 2> kvs:store({location, joe}, "Stockholm").
%% true
%% 3> kvs:store(weather, raining).
%% true
%% 4> kvs:lookup(weather).
%% {ok,raining}
%% 5> kvs:lookup({location, joe}).
%% {ok,"Stockholm"}
%% 6> kvs:lookup({location, jane}).
%% undefined
%% 7>

