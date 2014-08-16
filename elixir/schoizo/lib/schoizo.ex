defmodule Schizo do
    @moduledoc """
     A nice module that lets you uppercase or unvowel every
     other letter in a sentence
    """

    @doc """
     Uppercases every other word in a sentence. Example:

     iex> Schizo.uppercase("you are silly")
     "you ARE silly"
    """
    def uppercase(string) do
        transform_every_other_word(string, &uppercaser/1)
    end

    @doc """
     Removes vowels from every other word 
     in a sentence. Example:

     iex> Schizo.unvowel("you are silly")
     "you r silly"
    """
    def unvowel(string) do
        transform_every_other_word(string, &unvoweler/1)
    end

    def transform_every_other_word(string, transformation) do
        # Split string on spaces into a list 
        # of words
        words = String.split(string)

        # Transform every other word (uppercasing)
        words_with_index = Stream.with_index(words)
        transformed_words = Enum.map(words_with_index, transformation)

        # Join the words back with space
        Enum.join(transformed_words, " ")
    end

    def uppercaser({word, index}) do
        cond do
            rem(index, 2) == 0 -> word
            rem(index, 2) == 1 -> String.upcase(word)
        end
    end

    def unvoweler(input) do
        transformer(input, fn (word) -> Regex.replace(~r/[aeiou]/, word, "") end)
    end

    def transformer({word, index}, transformation) do
        cond do
            rem(index, 2) == 0 -> word
            rem(index, 2) == 1 -> transformation.(word)
        end
    end
end
