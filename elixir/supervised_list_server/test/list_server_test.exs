defmodule ListServerTest do
  use ExUnit.Case

  # Clear the ListServer before each test
  setup do
    ListServer.clear
  end

  test "it starts out empty" do
    assert ListServer.items == []
  end

  test "it lets us add things to the list" do
    ListServer.add "book"
    assert ListServer.item == ["book"]
  end

  test "it lets us remove things from the list" do
    ListServer.add "book"
    ListServer.add "magazine"
    ListServer.remove "book"
    assert ListServer.item == ["magazine"]

  end
end
