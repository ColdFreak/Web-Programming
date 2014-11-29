defmodule ProcessFile do
  def to_lines(fd, result \\ []) do
    case IO.read(fd, :line) do
      :eof ->
        result
      {:error, reason} ->
        IO.puts "Read file failed: #{reason}"
      data ->
        to_lines(fd, [data | result])
    end
  end
end

fd = File.open!("line_list.exs")
li = ProcessFile.to_lines(fd)
IO.puts(Enum.reverse(li))
