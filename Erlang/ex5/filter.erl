-module(filter).
-compile(export_all).

%%==============================================================================
%% case ... of ... end でfilter(F, L)を実装する
%% example:
%% 1> filter:filter(fun(X) -> is_number(X) end, [1,2,3,4,5, [d,d], 8]).
%% [1,2,3,4,5,8]
%%==============================================================================
filter(F, [Head | Tail]) ->
    case F(Head) of
        true    -> [Head | filter(F, Tail)];
        false   -> filter(F, Tail)
    end;
filter(_, [])->
    [].
