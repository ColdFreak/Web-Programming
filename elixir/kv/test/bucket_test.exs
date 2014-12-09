defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  # all "KV.Bucket" tests will require a bucket
  # to be started during setup and stopped after
  # the test.
  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  # We dont explicitly stop the agent because
  # it is linked to the test process and the agent is shut down
  # automatically once the test finishes
  test "stores values by key",  %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end
end
