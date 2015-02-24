-module(logger).
-author("wang").

-behaviour(gen_server).

%% API
-export([start/0, stop/0, log/2, show_log/0]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).


%%%===================================================================
%%% API
%%%===================================================================

start() -> gen_server:start_link({global, ?SERVER}, ?MODULE, [], []).

stop() -> gen_server:call(?MODULE, stop).

log(Level, MSG) -> gen_server:call({global, ?MODULE}, {add, Level, MSG}).

show_log() -> gen_server:call({global, ?MODULE}, show).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) -> 
    Tab = ets:new(?MODULE, [bag, named_table]),
    {ok, Tab}.

handle_call(show, _From, Tab) -> 
    Record = ets:lookup(Tab, info),
    {reply, Record, Tab};

handle_call({add, Level, MSG}, _From, Tab) -> 
    true = ets:insert(Tab, {Level, MSG}),
    {reply, ok, Tab}.


handle_cast(_Request, State) -> {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.
