defmodule RepetitionCode do
  @moduledoc """
  Documentation for RepetitionCode.
  """

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve
  end

  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&Enum.with_index/1)
    |> List.flatten
    |> Enum.group_by(&elem(&1,1), &elem(&1,0)) # returns a map keyed by position, with each value being a list of characters
    |> Enum.map(&find_most_frequent_char/1)
    |> Enum.map(&elem(&1,0))
    |> Enum.join
  end

  def solve_part_2 do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve_part_2
  end

  def solve_part_2(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&Enum.with_index/1)
    |> List.flatten
    |> Enum.group_by(&elem(&1,1), &elem(&1,0)) # returns a map keyed by position, with each value being a list of characters
    |> Enum.map(&find_least_frequent_char/1)
    |> Enum.map(&elem(&1,0))
    |> Enum.join
  end


  def find_most_frequent_char({position, letters}) do
    letters
    |> Enum.reduce(%{}, fn char, map -> Map.update(map, char, 1, &(&1+1)) end) # count occurrences of each character
    |> Enum.sort(fn {letter1,count1},{letter2,count2} -> count1>count2  end ) # sort by descending count
    |> hd # take the first one
  end

  def find_least_frequent_char({position, letters}) do
    letters
    |> Enum.reduce(%{}, fn char, map -> Map.update(map, char, 1, &(&1+1)) end) # count occurrences of each character
    |> Enum.sort(fn {letter1,count1},{letter2,count2} -> count1<count2  end ) # sort by descending count
    |> hd # take the first one
  end
end
