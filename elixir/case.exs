require Logger
defmodule MyFile do
  @file_name "case.exs"

  case File.open(@file_name) do
    { :ok, file} ->
      IO.puts "First line: #{IO.read(file, :line)}"
      Logger.info "File successfully opened"
    { :error, reason } ->
      IO.puts "Failed to open file: #{reason}"
  end
end
