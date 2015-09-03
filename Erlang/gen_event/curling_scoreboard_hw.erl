%% @doc このモジュールはいんたーふぇのようなもの
-module(curling_scoreboard_hw).
-export([add_point/1, next_round/0, set_teams/2, reset_board/0]).

%% @doc チームの追加イベント
set_teams(TeamA, TeamB) ->
    io:format("Scoreboard: Team ~s vs. Team ~s~n", [TeamA, TeamB]).

%% @doc ポイント設定イベント
add_point(Team) ->
    io:format("Scoreboard: increased score of team ~s by 1~n", [Team]).

%% @doc 次のラウンドへの移行イベント
next_round() ->
    io:format("Scoreboard: round over").
    
%% @doc 新しい試合を始めるときに使うだけ
%% プロトコルの一部である必要はない
reset_board() ->
    io:format("Scoreboard: All teams are undefined and all scores are 0~n").



