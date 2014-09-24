-module(funs).
-export([list_max/1, str_word_count/1]).

%% 空のリストを処理するコードがないと
%% funs:list_max([]). で実行するとき、エラーが出る
list_max([]) ->
    void;
%% 最初のうち引数に[H|T]という形で(max(L))ではなく)
%% 書くとプログラム全体が書きやすくなる
list_max([H|T]) ->
    list_max(H, T).

list_max(M, []) ->
    M;
list_max(M, [H|T]) when H > M ->
    list_max(H, T);
%% パターンマッチングなので、下の2行がないと
%% [4,5,1,9]というような場合は処理できない
%% なぜかというと[5 |[1,9]]になると
%% 1(H)が5(M)より大きくないから、そのようなパターンを処理するコードはない
%% なので、エラーがでる
%% 下の2行はそのようなパターンを処理するから
list_max(M, [_H|T]) ->
    list_max(M, T).


%% 文字列のword数をカウントするプログラムで
%% やり方はワードとスペースの境界線のところで
%% カウントをプラス１
str_word_count(Input) ->
    str_word_count(Input, 0).
str_word_count([], Count) ->
    Count;
str_word_count([Last], Count) when Last =/= $\ ->
    Count+1;
str_word_count([First, Second | Tail], Count)  when First =/= $\ , Second =:= $\ ->
    str_word_count([Second|Tail], Count+1);
str_word_count([_|Tail], Count) ->
    str_word_count(Tail, Count).

