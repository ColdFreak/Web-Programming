-module(ppool_supersup).
-behaviour(supervisor).
-export([start_link/0, stop/0, start_pool/3, stop_pool/1]).
-export([init/1]).

start_link() ->
    % We gave the top level pool supervisor the name ppool
    % We only have one ppool per Erlang node
    supervisor:start_link({local, ppool}, ?MODULE, []).

%% kill the supervisor brutally
stop() ->
    case whereis(ppool) of
        % Erlangに大文字は任意の変数こと
        P when is_pid(P) ->
            exit(P, kill);
        _ ->
            ok
    end.

init([]) ->
    MaxRestart = 6,
    MaxTime = 3600,
    % init(Args) -> Result
    % Result = {ok, {{RestartStrategy, MaxT, MaxT}, [ChildSpec]}} | ignore
    {ok, {{one_for_one, MaxRestart, MaxTime}, []}}.
