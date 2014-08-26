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

% when a gen_server has set a timeout, and that timeout
% triggers, an out-of-band message with the single atom
% 'timeout' is generated, and the handle_info/2 callback
% is invokded to handle it. This mechanism is usually used
% to make servers wake up and take some action if they have
% received no requests within the timeout period.
% here, you're abusing this timeout mechanism slightly(
% it's a well-known trick) to allow the init/1 function
% to finish quickly so that the caller of start_link() 
% isn't left hanging; but at the same time, you're making
% sure the server immediately jumps to a specific piece of code
% (the timeout clause of handle_info/2) where it can get on 
% with the mre time-consuming part of the startup precedure-in
% this case, waiting for a connection on the socket you created
% Because you are not using server timeouts for anything else
% in this application, you know it won't return to that point
% again afterward

init([Port]) ->
	{ok, LSock} = gen_tcp:listen(Port, [{active, true}]),
	{ok, #state{port = Port, lsock = LSock}, 0}.

% handle_call/3 is invoked every time a message is received
% that was sent using gen_server:call/2. 
% All you need to do is extract the current request count from
% the state record and return it.The tuple indicates to the
% gen_server container that you want to send a reply to the
% caller; that the value returned to the caller should be a tuple
% {ok, N}, and finally that the new state of the server should be
% the same as the old(nothing was changed)
handle_call(get_count, _From, State) ->
	{reply, {ok, State#state.request_count}, State}.

% the tuple tells the gen_server container that it should stop
% (that is , terminate) and that the reason for termination is 
% normal, which indicates a graceful shutdown. The current state
% is also passed on unchanged(even though it won't be used further)
%  Note here that the atom stop returned in this tuple instruct the 
% container to shut down, whereas the stop message used in the protocol 
% between the API and the server could have benn any atom(such as quit),
% but was chosen to match the name of the API function stop().
handle_cast(stop, State) ->
	{stop, normal, State}.


% handle_info/2 is the callback for out-of-band messages.
% This function has two clauses; one for incoming TCP data
% and one for the timeout. The timeout clause is the first
% thing the server does after it has finished running the init/1
% function(because init/1 set the server timeout to zero):
% a kind of deferred initialization. All this clause does
% is use gen_tcp:accept/1 to wait for a TCP connection on your
% listening socket ( and the server will be stuck here until
% that happens). After a connection  is made, the timeout clause
% returns and signals to the gen_server container that you want to
% continue as normal with an unchanged state.You don't need to
% remember the socket handle returned by accept, because it's also
% included in each data package.

% back to TCP sockets: an active socket like this forwards all incoming
% data as messages to the process that created it.(With a passive socket,
% you''d have to keep asking it if there is more data available). All you
% need to to is to handle thos messages as they're arriving. Because they're
% out-of-band data as far as the gen_server container is concerned. they're
% delegated to the handle_info/2 callback function

% {tcp, Socket, RawData} is the kind of message that an active socket sends
% to its owner when it has pulled data off the TCP buffer.

handle_info({tcp, Socket, RawData}, State) ->
	do_rpc(Socket, RawData), 
	RequestCount = State#state.request_count,
	{noreply, State#state{request_count=RequestCount + 1}};
handle_info(timeout, #state{lsock = LSock} = State) ->
	{ok, _Sock} = gen_tcp:accept(LSock),
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

%%%======================================================
%%% Internal functions
%%%======================================================

do_rpc(Socket, RawData) ->
	try 
		{M, F, A} = split_out_mfa(RawData),
		Result = apply(M,F,A),
		gen_tcp:send(Socket, io_lib:fwrite("˜p˜n", [Result]))
	catch
		_Class:Err ->
			gen_tcp:send(Socket, io_lib:fwrite("˜p˜n", [Err]))
	end.

split_out_mfa(RawData) ->
	MFA = re:replace(RawData, "\r\n$", "", [{return, list}]),
	{match, [M, F, A]} = re:run(MFA, "(.*):(.*)\s*\\((.*)\s*\\)\s*.\s*$",
								[{capture, [1,2,3], list}, ungreedy]),
	{list_to_atom(M), list_to_atom(F), args_to_terms(A)}.

args_to_terms(RawArgs) ->
	{ok, Toks, _Line} = erl_scan:string("["++ RawArgs ++ "]. ", 1),
	{ok, Args} = erl_parse:parse_term(Toks),
	Args.


% In general, a server can't call its own API functions, Suppose you make
% a synchronous call to the same server from with one of the callback 
% functions. for example, if handle_info/2 tries to use the get_count/0
% API function. It will then perform a gen_server:call(..) to itself.
% But that request will be queued up until after the current call
% to handle_info/2 has finished, resulting in a circular wait - the 
% server is deadlocked.

