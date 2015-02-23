#!/usr/local/bin/escript

main(_Args) ->
        lcm(-3,4).
 
gcd(A, 0) -> 
        A;
 
gcd(A, B) -> 
        gcd(B, A rem B).
 
lcm(A,B) ->
        io:format("~p~n", [abs(A*B div gcd(A,B))]).
