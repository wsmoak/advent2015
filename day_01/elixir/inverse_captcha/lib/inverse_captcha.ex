defmodule InverseCaptcha do
  @moduledoc """
  Advent of Code 2017 Day 01
  """

  # Part 1

  def process do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> process
  end

  def process(input) when is_binary(input) do
    input = String.codepoints(input)

    first = hd(input)
    last = input |> tl |> Enum.reverse |> hd
    final_str = if first == last do first else "0" end
    {final, _} = Integer.parse(final_str)

    IO.puts "final is #{final}"

    process(input, final)
  end

  # this is called with the entire array of characters
  # and the accumulator which is initialized with the first/final value if they match
  def process(input, accum) when is_list(input) do
    process(hd(input), tl(input), accum)
  end

  # This is the last character in the file
  def process(char, [], accum) do
   IO.puts "last one is " <> char
   IO.puts "accum is #{accum}"
   accum
  end

  def process(char, rest, accum) do
    IO.puts "checking " <> char
    # compare char to hd(rest)
    {value, _} = Integer.parse(char)
    {next, _} = Integer.parse(hd(rest))

    accum = accum + if value == next do value else 0 end

    IO.puts "accum is #{accum}"
    process(hd(rest), tl(rest), accum)
  end

  # Part 2

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve
  end

  def solve(input) when is_binary(input) do
    input = String.codepoints(input)
    length = length(input)
    half = length/2 |> round

    first_half = Enum.slice(input,0,half)
    second_half = Enum.slice(input,half,half)

    solve(first_half, second_half, 0)
  end

  # base case, we've worked down both lists
  # since comparing the second half to the first half would have the same result, double it
  def solve([],[],accum) do
    accum * 2
  end

  # otherwise, compare the first element in each half and update the accumulator,
  # then repeat for the rest (tail) of each half
  def solve(first_half, second_half, accum) do
    {first_value, _} = Integer.parse(hd(first_half))
    {second_value, _} = Integer.parse(hd(second_half))

    accum = accum + if first_value == second_value do first_value else 0 end
    solve(tl(first_half), tl(second_half), accum)
  end
end
