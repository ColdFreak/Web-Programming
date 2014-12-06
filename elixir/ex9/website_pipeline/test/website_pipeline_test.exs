defmodule WebsitePipeline do
  def map_titles(sites) do
    sites
    |> Enum.map(fn(url) -> url |> get_body |> extract_title end)
  end
end

  def get_body(url) do
    HTTPotion.get(url).body
  end

  def extract_title(html) do
    title_pattern = ~r"<title>([^<]*</title>"
    Regex.run(title_pattern, html) |> Enum.at(1)
  end
defmodule WebsitePipelineTest do
  use ExUnit.Case

  test "the truth" do
    sites = ["http://example.org", "http://slashdot.org"]
    expected_titles = ["Example Domain", "Slashdot: News for nerds, stuff that matters"]
    asster expected_titles == WebsitePipeline.map_titles(sites)
  end
end
