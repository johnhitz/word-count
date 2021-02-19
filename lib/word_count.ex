defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split()
    |> Enum.reduce(%{}, &get_word_count/2)
  end

  defp get_word_count(word, acc) do
    has_underscore = Regex.match?(~r/[a-zA-Z]+_[a-zA-Z]+/, word)
    cond do
      Map.has_key?(acc, word) ->
        value = Map.get(acc, word)
        %{acc | word => value + 1}
      has_underscore ->
        remove_underscore(word, acc)
      true -> is_word?(word, acc)
    end
  end

  defp is_word?(word, acc) do
    case word do
      word when word not in [":"] ->
        Map.put(acc, remove_punctuation(word), 1)
      _ -> acc
    end
  end

  defp remove_punctuation(word) do
    Regex.replace(~r/[!&@$%^,]/, word, "")
  end

  defp remove_underscore(word, acc) do
    words = String.split(word, "_")
    Enum.reduce(words, acc, fn x, acc -> get_word_count(x, acc) end)
  end
end
