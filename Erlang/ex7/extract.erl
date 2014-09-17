-module(extract).
-compile(export_all).

%%==============================================================================
%% attrs.erlのmodule_info()をparseするプログラム
%%==============================================================================
extract(F, Key) ->
    case beam_lib:chunks(F, [attributes]) of
        {ok, {_Module, [{attributes, L}]}} ->
            case lookup(Key, L) of
                {ok, Val} ->
                    Val;
                error ->
                    exit(badAttribute)
            end;
        _   ->
            exit(badFile)
    end.

%%==============================================================================
%% まずマッチングできるパターン作成
%% 次にマッチングできないときは再帰的にlookup()を呼び出し
%% 最後はKeyなんであれ、リストが空になったらerrorを出す。
%% 2節目を１節目の置いていたら、いつでもマッチングできてしまう
%%==============================================================================
lookup(Key, [{Key, Value}|_]) ->
    {ok, Value};
lookup(Key, [_ | T]) ->
    lookup(Key, T);
lookup(_, []) ->
    error.






