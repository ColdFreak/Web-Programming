defmodule Sequence.Server do
  # The 'use' line adds the OTP
  # GenServer behavior to our module
  # This is what lets it handle all
  # the callbacks
  use GenServer
  
  # iex -S mix
  # iex> { :ok, pid} = GenServer.start_link(Sequence.Server, 100)
  # iex> GenServer.call(pid, :next_number)
  # the 'call' will call the "handl_call" function in the server.
  # the second parameter of the 'call' is passed as the
  # first argument to 'handle_call'
  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number+1 }
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number}
  end
end

