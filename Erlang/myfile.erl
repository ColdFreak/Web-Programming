-module(myfile).
-include_lib("kernel/include/file.hrl").

-export([file_info/1]).

file_info(Dir) ->
    {ok, F} = file:read_file_info(Dir),
    io:format("~p~n", [F#file_info.type]).
