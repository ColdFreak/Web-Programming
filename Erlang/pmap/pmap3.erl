-module(pmap3).

-export([pmap/2]).

pmap(F, L) ->
    Parent = self(),
    Ids = lists:map(fun(H) -> 
                             Id = make_ref(), 
                             spawn( fun() -> X = (catch F(H)), Parent ! {Id, X} end ), 
                             Id 
                     end,
                     L),
    lists:map(fun(Id) -> 
                      receive {Id, X} -> X end 
              end,
              Ids
             ).
% 1> pmap3:pmap(fun(X) -> X*X end, [1,2,3]).
% [1,4,9]
