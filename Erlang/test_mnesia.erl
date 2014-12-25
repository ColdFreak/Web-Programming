-module(test_mnesia).
-compile(export_all).

% qlc:q() を呼び出すには'qlc.hrl'をインクルードする必要がある
-include_lib("stdlib/include/qlc.hrl").
-record(shop, {item, quantity, cost}).
-record(cost, {name, price}).

example_tables() ->
    [
        % shop テーブル
        {shop, apple,   20,     2.3},
        {shop, orange,  100,    3.8},
        {shop, pear,    200,    3.6},
        {shop, banana,  420,    4.5},
        {shop, potato,  2456,   1.2},

        % costテーブル
        {cost, apple,   1.5},
        {cost, orange,  2.4},
        {cost, pear,    2.2},
        {cost, banana,  1.5},
        {cost, potato,  0.6}
    ].

reset_tables() ->
    mnesia:clear_table(shop),
    mnesia:clear_table(cost),
    F = fun() ->
            lists:foreach( fun mnesia:write/1, example_tables())
    end,
    mnesia:transaction(F).

start() ->
    mnesia:start(),
    mnesia:wait_for_tables([shop, cost], 2000).

do_this_once() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(shop, [{attributes, record_info(fields, shop)}]),
    mnesia:create_table(cost, [{attributes, record_info(fields, cost)}]),
    mnesia:stop().

demo(select_shop) ->
    do(qlc:q([X || X <- mnesia:table(shop)])).

do(Q) ->
    F = fun() -> qlc:e(Q) end,
    {atomic, Val} = mnesia:transaction(F),
    Val.

add_shop_item(Name, Quantity, Cost) ->
    Row = #shop{item=Name, quantity=Quantity, cost=Cost},
    F = fun() ->
            mnesia:write(Row)
        end,
    mnesia:transaction(F).


