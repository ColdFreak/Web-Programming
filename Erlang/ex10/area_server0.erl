-module(area_server0).
-compile(export_all).

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive 
        Response ->
            Response
    end.
loop() ->
    receive
        {From, {rectangle, Width, Ht}} ->
            From ! Width*Ht,
            loop();
        {From, {circle, R}} ->
            From ! 3.1415926 * R * R,
            loop();
        {From, Other} ->
            From ! {error, Other},
            loop()
    end.

%% 1> Pid = spawn(fun area_server0:loop/0).
%% <0.36.0>
%% 2> Pid ! {rectangle, 12, 6}.
%% Area of rectangle is 72
%% {rectangle,12,6}  ここにプログラムには書いていないけどshellなので、Pid ! Msgを評価する結果は 'Msg'のことだから
%% 3> Pid ! {circle, 20}.
%% Area of circle is 1256.63704
%% {circle,20}
%% 4> Pid ! {triangle, 2,3,4}.
%% I don't know the area of a {triangle,2,3,4} is
%% {triangle,2,3,4}


    
