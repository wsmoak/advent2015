defmodule CompressionFormat do
  @moduledoc """
  Documentation for CompressionFormat.
  """

  def solve do
   CompressionFormat.Agent.reset

    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve
  end

  def solve(input) do
    process(input)

    CompressionFormat.Agent.get_length
  end


  def process(input) when is_binary(input) do
    input
    |> String.split(~r{\(.*?\)}, include_captures: true, parts: 2)
    |> process
  end

  def process([first]) do
    CompressionFormat.Agent.put(first)
  end

  def process([first, command, rest]) do
    CompressionFormat.Agent.put(first) # if it's not an empty string?
    process(command, rest)
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

    CompressionFormat.Agent.put( String.duplicate(first, num_times) )

    process(rest)
  end
end
