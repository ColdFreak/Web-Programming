defmodule Stack do
  use GenServer

  def handle_call(:pop, _from, list) do
    case list do
      [] -> 
        {:reply, :nomore, []}
      [head|tail] ->
        {:reply, head, tail}
    end
  end

  def handle_call({:push, number}, _from, list) do
    new_list = [number|list]
    {:reply, new_list, new_list}
  end
end
