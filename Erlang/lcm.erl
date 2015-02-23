#!/usr/local/bin/escript

main(_Args) ->
    lcm_multiple(20).

gcd(A, 0) -> 
        A;
gcd(A, B) -> 
        gcd(B, A rem B).
 
%% gcd(A, B)*lcm(A, B) = A*B
lcm(A,B) ->
    abs(A*B div gcd(A,B)).

lcm_multiple(N) ->
    Res = lists:foldl(fun(A,B) -> lcm(A,B) end, 1, lists:seq(1,N)),
    io:format("~p~n", [Res]).
