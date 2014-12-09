defmodule KV.Bucket do
  @doc """
  Starts a new bucket.
  """

  def start_link do
    Agent.start_link(fn -> HashDict.new end)
  end

  def get(bucket, key) do
    # get(dict, key, default \\ nil)
    Agent.get(bucket, &HashDict.get(&1, key))
  end

  @doc """
  We are using a hashdict to store our state
  instead of a "Map", because in the current version
  of Elixir maps are less efficient when holding a large
  number of keys
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &HashDict.put(&1, key, value))
  end
end
