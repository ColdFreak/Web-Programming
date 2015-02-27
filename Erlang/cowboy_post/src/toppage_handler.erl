%% Feel free to use, reuse and abuse the code in this file.

-module(toppage_handler).

-export([init/2]).


-include_lib("stdlib/include/qlc.hrl").

init(Req, Opts) ->
    Method = cowboy_req:method(Req),
    HasBody = cowboy_req:has_body(Req),
    Req2 = maybe_echo(Method, HasBody, Req),
    {ok, Req2, Opts}.

maybe_echo(<<"POST">>, true, Req) ->
    {ok, PostVals, Req2} = cowboy_req:body_qs(Req),
    Echo = proplists:get_value(<<"echo">>, PostVals),
    Result = do_rpn(Echo),
    echo(Result, Req2);
maybe_echo(<<"POST">>, false, Req) ->
    cowboy_req:reply(400, [], <<"Missing body.">>, Req);
maybe_echo(_, _, Req) ->
    %% Method not allowed.
    cowboy_req:reply(405, Req).

echo(undefined, Req) ->
    cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req);
echo(Echo, Req) ->
    cowboy_req:reply(200, [
        {<<"content-type">>, <<"text/plain; charset=utf-8">>}
    ], Echo, Req).

do_rpn(B) when is_binary(B) ->
    L = binary_to_list(B),
    [Res] = lists:foldl(fun do_rpn/2, [], string:tokens(L, " ")),
    R = list_to_binary(integer_to_list(Res)),
    R.

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

