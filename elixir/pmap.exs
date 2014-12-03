defmodule Parallel do
  @doc"""
  初めてのselfをmeに代入して、
  meはpmapを実行するプロセスで、例えばiex shellのこと
  n個のプロセスで提供された関数で計算した結果を同時にsend命令を実行する
  spawn_linkの中にselfずっと変わる
  n個のプロセスリストを最後の二個目のEnum.mapに渡す
  receiveのほうは別にn個のプロセスと立ち上げて、返事を待つわけじゃない
  meプロセスの中に返事を待ちうけ
  """
  require Logger
  def pmap(collection, fun) do
    me = self
    # shellで実行するときにここのselfとshellのselfは同じ
    Logger.info inspect self
    collection
    |> 
    Enum.map(fn(elem) -> spawn_link(fn -> send me, {self, fun.(elem)} end ) end)
    |>
    Enum.map(
              fn(pid) -> 
                receive do
                    {^pid, result} ->
                        result
                end
    end)
                    
  end
end
