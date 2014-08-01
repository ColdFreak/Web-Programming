# これはErlangの中のパターンマチングと同じで
二つ目の関数はxが０ではなく，しかも数字であるときに
falseを返す. [1,2,3]自体は数字ではないので，エラーが発生
defmodule Math do
	def zero?(0) do
		true
	end

	def zero?(x) when is_number(x) do
		false
	end
end

IO.puts Math.zero?(0) #=> true
IO.puts Math.zero?(1) #=> false
#Math.zero?([1,2,3]) #=> (FunctionClauseError)
