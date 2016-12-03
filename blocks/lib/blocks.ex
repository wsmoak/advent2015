defmodule Blocks do
  @moduledoc """
  Advent of Code 2016 Day 1
  """

  # accum is [facing_direction, distance_north_or_south_from_start, distance_east_or_west_from_start]
  def calculate_distance(input) do
    input
    |> String.split(", ")
    |> Enum.reduce(["N",0,0], &count/2)
    |> answer
  end

  def answer([_,ns,ew]) do
    IO.puts "Answer is #{abs(ns)} + #{abs(ew)}"
    abs(ns) + abs(ew)
  end

  @doc """
  Matches on the direction to turn and the distance to walk.
  Matches on the direction you are facing.
  Returns the new facing direction and the distances from the start
  ## Examples

      iex> Blocks.count("R2", ["N", 0, 0])
      ["E",0,2]

  """
  def count("R" <> distance, ["N", ns, ew]) do
    IO.puts "Facing N, turn right to E, walk #{distance}"
    {value, _} = Integer.parse(distance)
    ["E", ns, ew + value]
  end

  def count("R" <> distance, ["E", ns, ew]) do
    IO.puts "Facing E, turn right to S, walk #{distance}"
    {value, _} = Integer.parse(distance)
    ["S", ns - value, ew]
  end

  def count("R" <> distance, ["S", ns, ew]) do
    IO.puts "Facing S, turn right to W, walk #{distance}"
    {value, _} = Integer.parse(distance)
    ["W", ns , ew - value]
  end

  def count("R" <> distance, ["W", ns, ew]) do
    IO.puts "Facing W, turn right to N, walk #{distance}"
    {value, _} = Integer.parse(distance)
    ["N", ns + value, ew]
  end

  def count("L" <> distance, ["N", ns, ew]) do
    IO.puts "Facing N, turn left to W, walk #{distance}"
    {value, _} = Integer.parse(distance)
    ["W", ns, ew - value]
  end

  def count("L" <> distance, ["E", ns, ew]) do
    IO.puts "Facing E, turn left to N, walk #{distance}"
    {value, _} = Integer.parse(distance)
    ["N", ns + value, ew]
  end

  def count("L" <> distance, ["S", ns, ew]) do
    IO.puts "Facing S, turn left to E, walk #{distance}"
    {value, _} = Integer.parse(distance)
    ["E", ns , ew + value]
  end

  def count("L" <> distance, ["W", ns, ew]) do
    IO.puts "Facing W, turn left to S, walk #{distance}"
    {value, _} = Integer.parse(distance)
    ["S", ns - value, ew]
  end

end
