-module(pythag).
-compile(export_all).

%%===============================
%% A^2 + B^2 = C^2を満たし、各辺
%% の和がN以下であるような整数
%% {A,B,C}をすべて含むリストを
%% 生成する
%%===============================
pythag(N) ->
    [{A, B, C} || 
     A <- lists:seq(1, N),
     B <- lists:seq(1, N),
     C <- lists:seq(1, N),
     A*A+B*B=:=C*C,
     A+B+C < N].

