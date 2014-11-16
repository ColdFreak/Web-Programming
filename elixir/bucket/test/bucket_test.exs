defmodule BucketTest do
  use ExUnit.Case, async: true
  doctest Bucket

  @doc """
  KV.Bucket tests will require a bucket to
  be started during setup and stopped after the 
  test. ExUnit supports callbacks that allow us to skip such
  repetitive tasks
  """
  setup do
  	{:ok, bucket} = KV.Bucket.start_link
  	{:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
	assert KV.Bucket.get(bucket, "milk") == :nil

	KV.Bucket.put(bucket, "milk", 3)
	assert KV.Bucket.get(bucket, "milk") == 3

	KV.Bucket.put(bucket, "orange", 5)
	assert KV.Bucket.get(bucket, "orange") == 5

	KV.Bucket.delete(bucket, "milk")
	assert KV.Bucket.get(bucket, "milk") == :nil

  end
end
