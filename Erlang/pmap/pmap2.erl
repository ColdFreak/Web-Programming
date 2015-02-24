-module(pmap2).
-export([pmap/2]).

pmap(F, L) ->
    S = self(),
    Ref = erlang:make_ref(),
    Pids = lists:map(fun(E) -> spawn(fun() -> do_f(S, Ref, F, E) end) end, L),
    gather(Pids, Ref).

do_f(Parent, Ref, Function, Element) ->
    Parent ! {self(), Ref, catch(Function(Element))}.

gather([Pid|Rest], Ref) ->
    receive
        {Pid, Ref, Result} ->
            [Result|gather(Rest, Ref)]
    end;
gather([], _) ->
    [].
%% 1> pmap2:pmap(fun(X) -> X*X end, [1,2,3]).
%% [1,4,9]
