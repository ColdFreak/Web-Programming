-module(funs_tests).
-include_lib("eunit/include/eunit.hrl").

list_max_test() ->
    ?assertEqual(void, funs:list_max([])),
    ?assertEqual(1, funs:list_max([1])),
    ?assertEqual(3, funs:list_max([1,2,3])),
    ?assertEqual(4, funs:list_max([2,1,4,3])).
