-module(add_one).

-export([start/0, request/1, loop/0]).

start() ->
    process_flag(trap_exit, true),
    % Pid = spawn(add_one, loop, []),
    Pid = spawn(add_one, loop, []),
    register(add_one,Pid ),
    {ok, Pid}.

request(Int) ->
    add_one ! {request, self(), Int},
    receive
        {result, Result} -> Result;
        {'EXIT', _Pid, Reason} -> {error, Reason}
    after 1000 ->
        timeout
    end.

loop() ->
    receive 
        {request, Pid, Msg} ->
            Pid ! {result, Msg+1}
    end,
    loop().

%% 使い方
%% 2> add_one:start().
%% {ok,<0.37.0>}
%% 3> add_one:request(3).
%% 4
%% 4> add_one:request(5).
%% 6
%% 5> add_one:request(one).
%% {error,{badarith,[{add_one,loop,0,
%%                            [{file,"add_one.erl"},{line,24}]}]}}
%% 6>
%% =ERROR REPORT==== 27-Feb-2015::07:11:53 ===
%% Error in process <0.37.0> with exit value: {badarith,[{add_one,loop,0,[{file,"add_one.erl"},{line,24}]}]}
%% 
%% 
%% 6> add_one:request(5).
%% ** exception error: bad argument
%%      in function  add_one:request/1 (add_one.erl, line 13)


%% You have 3 idioms:
%% 
%% 1/ I don't care if my child process dies:
%% 
%% spawn(...)
%% 
%% 2/ I want to crash if my child process crashes:
%% 
%% spawn_link(...)
%% 
%% 3/ I want to receive a message if my child process terminates (normally or not):
%% 
%% process_flag(trap_exit, true),
%% spawn_link(...)

