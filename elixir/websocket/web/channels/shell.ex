defmodule Websocket.Channels.Shell do
  use Phoenix.Channel

  def join(socket, "shell", _message) do
    IO.puts "JOIN #{socket.channel}.#{socket.topic}"
    reply socket, "join", %{status: "localhost websocket connected"}
    {:ok, socket}
  end

    def join(socket, _private_topic, _message) do
      {:error, socket, :unauthorized}
    end

    def event(socket, "shell:stdin", message) do
      reply socket, "stdout", %{data: message["data"]}
      socket
    end
end
