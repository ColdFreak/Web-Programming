defmodule Ping do
  def start do
    await(0)
  end

  def await(count) do
    receive do
      {:pong, pid} ->
        send pid, {:ping, self()}
      {:ping, pid} ->
        send pid, {:pong, self()}
    end
    IO.puts "Ping Pong test #{count + 1} times"
    await(count + 1)
  end
end
