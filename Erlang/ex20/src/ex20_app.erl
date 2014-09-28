-module(ex20_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    %% map the path '/' to the handler module 'hello_handler'
    Dispatch = cowboy_router:compile([
                {'_', [{"/", hello_handler, []}]}
                ]),
    cowboy:start_http(my_http_listener, 100, [{port, 8080}],
                      [{env, [{dispatch, Dispatch}]}]
                     ),

	ex20_sup:start_link().

stop(_State) ->
	ok.
