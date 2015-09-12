defmodule Github do
  require Logger
  @doc ~S""" 
  実行したいコマンド、githubのtokenを発行
  $ curl -i -u "ColdFreak" -H "X-GitHub-OTP: 123456" -d '{"scopes": ["repo", "user"], "note" : "getting-started"}' https://api.github.com/authorizations

  結果は %HTTPoison.Response{body: "...", headers: [{...}, {...}]のような形

  %HTTPoison.Response{body: "{\"message\":\"Requires authentication\",\"documentation_url\":\"https://developer.github.com/v3/oauth_authorizations/#oauth-authorizations-api\"}", headers: [{"Server", "GitHub.com"}, {"Date", "Thu, 10 Sep 2015 23:01:28 GMT"}, {"Content-Type", "application/json; charset=utf-8"}, {"Content-Length", "138"}, {"Status", "401 Unauthorized"}, {"X-RateLimit-Limit", "60"}, {"X-RateLimit-Remaining", "55"}, {"X-RateLimit-Reset", "1441928569"}, {"X-GitHub-Media-Type", "github.v3; forma t=json"}, {"X-XSS-Protection", "1; mode=block"}, {"X-Frame-Options", "deny"}, {"Content-Security-Policy", "default-src 'none'"}, {"Access-Control-Allow-Credentials", "true"}, { "Access-Control-Expose-Headers", "ETag, Link, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"}, {"Access-Control-Allow-Origin", "*"}, {"X-GitHub-Request-Id", "D2A8249D:1A01:B33F998:55F20BC7"}, {"Strict-Transport-Security", "max-age=31536000; includeSubdomains; preload"}, {"X-Content-Type-Options", "nosniff"}], status_code: 401}
  """
  def zen do
    url = "https://api.github.com/zen"
    response = HTTPoison.get!(url)
    # Logger.info "レスポンス: #{inspect response}"

    # body = response.body
    # Logger.info "body: #{inspect body}"
    
    headers = response.headers
    # Logger.info "header: #{inspect headers}"
    Enum.map(headers, fn {header, value} -> IO.puts "#{header}: #{value}\n" end)

   
  end

  def list_repos do
    url = "https://api.github.com/user/repos"
    token = "43b9cd35c0b948654d009c74a5b51fe5f71e797a"
    headers = [{"Authorization", "token #{token}"}]
    response = HTTPoison.get!(url, headers)
    Logger.info "response: #{inspect response.body}"

  end
  
  def create_issue do
    url = "https://api.github.com/repos/ColdFreak/ppool/issues"
    token = "43b9cd35c0b948654d009c74a5b51fe5f71e797a"
    # headers = %{"Authorization" => "token #{token}"}
    response = HTTPoison.post!(url,  "{\"title\": \"Add variable\", \"body\": \"Add max overflow\", \"labels\": [\"design\", \"feature\"\]}", %{"Authorization" => "token #{token}"})
    Logger.info "response: #{inspect response}"
  end

  def create_issue_2 do
    url       = "https://api.github.com/repos/ColdFreak/ppool/issues"
    token     = "43b9cd35c0b948654d009c74a5b51fe5f71e797a"

    headers   = [{"Authorization", "token #{token}"}]
    json_data = %{title: "test issue", body: "test body", labels: ["design", "feature"]}
                |> Poison.encode!

    response = HTTPoison.post!(url,  json_data, headers)
    Logger.info "response: #{inspect response}"
  end
  def create_issue_3 do
    url       = "https://api.github.com/repos/ColdFreak/ppool/issues"
    token     = "43b9cd35c0b948654d009c74a5b51fe5f71e797a"

    headers   = [{"Authorization", "token #{token}"}]
    post_data = {:multipart, [{"title", "test issue 3"}, {"body", "test body 3"}, {"labels", "design"}]}

    response = HTTPoison.post!(url,  post_data, headers)
    Logger.info "response: #{inspect response}"
  end

  def token do
    # HTTPoison.start
    # res = HTTPoison.get!(url)
    url = "https://api.github.com/authorizations"

    # 方法1
    # response = HTTPoison.post!(url, {:form, [scopes: "repo, user", note: "getting-started"]},  %{"X-GitHub-OTP" => "610554"}) 

    # 方法2
    # response = HTTPoison.post!(url, "{\"scopes\": \"repo, user\", \"note\": \"getting-started\"}",  %{"X-GitHub-OTP" => "610554"})

    # 方法3
    json = %{scopes: "repo, user", note: "getting-started"}
    |> Poison.encode!
    Logger.info "用意したパラメータは %{scopes: \"repo, user\", note: \"getting-started\"} "


    Logger.info "Poisonでencode!したjsonは #{inspect json}"
    response = HTTPoison.post!(url, json ,  %{"X-GitHub-OTP" => "648158"}) 
    Logger.info "responseは #{inspect response}"


    # レスポンスを`response.body`のようなやり方でbodyをアクセスできる
    body = response.body |> Poison.decode!
    # decodeするとMapになっている
    # %{"documentation_url" => "https://developer.github.com/v3/oauth_authorizations/#oauth-authorizations-api", "message" => "Requires authentication"}
    Logger.info "response.bodyは #{inspect body}"

    # Mapにアクセス
    message = body["message"]
    Logger.info "body[\"message\"]は #{inspect message}"

    
  end

end
