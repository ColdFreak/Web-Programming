-module(c_client).
-behavior(gen_server).

-export([ start_link/0 ]).
-record(state, {name, server}).
start_link() ->
    gen_server:start_link(?MODULE, [], []).

init([]) ->
    %% Todo: クライアント側のレコードの意味?
    {ok, #state{}}.
