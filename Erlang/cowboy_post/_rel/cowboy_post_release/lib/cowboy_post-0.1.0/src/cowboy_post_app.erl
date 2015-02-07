-module(cowboy_post_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch =  cowboy_router:compile([
        {'_', [
                {"/", cowboy_static, {file, "/Users/wzj/Projects/Web-Programming/Erlang/cowboy_post/priv/static/index.html"}},
                {"/process", toppage_handler, []}
              ]
        }
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
        {env, [{dispatch, Dispatch}]}
    ]),
	cowboy_post_sup:start_link().

stop(_State) ->
	ok.
