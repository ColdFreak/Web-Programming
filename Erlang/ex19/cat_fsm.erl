-module(cat_fsm).
-export([start/0, event/2]).

%% これは猫のfsm machine
%% 猫にどんなメッセージを
%% 送っても、反応なし
start() ->
    spawn(fun() -> dont_give_crap() end).

event(Pid, Event) ->
    Ref = make_ref(),
    Pid ! {self(), Ref, Event},
    receive
        {Ref, Response} -> 
            {ok, Response}
    after 5000 ->
            {error, timeout}
    end.

%% A typical Erlang finite-state
%% machine can be implemented as 
%% a process running a given set of functions
%% (their states) and receiving messages(events)
%% that force a state transition
dont_give_crap() ->
    receive
        %% what ever the message is 
        %% the cat dont give a shit
        %% about it
        {From, Ref, _Message} ->
            From ! {Ref, meh};
        _ -> ok
    end,
    io:format("Switching to: 'dont_give_carp' state~n"),
    dont_give_crap().
