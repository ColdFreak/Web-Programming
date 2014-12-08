# Mix can run the particalur test like 
# $ mix test test/kv_test.exs:4
defmodule KVTest do
  use ExUnit.Case

  test "the truth" do
    assert 1 + 1 == 2
  end
end
