-module(edemo1).
-compile(export_all).

%% starts processes A, B, C
start(Bool, M) ->
    %% A pidがa()関数を実行している
    A = spawn(fun() -> a() end),
    %% A will be linked to B
    %% is Bool is true, B will trap exit from A
    B = spawn(fun() -> b(A, Bool) end),

    %% B will to C
    C = spawn(fun() -> c(B, M) end),
    sleep(1000),
    status(b, B),
    status(c, C).

a() ->
    process_flag(trap_exit, true),
    %% blockingの状態で、待つ状態
    wait(a).

b(A, Bool) ->
    %% B will trap exit if Bool is true
    %%
    process_flag(trap_exit, Bool),
    link(A),
    wait(b).

c(B, M) ->
    link(B),
    case M of
        {die, Reason} ->
            exit(Reason);
        {divide, N} ->
            1/N, 
            wait(c);
        normal ->
            true
    end.

wait(Prog) ->
    receive 
        Any ->
            io:format("Process ~p received ~p~n", [Prog, Any]),
            wait(Prog)
    end.

sleep(T) ->
    receive
    after T -> 
              true
    end.

status(Name, Pid) ->
    case erlang:is_process_alive(Pid) of
        true ->
            io:format("process ~p (~p) is alive~n", [Name, Pid]);
        false ->
            io:format("process ~p (~p) is dead~n", [Name, Pid])
    end.
    
