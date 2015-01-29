-module(c_server).
-behavior(gen_server).

-export([ start_link/0 ]).

-record(state, {clients}).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

init([]) ->
    {ok, #state{clients = dict:new()}}.
