defmodule CorruptionChecksum do

  # Part 1

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> solve
  end

  def solve(input) when is_binary(input) do
    input
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&difference/1)
    |> Enum.sum
  end

  def difference(input) when is_binary(input) do
    input |> String.split |> Enum.map(&parse/1) |> difference
  end

  def difference(input) when is_list(input) do
    Enum.max(input) - Enum.min(input)
  end

  def parse(x) do
   {result,_} = Integer.parse(x)
   result
  end

  # Part 2

   def process do
    {:ok, input} = File.read("input.txt")
    input |> process
  end

  def process(input) when is_binary(input) do
    input
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&quotient/1)
    |> Enum.sum
  end

  def quotient(input) when is_binary(input) do
    input
    |> String.split
    |> Enum.map(&parse/1)
    |> Enum.sort
    |> Combination.combine(2)
    |> Enum.map(&quotient/1)
    |> Enum.sum                       # Note 1
  end

  # Note 1: Since only one pair of numbers in each line divides evenly, adding up all the results will return only that quotient


  # If the two numbers divide evenly, return the quotient, otherwise zero
  def quotient([first,second]) do
    if rem(first,second) == 0 do
      div(first,second)
    else
      0
    end
  end
end
