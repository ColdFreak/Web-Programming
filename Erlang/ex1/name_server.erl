-module(name_server).
-export([init/0, add/2, whereis/1, handle/2]).

%% server1のrpc関数を使えるようにimportする
-import(server1, [rpc/2]).

%% クライアントルーチン
add(Name, Place) ->
	rpc(name_server, {add, Name, Place}).

whereis(Name) ->
	rpc(name_server, {whereis, Name}).

%% コールバックルーチン
init() ->
	dict:new().

handle({add, Name, Place}, Dict) ->
	{ok, dict:store(Name, Place, Dict)};
handle({whereis, Name}, Dict) ->
	{dict:find(Name, Dict), Dict}.


