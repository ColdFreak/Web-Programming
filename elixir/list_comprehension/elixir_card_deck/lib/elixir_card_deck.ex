defmodule ElixirCardDeck do
  def make_deck do
    values = [:a, 2, 3, 4, 5, 6, 7, 8, 9, 10, :j, :q, :k]
    suites = [:spades, :clubs, :diamonds, :hearts]
    for x <- values, y <- suites, do: {:card, x, y}
  end
end
