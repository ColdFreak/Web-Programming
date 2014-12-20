-module(calc).

-export([rpn/1]).

rpn(L) when is_list(L) ->
    [Res] = lists:foldl(fun rpn/2, [], string:tokens(L, " ")),
    Res.

read(N) ->
    case string:to_float(N) of
        {error, no_float} ->
            list_to_integer(N);
        {F, _} ->
            F
    end.

rpn("+", [N1, N2|S]) -> [N2 + N1|S];
rpn("-", [N1, N2|S]) -> [N2 - N1|S];
rpn("*", [N1, N2|S]) -> [N2 * N1|S];
rpn("/", [N1, N2|S]) -> [N2 / N1|S];
rpn("^", [N1, N2|S]) -> [math:pow(N2, N1)|S];
rpn("ln", [N|S])     -> [math:log(N)|S];
rpn("log10", [N|S])  -> [math:log10(N)|S];
% sumの場合も同じで、戻り値はfoldlの二個目の引数を書き換える
% 要はアキュミュレータは足されていく
rpn("sum", Stack)    -> [lists:sum(Stack)];
rpn(X, Stack)        -> [read(X) | Stack].
