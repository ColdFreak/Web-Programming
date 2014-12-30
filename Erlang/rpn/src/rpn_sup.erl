-module(rpn_sup).
-author("Wang Zhijun").
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    io:format("~p (~p) starting...~n",[{local, ?MODULE}, self()]),

    RestartStrategy = one_for_one,
    MaxRestarts = 5,
    MaxSecondsBetweenRestarts = 10,
    Flags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

    Restart = permanent,
    Shutdown = infinity,
    Type = worker,

    ChildSpecifications = {rpn_server, {rpn_server, start_link, []}, Restart, Shutdown, Type, [rpn_server]},
    {ok, { Flags, 
          [ChildSpecifications]
         }
    }.

