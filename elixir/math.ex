defmodule Math do
	@moduledoc """
	Provides math-related functions.

	## Examples
		
		iex> Math.sum(1,2)
		3
	"""

	@doc """
	Calculates the sum of two numbers.
	"""
	def sum(a,b), do: a + b
end

# コンパイルした後に'h'を使ってdocにアクセスする
# @docは関数のdoc
# @moduledocはモジュールのdocを定義する
# $ elixirc math.ex
# $ iex
# iex> h Math # Access the docs for the module Math
# ...
# iex> h Math.sum # Access the docs for the sum function
