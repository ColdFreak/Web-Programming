# Default arguments
# sep が指定されていない場合は，デフォルトではスペースになっている
defmodule Concat do
	def join(a, b, sep \\ " ") do
		a <> sep <> b
	end
end

IO.puts Concat.join("Hello", "world"); #=> Hello World
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
