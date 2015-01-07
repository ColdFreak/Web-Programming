-module(ctemplate).
-compile(export_all).

start(Atom, Fun) when is_atom(Atom), is_function(Fun, 0) ->
    Sender = self(),
    Fun2 = fun() ->
        case catch register(Atom, self()) of
            true ->
                Sender ! {started, self()},
                Fun();
            _ ->
                Sender ! {already_running, self()}
        end
    end,
    Pid = spawn(Fun2),
    receive
        {started, Pid} ->
            {ok, Pid};
        {already_running, Pid} ->
            already_running
    end.
