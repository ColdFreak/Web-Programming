require Logger
defmodule HtmlComments do

  def uncomment(chars), do: _copy(chars, [])

  # コメントの前半と後半を分けて処理する
  # '<!--'をマッチングできるときにstripを開始する.'-->'が見つかるまで，stripし続ける
  # '-->'が見つかるとまた_copyに戻る，もう一回同じ作業する
  def _copy([], result),                       do: Enum.reverse(result) 
  def _copy([?<, ?!, ?-, ?- | rest], result),  do: _strip(rest, result)
  def _copy([ch | rest], result),              do: _copy(rest, [ch | result])

  def _strip([], _result),                     do: raise "comment not closed"
  def _strip([?-, ?-, ?> | rest], result),     do: _copy(rest, result)
  def _strip([_ch | rest], result),            do: _strip(rest, result)
end

case File.read("test.html") do
  {:ok, binary} ->
    binary 
    |> to_char_list
    |> HtmlComments.uncomment
    |> IO.puts
    # IO.puts HtmlComments.uncomment(to_char_list(binary))
    # IO.puts is_binary body
  {:error, reason} ->
    IO.puts "Cannot read file: #{reason}"
end

     
# IO.puts HtmlComments.uncomment('<!-- this is a test --> also a test\n')
