-module(rpn_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% アプリケーションを起動
%% > application:start(rpn).
%% ここの'rpn'はrpn.app.srcに登録された名前
%% ===================================================================

start(_StartType, _StartArgs) ->
    case rpn_sup:start_link() of
        {ok, Pid} -> 
            {ok, Pid};
        Other ->
            {error, Other}
    end.

stop(_State) ->
    ok.
