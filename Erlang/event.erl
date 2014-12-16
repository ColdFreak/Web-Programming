-module(event).
-compile(export_all).
-record(state, {server,
                name="",
                to_go=0}).
start(EventName, DateTime) ->
    % リストはinitに渡すパラメータ
    spawn(?MODULE, init, [self(), EventName, DateTime]).

start_link(EventName, DateTime) ->
    spawn_link(?MODULE, init, [self(), EventName, DateTime]).

init(Server, EventName, DateTime) ->
    loop(#state{ server=Server
                ,name=EventName
                ,to_go=time_to_go(DateTime) }
        ).
cancel(Pid) ->
    % モニターを使って、Pidまた生きてるかを知る
    % monitor(process, Item) -> MonitorRef
    % Pidが死んだら、'DOWN'メッセージがモニタリングしているプロセスに送る
    Ref = erlang:monitor(process, Pid),
    Pid ! {self(), Ref, cancel},
    receive
        {Ref, ok} ->
            % flushの役割は{_, MonitorRef, _, _, _}メッセージを取り除くこと
            erlang:demonitor(Ref, [flush]),
            ok;
        {'DOWN', Ref, process, Pid, _Reason} ->
            ok
    end.
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

time_to_go(TimeOut={{_, _, _ },{ _, _, _ }}) ->
    Now = calendar:local_time(),
    ToGo = calendar:datetime_to_gregorian_seconds(TimeOut) - calendar:datetime_to_gregorian_seconds(Now),
    Secs = if ToGo > 0 -> ToGo;
        ToGo =< 0 -> 0
    end,
    normalize(Secs).


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
