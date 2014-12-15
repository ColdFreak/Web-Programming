-module(event).
-compile(export_all).
-record(state, {server,
                name="",
                to_go=0}).
loop(S = #state{server=Server, to_go=[T|Next]}) ->
    receive
        {Server, Ref, cancel} ->
            Server ! {Ref, ok}
    after T*1000 ->
        if
            Next =:= []->
                Server ! {done, S#state.name};

            Next =/= [] ->
                    loop(S#state{to_go=Next})
        end
    end.
% receve文afterの後ろに49日しか設定できない制限を克服
normalize(N) ->
    Limit = 49*24*60*60,
    [N rem Limit | lists:duplicate(N div Limit, Limit)].
% 例
% 1> c(event).
% {ok,event}
% 2> rr(event, state).
% [state]
% 3> spawn(event, loop, [#state{server=self(), name="test", to_go=5}]).
% <0.42.0>
% 4> flush().
% ok
% 5> flush().
% Shell got {done,"test"}
%
%
% 8> Pid = spawn(event, loop, [#state{server=self(), name="test", to_go=500}]).
% <0.45.0>
% 9> ReplyRef = make_ref().
% #Ref<0.0.0.85>
% 10> Pid ! {self(), ReplyRef, cancel}.
% {<0.32.0>,#Ref<0.0.0.85>,cancel}
% 11> flush().
% Shell got {#Ref<0.0.0.85>,ok}
% ok
