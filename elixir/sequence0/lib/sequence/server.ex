defmodule Sequence.Server do
  # The 'use' line adds the OTP
  # GenServer behavior to our module
  # This is what lets it handle all
  # the callbacks
  use GenServer

  ####
  # External API
  # wrap the 'GenServer.start_link()
  # function to 'start_link'
  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end
  
  
  # GenServer implementation
  def init(stash_pid) do
    current_number = Sequence.Stash.get_value stash_pid
    {:ok, {current_number, stash_pid}}
  end
  # iex -S mix
  # iex> { :ok, pid} = GenServer.start_link(Sequence.Server, 100)
  # iex> GenServer.call(pid, :next_number)
  # the 'call' will call the "handl_call" function in the server.
  # the second parameter of the 'call' is passed as the
  # first argument to 'handle_call'
  def handle_call(:next_number, _from, {current_number, stash_pid}) do
    { :reply, current_number, {current_number+1, stash_pid} }
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number}
  end

  def handle_cast({:increment_number, delta}, {current_number, stash_pid}) do
    {:noreply, {current_number + delta, stash_pid}}
  end
  
  def terminate(_reason, {current_number, stash_pid}) do
    Sequence.Stash.save_value stash_pid, current_number
  end
end

