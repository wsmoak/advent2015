defmodule CompressionFormatPart2 do

  # Initial solution with duplicating the strings would never finish,
  # even though I was keeping the length-so-far and not attempting to
  # decrypt the entire thing.  Got it after reading some hints in:
  # https://www.reddit.com/r/adventofcode/comments/5hbygy/2016_day_9_solutions/

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve
  end

  def solve(input) do
    process(input)
  end

  def process(input) when is_binary(input) do
    input
    |> String.split(~r{\(.*?\)}, include_captures: true, parts: 2)
    |> process
  end

  def process([first]) do
    String.length(first)
  end

  def process([first, command, rest]) do
    String.length(first) + process(command, rest)
  end

  def process(command, input) when is_binary(command) and is_binary(input) do
    [_,num_chars,num_times,_] = String.split(command, ["(","x",")"])
    process(num_chars, num_times, input)
  end

  def process(num_chars, num_times, input) when is_binary(num_chars) and is_binary(num_times) do
    {a,_} = Integer.parse(num_chars)
    {b,_} = Integer.parse(num_times)
    process(a,b,input)
  end

  def process(num_chars, num_times, input) when is_integer(num_chars) and is_integer(num_times) do
    {first, rest} = String.split_at(input, num_chars)

    ( num_times * process(first) ) + process(rest)
  end
end
