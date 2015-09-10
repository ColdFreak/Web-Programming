defmodule Git do
  require Logger
  def get_zen() do
    # HTTPoison.start
    # res = HTTPoison.get!(url)
    url = "https://api.github.com/authorizations"
    # body = HTTPoison.post!(url, {:form, [scopes: "repo, user", note: "getting-started"]},  %{"X-GitHub-OTP" => "610554"}) 
    # json = %{scopes: "repo, user", note: "getting-started"}
    # |> Poison.encode!
    # response = HTTPoison.post!(url, json ,  %{"X-GitHub-OTP" => "610554"}) 
    response = HTTPoison.post!(url, "{\"scopes\": \"repo, user\", \"note\": \"getting-started\"}",  %{"X-GitHub-OTP" => "610554"})
    Logger.info "#{inspect response}"
  end
end
