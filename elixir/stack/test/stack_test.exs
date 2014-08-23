defmodule StackTest do
  use ExUnit.Case

  test "pop a empty list" do
    {:ok, pid} = GenServer.start_link(Stack, [])
    assert GenServer.call(pid, :pop)== :nomore
  end

  test "pop a  list with one element two times" do
    {:ok, pid} = GenServer.start_link(Stack, [1])
    assert GenServer.call(pid, :pop)== 1
    assert GenServer.call(pid, :pop)== :nomore
    assert GenServer.call(pid, :pop)== :nomore
  end

  test "add a number to a list" do
    {:ok, pid} = GenServer.start_link(Stack, [1])
    assert GenServer.call(pid, {:push, 3}) == [3,1]
    assert GenServer.call(pid, {:push, 4}) == [4, 3,1]
  end

  test "add and pop numbers to a list" do
    {:ok, pid} = GenServer.start_link(Stack, [])
    assert GenServer.call(pid, :pop)== :nomore
    assert GenServer.call(pid, {:push, 3}) == [3]
    assert GenServer.call(pid, {:push, 4}) == [4,3]
  end

end
