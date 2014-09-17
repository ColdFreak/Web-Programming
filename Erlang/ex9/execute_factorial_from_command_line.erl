-module(execute_factorial_from_command_line).
-export([main/1]).

main([A]) ->
    I = list_to_integer(atom_to_list(A)),
    Result = fac(I),
    io:format("factorial ~w = ~w\n", [I, Result]),
    init:stop().

%% fac(0) -> 1;
%% fac(N) ->
%%     N*fac(N-1).
fac(N) ->
    fac(N, 1).

fac(0, Acc) ->
    Acc;
fac(N, Acc) ->
    fac(N-1, N*Acc).

