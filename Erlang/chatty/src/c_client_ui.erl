-module(c_client_udp).

-export([start_link/0]).

-define(REEXPORT_0(M,F), F() -> M:F()).

?REEXPORT_0(c_client, start_link).
