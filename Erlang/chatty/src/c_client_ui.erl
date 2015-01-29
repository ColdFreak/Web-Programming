-module(c_client_ui).
-export([main/2]).

main(ServerAddr, Name) ->
    {ok, Client} = c_client_udp:start_link(),
    c_client_udp:connect(Client, ServerAddr),
