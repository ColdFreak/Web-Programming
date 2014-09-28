-module(funs).
-export([list_max/1, str_word_count/1, file_count_chars/1,str_cap_first/1, capitalize/1, remainder/2, atoi/1, escape_html/1, titlecase/1]).

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% あまりを求める関数remainder(A,B)
%% 11> timer:tc(funs, remainder, [20000000001,20]). 
%% {11397368,1}
%% 10秒以上かかる

remainder(A, B) when A >= B ->
    remainder(A-B, B);
remainder(A, _B) ->
    A.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Count characters in a file
file_count_chars(Fname) ->
    case file:open(Fname, [read, raw, binary]) of
        {ok, Fd} ->
            Res = scan_file(Fd, 0, file:read(Fd, 1024)),
            file:close(Fd),
            Res;
        {error, Reason} ->
            {error, Reason}
    end.

scan_file(Fd, Acc, {ok, Binary}) ->
    scan_file(Fd, Acc + count_x(Binary), file:read(Fd, 1024));

scan_file(Fd, Acc, eof) ->
    file:close(Fd),
    Acc;

scan_file(Fd, _Acc, {error, Reason}) ->
    file:close(Fd),
    {error, Reason}.

%% ヘルパー関数
count_x(Binary) ->
    count_x(binary_to_list(Binary), 0).

count_x([], Acc) ->
    Acc;
count_x([$x|Tail], Acc) ->
    count_x(Tail, Acc+1);
count_x([_|Tail], Acc) ->
    count_x(Tail, Acc).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

capitalize(C) when C >= $a, C =< $z ->
    C2 = C - ($a-$A),
    C2;
capitalize(C) when C >= $A, C =< $Z ->
    C.

%% 文字列を渡したら、str_cap_first/3を呼び出す。
str_cap_first(Input) ->
    str_cap_first(Input, [], 0).

%% 文字列を空になったら、順番を逆にして、出力
str_cap_first([], Acc, _State) ->
    lists:reverse(Acc);

%% 最後1文字残るときに
str_cap_first([Last], Acc, State) when Last =/= $\ , State =:= 0 ->
    lists:reverse([capitalize(Last)|Acc]);

%% 文字列最初から文字から始まる場合(State = 0)
str_cap_first([First, Second|Tail], Acc, State) when First =/= $\ , State =:= 0 ->
    str_cap_first([Second|Tail], [capitalize(First)|Acc], 1);

%% 連続の文字の場合（Stateはすでに１になっている）
str_cap_first([First, Second|Tail], Acc, State) when First =/= $\ , State =:= 1  ->
    str_cap_first([Second|Tail], [First|Acc], 1);

%% スペースの文字の境界線の場合
str_cap_first([First, Second|Tail], Acc, _State) when First =:= $\ , Second =/= $\  ->
    str_cap_first(Tail, [capitalize(Second) ,First|Acc], 1);

%% 連続スペースの場合
str_cap_first([First|Tail], Acc, State) when First =:= $\ ,State =:= 0  ->
    str_cap_first(Tail, [First|Acc], 0);

str_cap_first([First|Tail], Acc, State) when State =:= 1  ->
    str_cap_first(Tail, [First|Acc], 0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 文字列を数字に変換する
%% 
%% atoi([$\ | Input]) ->  -1 * atoi(Input, 0);
%% 上の行はatoi(Input)         -> atoi(Input, 0).の下に置いたらだめ
%% atoi(Input)         -> atoi(Input, 0).はいつもマッチングされるから
%% 要は具体的なマッチング変数を前に置くこと
atoi([$- | Input])  -> -1 * atoi(Input, 0);
atoi(Input)         -> atoi(Input, 0).

atoi([Head|Tail], Acc) when Head >= $1, Head =< $9 ->
    atoi(Tail, Acc * 10 + (Head - $0) );
atoi([], Acc) ->
    Acc.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HTMLの'<', '>'を'&lt;', '&gt;'に変換する関数escape_html/1
%% 目標時は"<p>"を";tg&p;tl&" に変換して、reverseをかける
%% lists:reverse("&lt;", Acc)の結果はもともとリストなので、
%% もう一回[lists:reverse("&lt;", Acc)]する必要はない
%%
escape_html(Input) ->
    escape_html(Input, []).

escape_html([], Acc) ->
    lists:reverse(Acc);
escape_html([$< | T], Acc) ->
    escape_html(T, lists:reverse("&lt;", Acc));
escape_html([$> | T], Acc) ->
    escape_html(T, lists:reverse("&gt;", Acc));
escape_html([$& | T], Acc) ->
    escape_html(T, lists:reverse("&amp;", Acc));
escape_html([H | T], Acc) ->
    escape_html(T, [H|Acc]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 上のstr_cap_stringよりいい
titlecase(String) ->
    titlecase(String, []).

titlecase([], Output) ->
    lists:reverse(Output);

titlecase([Char | Rest], [] = Output) when Char >= $a, Char =< $z ->
    titlecase(Rest, [Char + ($A - $a) | Output]);

%% ここが賢い、残りを比べるだけではなく、すで比べたのもパターンマッチングする
titlecase([Char | Rest], [$\  |_] = Output) when Char >= $a, Char =< $z ->
    titlecase(Rest, [Char + ($A - $a) | Output]);

titlecase([Char | Rest], Output) ->
    titlecase(Rest, [Char | Output]).
