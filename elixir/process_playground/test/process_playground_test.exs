defmodule Ping do
  def start do
    receive do
      {:pong, pid} ->
        send pid, {:ping, self()}
    end
  end
end

defmodule ProcessPlaygroundTest do
  use ExUnit.Case

  test "it responds to a pong with a ping" do
    ping = spawn_link(Ping, :start, [])
    send ping,  {:pong, self()}
    assert_receive {:ping, ping}
  end
end
