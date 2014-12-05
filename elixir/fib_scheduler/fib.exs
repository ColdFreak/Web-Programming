defmodule FibSolver do
  def fib(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:fib, n, client} ->
        send client, {:answer, n, fib_calc(n), self}
        fib(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1)+fib_calc(n-2)
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    # 準備OKのプロセスリストを作成
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [])
  end

  @doc """
  processesは準備できたプロセスのリスト
  queue は[37, 37, 37 ]のような処理必要のリスト
  """
  defp schedule_processes(processes, queue, results) do
    receive do
      # 準備できたよみたいメッセージが飛んできたら
      # 未計算の値どんどん準備できたプロセスに投げる
      {:ready, pid} when length(queue) > 0 ->
        [ next|tail ] = queue
      send pid, {:fib, next, self}
      schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end
     
      # 未計算の値を投げていく途中に計算された値が飛んできたら、結果をresultsに追加(新しいステータス)
      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

to_process = [ 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37 ]
# run()関数をn回走らせる, 毎回to_processリストすべて処理する?
# そして毎回違う数のプロセスで処理する？
Enum.each 1..11, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run, [num_processes, FibSolver, :fib, to_process])

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time(s)"
  end
  :io.format "~2B       ~.2f~n", [num_processes, time/1000000.0]
end
