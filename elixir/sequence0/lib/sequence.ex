defmodule Sequence do
  # When we 'use Application'
  # we only need to define a
  # 'start/2' function. If we
  # wanted to specify custom 
  # behaviour on application
  # stop, we could define a 
  # 'stop/1' function, as well.
  # In this case, the one 
  # automatically defined by
  # 'use Application' is fine
  use Application

  def start(_type, _args) do
    Sequence.Supervisor.start_link(123)
  end
end
