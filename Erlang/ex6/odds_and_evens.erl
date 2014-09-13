-module(odds_and_evens).
-compile(export_all).


odds_and_evens(L) ->
    Odds  = [X || X <- L ,  (X rem 2) =:= 1],
    Evens = [X || X <- L ,  (X rem 2) =:= 0],
    {Odds, Evens}.
    


