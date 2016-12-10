defmodule Ipv7 do
  @moduledoc """
  Documentation for Ipv7.
  """
  # part 1: not 108

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve
  end

  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&supports_tls?/1)
    |> Enum.count
  end

  def supports_tls?(input) do
    inside = Regex.scan(~r"\[(.*?)\]", input) |> Enum.map( fn([_x,y]) -> y end)
    outside = Regex.split(~r"\[(.*?)\]", input)
    !has_abba?(inside) && has_abba?(outside)
  end

  # Does any string in a list have a sequence like abba?
  def has_abba?(input) when is_list(input) do
    input
    |> Enum.any?(&has_abba?/1)
  end

  # Does a single string have a sequence like abba in it?
  def has_abba?(input) when is_binary(input) do
    # for each substring, does it start with a sequence like abba?
    substrings = for n <- 0..String.length(input), do: String.slice(input,n..n+3)

    substrings
    |> Enum.any?(&starts_with_abba?/1)
  end

  # Does a string start with a sequence like abba?
  def starts_with_abba?(<<x, y, y, x, _rest::binary>>) when x != y, do: true
  def starts_with_abba?(_), do: false
end
