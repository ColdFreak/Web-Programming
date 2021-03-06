defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir dave@pragprog.com"} ]
  @github_url Application.get_env(:issues, :github_url)
  
  def fetch(user, project) do
    issue_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issue_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}"
  end

  def handle_response(%{status_code: 200, body: body}) do
    { :ok, :jsx.decode(body) }
  end

  def handle_response(%{status_code: ___, body: body}) do
    { :error, :jsx.decode(body) }
  end

end

