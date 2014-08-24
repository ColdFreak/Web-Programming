defmodule Fib do
  def of(0),  do: 0
  def of(1),  do: 1
  def of(n),  do: Fib.of(n-1) + Fib.of(n-2)
end

IO.puts "Start the task"

# The call to Task.async creates a separate process
# that runs the given function.
# The return value of 'async' is a task descriptor
# (actually a pid and a ref)
worker = Task.async(fn -> Fib.of(60) end)
IO.puts "Do something else"
#...
IO.puts "Wait for the task"
# 'await' waits for our background 
# task to finish, and returns its value
# 実行時間長過ぎるとクラッシュする
result = Task.await(worker)
IO.puts "The result is #{result}"
