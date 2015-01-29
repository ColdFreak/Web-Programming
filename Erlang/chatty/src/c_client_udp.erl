-module(c_client_udp).

-export([start_link/0]).

-define(REEXPORT_0(M,F), F() -> M:F()).
-define(REEXPORT_2(M,F), F() -> M:F(A0, A1)).

connect(ClientPid, ServerAddr) ->
    {ok, ServerPid} = c_server_udp:get_pid(ServerAddr),
    c_client:connect(ClientPid, ServerPid).

?REEXPORT_0(c_client, start_link).


