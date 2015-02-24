#!/usr/bin/env escript
 
main(_Args) ->gcd(-36,4).
 
gcd(A, 0) -> io:format("~p~n",[A]);
 
gcd(A, B) -> gcd(B, A rem B).
