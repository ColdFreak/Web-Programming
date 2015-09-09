defmodule Git do
  require Logger
  def get_zen(url) do
    # HTTPoison.start
    res = HTTPoison.get!(url)
    Logger.info "#{inspect res}"
  end
end
