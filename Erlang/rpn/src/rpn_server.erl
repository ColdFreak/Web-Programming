-module(rpn_server).
-behaviour(gen_server).

-record(state, {}).
-export([start_link/0, cal_rpn/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% start_link(ServerName, Module, Args, Options) -> Result
%% Module is the name of the callback module.
%% Args is an arbitrary term which is passed as the argument to Module:init/1.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [],[]).
stop() ->
    gen_server:cast({local, ?MODULE}, stop).

init([]) ->
    {ok, #state{}}.

cal_rpn(L) ->
    gen_server:call(?MODULE, {cal_rpn, L}).

handle_call({cal_rpn, L}, _From, _State) ->
    Reply = do_rpn(L),
    {reply, Reply, _State}.
handle_cast(_Msg, State) ->
    {noreply, State}.
handle_info(_Info, State) ->
    {noreply, State}.

do_rpn(L) when is_list(L) ->
    [Res] = lists:foldl(fun do_rpn/2, [], string:tokens(L, " ")),
    Res.

read(N) ->
    case string:to_float(N) of
        {error, no_float} ->
            list_to_integer(N);
        {F, _} ->
            F
    end.

do_rpn("+", [N1, N2|S]) -> [N2 + N1|S];
do_rpn("-", [N1, N2|S]) -> [N2 - N1|S];
do_rpn("*", [N1, N2|S]) -> [N2 * N1|S];
do_rpn("/", [N1, N2|S]) -> [N2 / N1|S];
do_rpn("^", [N1, N2|S]) -> [math:pow(N2, N1)|S];
do_rpn("ln", [N|S])     -> [math:log(N)|S];
do_rpn("log10", [N|S])  -> [math:log10(N)|S];
% sumの場合も同じで、戻り値はfoldlの二個目の引数を書き換える
% 要はアキュミュレータは足されていく
do_rpn("sum", Stack)    -> [lists:sum(Stack)];
do_rpn(X, Stack)        -> [read(X) | Stack].



terminate(_Reason, _State) ->
    io:format("terminating ~p~n", [{local, ?MODULE}]),
    ok.
code_change(_OldVersion, State, _Extra) ->
    {ok, State}.
