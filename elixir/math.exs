defmodule Math do
	def sum(a, b) do
		IO.puts do_sum(a, b)
	end

	defp do_sum(a, b) do
		a + b
	end
end

Math.sum(1, 2) #=> 3
#Math.do_sum(1, 2) #=> ** (UndefinedFunctionError)
