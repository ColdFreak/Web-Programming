-module(phone_ets).
-include("phone_record.hrl").

-compile(export_all).
setup(FileName) ->
    case ets:info(call_table) of
        undefined -> false;
        _ -> ets:delete(call_table)
    end,

    %% {keypos, Position}
    %% The Position parameter holds an integer 
    %% from 1 to N telling which of each tuple's 
    %% element shall act as the primary key of the database table.
    %%
    %% Funnily enough, if you call ets:new(some_name, []), 
    %% you'll be starting a protected set table, without a name. 
    %% For the name to be used as a way to contact a table 
    %% (and to be made unique), the option named_table has to be 
    %% passed to the function.
    ets:new(call_table, [named_table, bag, {keypos, #phone_call.phone_number}]),

    {ResultCode, InputFile} = file:open(FileName, [read]),
    case ResultCode of
        ok ->
            read_item(InputFile);
        _ -> 
            io:format("Error opening file: ~p~n", [InputFile])
    end.

read_item(InputFile) -> 
    RawData = io:get_line(InputFile, ""),
    if
        is_list(RawData) ->
            Data = string:strip(RawData, right, $\n),
            [Number, Sdate, Stime, Edate, Etime] = re:split(Data, ",", [{return, list}]),
            ets:insert(call_table, #phone_call{phone_number = Number, 
                                               start_date   = to_date(Sdate),
                                               start_time   = to_time(Stime),
                                               end_date     = to_date(Edate),
                                               end_time     = to_time(Etime)}),
            read_item(InputFile);
        RawData == eof -> ok
    end.


to_date(Date) ->
   [Year, Month, Day] = re:split(Date, "-", [{return, list}]),
   [{Y, _}, {M, _}, {D, _}] =  lists:map(fun string:to_integer/1, [Year, Month, Day]),
   {Y, M, D}.

to_time(Time) ->
   [Hour, Minute, Second] = re:split(Time, ":", [{return, list}]),
   [{H, _}, {M, _}, {S, _}] =  lists:map(fun string:to_integer/1, [Hour, Minute, Second]),
   {H, M, S}.


summary() ->
    FirstKey = ets:first(call_table),
    summary(FirstKey, []).
summary(Key, Result) ->
    NextKey = ets:next(call_table, Key),
    case NextKey of
        '$end_of_table' -> Result;
        _ -> summary(NextKey, [hd(summary(Key)) | Result])
    end.

summary(PhoneNumber) ->
    Calls = ets:lookup(call_table, PhoneNumber),
    Total = lists:foldl(fun subtotal/2, 0, Calls),
    [{PhoneNumber, Total}].

subtotal(Item, Accumulator) ->
    StartSeconds = calendar:datetime_to_gregorian_seconds(
                {Item#phone_call.start_date, Item#phone_call.start_time}),
    EndSeconds = calendar:datetime_to_gregorian_seconds(
                {Item#phone_call.end_date, Item#phone_call.end_time}),
    Accumulator + ((EndSeconds - StartSeconds + 59) div 60).


