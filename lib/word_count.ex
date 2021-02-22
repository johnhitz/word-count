defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/[^[:alnum:]-]/u, trim: true)
    |> Enum.reduce(%{}, &get_word_count/2)
  end

  defp get_word_count(word, acc) do
    cond do
      Map.has_key?(acc, word) ->
        value = Map.get(acc, word)
        %{acc | word => value + 1}
      true -> Map.put(acc, word, 1)
    end
  end
end
