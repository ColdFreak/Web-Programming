%%%-------------------------------------------------------------------
%%% @author Martin & Eric <erlware-dev@googlegroups.com>
%%%  [http://www.erlware.org]
%%% @copyright 2008 Erlware
%%% @doc RPC over TCP server. This module defines a server process that
%%%      listens for incoming TCP connections and allows the user to
%%%      execute RPC commands via that TCP stream.
%%% @end
%%%-------------------------------------------------------------------
-module(tr_server).
-behaviour(gen_server).

%% API
-export([
		 start_link/1,
		 start_link/0,
		 get_count/0,
		 stop/0
	 ]).

%% get_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

% sets SERVER to module name
-define(SERVER, ?MODULE).
% defines default port
-define(DEFAULT_PORT, 1055).

% holds state of process
-record(state, {port, lsock, request_count = 0}). 

%%%=====================================================
%%% API
%%%=====================================================

%%------------------------------------------------------
%% @doc Starts the server.
%%
%% @spec start_link(Port::integer()) -> {ok, Pid}
%% where 
%%  Pid = pid()
%% @end
%%------------------------------------------------------
start_link(Port) ->
	gen_server:start_link({local, ?SERVER}, ?MODULE, [Port], []).

%% @spec start_link() -> {ok, Pid}
%% @doc	 Calls `start_link(Port)` using the default port.
start_link() ->
	start_link(?DEFAULT_PORT).

%%------------------------------------------------------
%% @doc Fetches the number of requests made to this server
%% @spec get_count() -> {ok, Count}
%% where 
%%  Count  = integer()
%% @end
%%------------------------------------------------------
get_count() ->
	gen_server:call(?SERVER, get_count).

%%------------------------------------------------------
%% @doc Stops the server. Dosen't wait for reply
%% @spec stop() -> ok
%% @end
%%------------------------------------------------------
stop() ->
	gen_server:cast(?SERVER, stop).

%%%=====================================================
%%% gen_server callbacks
%%% Upon initializaiton of the server, the init function
%%% creates a TCP listening socket, sets up the initial
%%% state record, and also signals an immediate timeout
%%% Next, the code returns the current request count to 
%%% the calling client process. 
%%% 'init' takes one argument, which must be a list 
%%% containing a single element that you call Port
%%% {active, true} which tells gen_tcp to send any incoming 
%%% TCP data directly to your process as messages.
%%% The 0 is a timeout value. A timeout of zero says to the
%%% gen_server container that immediately after init/1 has
%% finished, a timeout should be triggered that foreces you 
%%% to handle a timeout message( in handle_info/2) as the 
%%% first thing you do after initialization. 
%%% When your handle_cast function sees the message stop,
%%% it only has to return the following 3-tuple.
%%% {stop, normal, State}
%%%=====================================================

init([Port]) ->
	{ok, LSock} = gen_tcp:listen(Port, [{active, true}]),
	{ok, #state{port = Port, lsock = LSock}, 0}.

handle_call(get_count, _From, State) ->
	{reply, {ok, State#state.request_count}, State}.

handle_cast(stop, State) ->
	{stop, normal, State}.



