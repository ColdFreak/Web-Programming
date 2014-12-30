-module(hello_cowboy_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', 
              [
                {"/", cowboy_static, {priv_file, hello_cowboy, "index.html"}}
              ]
        }
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, 8080}], 
                                [ 
                                    {env, [{dispatch, Dispatch} ] }
                                ]),

    hello_cowboy_sup:start_link().

stop(_State) ->
    ok.
