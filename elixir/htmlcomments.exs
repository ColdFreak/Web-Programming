require Logger
defmodule HtmlComments do

  def uncomment(chars), do: _copy(chars, [])

  # コメントの前半と後半を分けて処理する
  # '<!--'をマッチングできるときにstripを開始する.'-->'が見つかるまで，stripし続ける
  # '-->'が見つかるとまた_copyに戻る，もう一回同じ作業する
  defp _copy([], result),                       do: Enum.reverse(result) 
  defp _copy([?<, ?!, ?-, ?- | rest], result),  do: _strip(rest, result)
  defp _copy([ch | rest], result),              do: _copy(rest, [ch | result])

  defp _strip([], _result),                     do: raise "comment not closed"
  defp _strip([?-, ?-, ?> | rest], result),     do: _copy(rest, result)
  defp _strip([_ch | rest], result),            do: _strip(rest, result)

  @doc """
  ファイルを開いて，各種処理をする
  """
  def process(file) do
    case File.read(file) do
      {:ok, binary} ->
        # IO.puts is_binary body
        binary 
        |> to_char_list
        |> HtmlComments.uncomment
        |> IO.puts
      {:error, reason} ->
        IO.puts "Cannot read file: #{reason}"
    end
  end

end
HtmlComments.process("test.html")
