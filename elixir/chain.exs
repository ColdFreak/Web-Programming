defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n+1
    end
  end

  def create_processes(n) do
    # (1)-> (2, 1)-> (3,2,1) の感じでプロセスを追加していく
    last_process = Enum.reduce 1..n, self, 
                              fn(_, send_to) ->
                                spawn(Chain, :counter, [send_to])
                              end

    # start the count by sending
    send last_process, 0

    # and wait for the result to come back to us
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect final_answer}"
    end
  end

  def run(n) do
    # :timer.tc/3 returns {Time, Value}, 'Value' is what is returned from the apply
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end
