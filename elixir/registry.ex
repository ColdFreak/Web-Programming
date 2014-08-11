# モジュールKVのstart関数はloop()関数を実行する
# プロセスを生成する
# loop関数が空のmapというStateを持っている
#
defmodule KV do
	def start do
		{:ok, spawn_link(fn -> loop(%{}) end)}
	end

	defp loop(map) do
		receive do
			# callerは呼び出し元（ex. pidのこと）
			{:get , key, caller} ->
				send caller, Map.get(map, key)
				loop(map)
			{:put, key, value} ->
				loop(Map.put(map, key, value))
		end
	end
end

# $ iex kv.exs
#
# # プロセスを生成する
# iex(1)> {:ok, pid} = KV.start
# {:ok, #PID<0.47.0>}
#
# getメッセージを送っても最初のmapには何も無いので
# 返事をflushしてもnil
# iex(2)> send pid, {:get, :hello, self()}
# {:get, :hello, #PID<0.45.0>}
# iex(3)> flush
# nil
# :ok
#
# putしてから，getするとflushして，worldがかえってくる
# iex(4)> send pid, {:put, :hello, :world}
# {:put, :hello, :world}
# iex(5)> send pid, {:get, :hello, self()}
# {:get, :hello, #PID<0.45.0>}
# iex(6)> flush
# :world
# :ok
