defmodule SequenceTest do
  use ExUnit.Case

  test "next number " do
    {:ok, pid} = GenServer.start_link(Sequence.Server, 50)
    assert GenServer.call(pid, :next_number) == 50
    assert GenServer.call(pid, :next_number) == 51
  end

  test "add delta to number " do
    {:ok, pid} = GenServer.start_link(Sequence.Server, 50)
    assert GenServer.cast(pid, {:increment_number, 10}) == :ok
  end
end
