defmodule Sequence.Server do
  use GenServer

  # the third parameter is the server state
  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number+1 }
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number}
  end

  def handle_call(:pop_list, _from, [head|tail]) do
    { :reply, head, tail }
  end

  def handle_call({ :set_list, list},  _from, _) do
    { :reply, list, list}
  end
end
