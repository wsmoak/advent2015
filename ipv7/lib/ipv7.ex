defmodule Ipv7 do
  @moduledoc """
  Documentation for Ipv7.
  """

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

  def solve_part_2 do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve_part_2
  end

  def solve_part_2(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&supports_ssl?/1)
    |> Enum.count
  end

  def supports_ssl?(input) do
    inside = Regex.scan(~r"\[(.*?)\]", input) |> Enum.map( fn([_x,y]) -> y end)
    outside = Regex.split(~r"\[(.*?)\]", input)
    abas = get_abas(outside)
    babs = Enum.map(abas, &convert_to_bab/1)
    # now we have a list of bab's that we need to check against the list of 'inside' strings
    answers = for x <- inside, y <- babs, do: String.contains?(x,y)
    # this produces a list like [true, false, false, true]
    Enum.any?(answers,&(&1))
  end

  def get_abas(input) when is_list(input) do
    input
    |> Enum.map(&get_abas/1)
    |> IO.inspect
    |> List.flatten
    |> Enum.filter(&(&1)) # remove the nil values
    |> IO.inspect
  end

  def get_abas(input) when is_binary(input) do
    substrings = for n <- 0..String.length(input), do: String.slice(input,n..n+2)

    substrings
    |> IO.inspect
    |> Enum.map(&is_aba/1)
    |> IO.inspect
    |> Enum.filter(&(&1)) # remove the nil values
    |> IO.inspect
  end

  def is_aba(<<a,b,a>>) when a != b, do: List.to_string([a,b,a])
  def is_aba(_), do: nil

  def convert_to_bab(<<a,b,a>>), do: List.to_string([b,a,b])
  def convert_to_bab(_), do: nil

end
