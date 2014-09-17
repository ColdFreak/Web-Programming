-module(odds_and_evens).
-compile(export_all).


odds_and_evens(L) ->
    Odds  = [X || X <- L ,  (X rem 2) =:= 1],
    Evens = [X || X <- L ,  (X rem 2) =:= 0],
    {Odds, Evens}.
    
odds_and_evens_acc(L) ->
    odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H | T], Odds, Evens) -> 
    case (H rem 2) of
        1 -> odds_and_evens_acc(T, [H | Odds], Evens);
        0 -> odds_and_evens_acc(T, Odds, [H | Evens])
    end;
odds_and_evens_acc([], Odds, Evens) -> 
    
    {lists:reverse(Odds), lists:reverse(Evens)}.


