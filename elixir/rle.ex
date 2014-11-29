defmodule RLE do
  @doc """
  iex(1)> RLE.encode([1,1,1,1,2,2,2,2,3,3,3])
  [{1, 4}, {2, 4}, {3, 3}]
  1は４個、２は４個、３は３個
  """
  def encode(list), do: _encode(list, [])

  defp _encode([], result), do: Enum.reverse(result)

  defp _encode([a, a | tail], result) do
    _encode([{a, 2} | tail], result)
  end

  defp _encode([{a, n},a | tail], result) do
    _encode([ {a, n + 1} | tail], result)
  end

  defp _encode([a | tail], result) do
    _encode(tail, [a | result])
  end
end
