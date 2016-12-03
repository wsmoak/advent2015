defmodule Triangles do
  @moduledoc """
  Documentation for Triangles.
  """

  def count_valid(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&valid?/1)
    |> Enum.count
  end

  @doc """
      iex> Triangles.valid?("  810  679   10")
      false

      iex> Triangles.valid?([5, 10, 25])
      false

      iex> Triangles.valid?([5,4,3])
      true

  """
  def valid?(input) when is_binary(input) do
    input
    |> String.split
    |> valid?
  end

  def valid?([a,b,c]) when is_binary(a) and is_binary(b) and is_binary(c) do
    {first, _} = Integer.parse(a)
    {second, _} = Integer.parse(b)
    {third, _} = Integer.parse(c)
    valid?([first, second, third])
  end

  def valid?([a,b,c]) when is_integer(a) and is_integer(b) and is_integer(c) and a <= b and b <= c do
    a + b > c
  end

  def valid?(input) when is_list(input) do
    input
    |> Enum.sort
    |> valid?
  end

end
