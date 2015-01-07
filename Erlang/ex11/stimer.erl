-module(stimer).
-compile(export_all).

start(Time, Fun) ->
    spawn(fun() -> timer(Time, Fun) end).

cancel(Pid) -> Pid ! cancel.

%% Time時間以内に'cancel'を送らないとFun()関数が実行されてしまう
timer(Time, Fun) ->
    receive 
        cancel -> 
            void
    after Time ->
          Fun()
    end.
