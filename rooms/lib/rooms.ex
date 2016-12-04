defmodule Rooms do
  @moduledoc """
  Documentation for Rooms.
  """

  def process(input) do
    input
    |> String.split("\n")
    |> Enum.map(&real?/1)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {num, _} -> num end)
    |> Enum.sum
  end

  @doc """
  Drop the first element. Splitting on ] produces an empty string at the end of the list (which we then reverse.)

  ## Examples

      iex> Rooms.real?("aaaaa-bbb-z-y-x-123[abxyz]")
      "123"

  """
  def real?([_, provided_checksum, sector_id | rest]) do
    # process rest and
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/jTEZXKdecjA
    if calculated_checksum(rest) == provided_checksum do
      sector_id
    else
      "0"
    end
  end

  def real?(input) do
    input
    |> String.split(["-","[","]"])
    |> Enum.reverse
    |> real?
  end

@doc """
      iex> Rooms.calculated_checksum(["a","abee","abceeeee","abcd","ddddd"])
      "edabc"

      iex> Rooms.calculated_checksum(["b","b","a","a","ccc","ccc","zzz","zzz","gggg"])
      "czgab"

  """
  @spec calculated_checksum([String.t]) :: String.t
  def calculated_checksum(list) do
    list
    |> Enum.flat_map(&String.codepoints/1)
    |> Enum.reduce(%{}, fn(letter, acc) -> Map.update(acc, letter, 1, &(&1 + 1))end)
    |> Enum.sort(&compare_map_elements/2)
    |> Enum.map(fn {letter, _} -> to_string(letter) end)
    |> Enum.join
    |> Kernel.binary_part(0,5)
  end

  # tiebreaker, alphabetical order if counts are the same
  def compare_map_elements({letter1,count1},{letter2,count2}) when count1 == count2 do
    letter1<letter2
  end

  # true if the count of the first letter is > the count of the second. produces a reverse sort.
  def compare_map_elements({letter1,count1},{letter2,count2}) do
    count1>count2
  end
end
