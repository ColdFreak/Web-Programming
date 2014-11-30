defmodule Link1 do
  @doc """
  Erlangのtimerライブラリを使って，500msをスリープ
  sad_functionを実行し終わった後にspawn_linkが使われて
  いるので,リンクされたプロセスに':boom'というメッセージを
  伝える
  """
  import :timer, only: [ sleep: 1]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    spawn_link(Link1, :sad_function, [])
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
      after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

Link1.run
