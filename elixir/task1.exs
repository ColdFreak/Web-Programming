defmodule Fibonacci.Cached do
  def fib(n) do
    fib(n, HashDict.new)
  end

  defp fib(0, _), do: 0
  defp fib(1, _), do: 1
  defp fib(n, cache) do
    case Dict.has_key?(cache, n) do
      true ->
        Dict.get(cache, n)
      false ->
        tmp1 = fib(n-2, cache)
        new_cache = Dict.put(cache, n-2, tmp1)
        tmp1 + fib(n-1, new_cache)
    end
  end
end

IO.puts "Start the task"

# The call to Task.async creates a separate process
# that runs the given function.
# The return value of 'async' is a task descriptor
# (actually a pid and a ref)
worker = Task.async(fn -> Fibonacci.Cached.fib(80) end)
IO.puts "Do something else"
#...
IO.puts "Wait for the task"
# 'await' waits for our background 
# task to finish, and returns its value
# 実行時間長過ぎるとクラッシュする
result = Task.await(worker, 20000)
IO.puts "The result is #{result}"
