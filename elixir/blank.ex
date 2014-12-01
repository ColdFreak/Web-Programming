defprotocol Blank do
  @doc "Returns true if data is considered blank/empty"
  
  # @fallback_to_any はすべてのタイプはデフォルトの実装を定義する
  @fallback_to_any true
  def blank?(data)
end

defimpl Blank, for: Any do
  # 対応していないタイプではデフォルトで，false
  def blank?(_), do: false
end
defimpl Blank, for: Integer do
  def blank?(_), do: false
end

defimpl Blank, for: List do
  def blank?([]), do: true
  def blank?(_), do: false
end

defimpl Blank, for: Map do
  # %{}とパターンマッチングできないので
  # mapのサイズをチェックすることは可能
  def blank?(map), do: map_size(map) == 0
end

defimpl Blank, for: Atom do
  def blank?(false), do: true
  def blank?(nil), do: true
  def blank?(_), do: false
end

@doc """
protocolsとstruct一緒に使うと強力のようで
iex(1)> defmodule User do
  ...(1)>   defstruct name: "john", age: 27
  ...(1)> end
iex(2)> Blank.blank?(%User{})
false
"""
defimpl Blank, for: User do
  def blank?(_), do: false
end
