defmodule Chatty.Channels.Rooms do
  use Phoenix.Channel

  def join(socket, topic, message) do
    IO.puts "JOIN: #{socket.channel}: #{topic}"
    {:ok, socket}
  end

  def join(socket, private_topic, message) do
    {:error, socket, :unauthorized}
  end

  def event("new:message", socket, message) do
    broadcast socket, "new:message", content: message["content"]
    socket
  end
end
