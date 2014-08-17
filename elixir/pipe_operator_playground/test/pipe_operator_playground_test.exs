defmodule Unix do
  def ps_ax do
    """
      PID   TT  STAT      TIME COMMAND
     7508 s002  S+     0:00.97 vim mylist.erl
    62152 s003  S+     0:00.58 vim test/pipe_operator_playground_test.exs
    64703 s003  R+     0:00.00 ps ax
    """
  end

  def grep(input, match) do
    String.split(input, "\n")
      
      |> Enum.filter(fn(line) -> Regex.match?(match, line) end)
  end

  def awk(lines, column) do
    Enum.map(lines, fn(line) ->
      String.strip(line)
      |> Unix.regex_split(~r/ /)
      |> Enum.at(column-1)
    end)
  end

  def regex_split(lines, regex) do
    Regex.split(regex, lines, trim: true)
  end
end

defmodule PipeOperatorPlaygroundTest do
  use ExUnit.Case

  test "ps_ax outputs some processes" do
    output = """
      PID   TT  STAT      TIME COMMAND
     7508 s002  S+     0:00.97 vim mylist.erl
    62152 s003  S+     0:00.58 vim test/pipe_operator_playground_test.exs
    64703 s003  R+     0:00.00 ps ax
    """
    assert Unix.ps_ax == output
  end

  test "grep(lines, thing) returns lines that math 'thing'" do
    lines = """
    foo
    bar
    thing foo
    baz
    thing qux
    """
    output = ["thing foo", "thing qux"]
    assert Unix.grep(lines, ~r/thing/) == output
  end

  test "awk(input, 1) splits on whitespace and return the first column" do
    input = [" 7508 s002  S+     0:00.97 vim mylist.erl", "62152 s003  S+     0:00.58 vim test/pipe_operator_playground_test.exs"]
    output = ["7508", "62152"]
    assert Unix.awk(input, 1) == output
  end

  test "the whole pipeline works" do
    assert (Unix.ps_ax |> Unix.grep(~r/vim/) |> Unix.awk(1)) == ["7508", "62152"]
  end
end
