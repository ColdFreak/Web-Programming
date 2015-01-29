-module(c_server_udp).
-behavior(gen_server).
-export([ start_link/0 ]).

-include("c_server_protocol.hrl").
-record(state, {port, server_core}).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

init([]) ->
    %% dict:new()ストレージを用意
    {ok, ServerCore} = c_server:start_link(),
    {ok, #state{
            %% 受け取るデータはバイナリ型と指定する
            port = gen_udp:open(?SERVER_PORT_NUMBER, [binary]),
            server_core = ServerCore
           }
    }.

