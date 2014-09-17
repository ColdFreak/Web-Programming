-module(on_exit).
-compile(export_all).

%% お互いにlinkしているプロセスで
%% AがBからexitシグナルを受け取ったら処理する
%% ハンドラー
on_exit(Pid, Fun) ->
    spawn(fun() ->
                  %% process_flag() turns the spawned
                  %% process into a system process
                  process_flag(trap_exit, true),
                  link(Pid),
                  receive
                      {'EXIT', Pid, Why} ->
                          Fun(Why)
                  end
          end).
%% to test this, 
%% 1> F = fun() ->
%%          receive
%%              X -> list_to_atom(X)
%%              end
%%          end.
%% 2> Pid = spawn(F).
%% 3> on_exit:on_exit(Pid, fun(Why) -> io:format("~p died with: ~p~n", [Pid, Why]) end).
%% 4> Pid ! hello.
