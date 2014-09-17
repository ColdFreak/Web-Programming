-module(clock).
-compile(export_all).

%% Time時間後、Fun関数が実行される
start(Time, Fun) ->
    register(clock, spawn(fun() -> tick(Time, Fun) end)).

stop() ->
    clock ! stop.

tick(Time, Fun) ->
    receive
        stop ->
            void
    after Time ->
        Fun(),
        tick(Time, Fun)
    end.

%% Erlang Shellで実行したい関数を指定する
%% 5> clock:start(5000, fun() -> io:format("TICK ~p~n", [erlang:now()]) end).
%% ちなみにerlang:now()の戻り値は{MegaSecs, Secs, MacroSecs}
%% 1 MegaSec = 1000,000 seconds


