defmodule BlocksTwice do
  @moduledoc """
  Advent of Code 2016 Day 1 Part 2
  """

  # accum is [facing_direction, distance_north_or_south_from_start, distance_east_or_west_from_start, locations_already_visited]
  def calculate_distance(input) do
    input
    |> String.split(", ")
    |> Enum.reduce_while(["N",0,0,[]], &count/2)
    |> answer
  end

  def answer([_,ns,ew,_]) do
    IO.puts "Answer is #{abs(ns)} + #{abs(ew)}"
    abs(ns) + abs(ew)
  end

  @doc """
  Matches on the direction to turn and the distance to walk.
  Matches on the direction you are facing.
  Returns the new facing direction and the distances from the start, and the list of visited locations
  ## Examples

      iex> BlocksTwice.count("R2", ["N", 0, 0, []])
      {:cont, ["E", 0, 2, [{0,2},{0,1}] ] }

      iex> BlocksTwice.count("R2", ["N", 0, 0, [{0,1}]])
      {:halt, ["E", 0, 1, [{0,1}]]}

  """
  def count("R0", ["N", ns, ew, visited]) do
    IO.puts "Facing N, turn right to E"
    {:cont, ["E", ns, ew, visited] }
  end

  def count("R0", ["E", ns, ew, visited]) do
    IO.puts "Facing E, turn right to S"
    {:cont, ["S", ns, ew, visited] }
  end

  def count("R0", ["S", ns, ew, visited]) do
    IO.puts "Facing S, turn right to W"
    {:cont, ["W", ns, ew, visited] }
  end

  def count("R0", ["W", ns, ew, visited]) do
    IO.puts "Facing W, turn right to N"
    {:cont, ["N", ns, ew, visited] }
  end

  # turn and move 1 and check whether we have visited that spot yet, but if not, stay facing the original direction so we can continue
  def count("R" <> distance, ["N", ns, ew, visited]) do
    {value, _} = Integer.parse(distance)
    ew = ew + 1
    IO.puts "Visiting #{ns}, #{ew}"
    if Enum.member?(visited, {ns,ew}) do
      {:halt, ["E", ns, ew, visited]}
    else
      count("R" <> to_string(value - 1), ["N", ns, ew, [{ns, ew}] ++ visited])
    end
  end

  def count("R" <> distance, ["E", ns, ew, visited]) do
    {value, _} = Integer.parse(distance)
    ns = ns - 1
    IO.puts "Visiting #{ns}, #{ew}"
    if Enum.member?(visited, {ns, ew}) do
      {:halt, ["S", ns, ew, visited]}
    else
      count("R" <> to_string(value - 1), ["E", ns, ew, [{ns, ew}] ++ visited])
    end
  end

  def count("R" <> distance, ["S", ns, ew, visited]) do
    {value, _} = Integer.parse(distance)
    ew = ew - 1
    IO.puts "Visiting #{ns}, #{ew}"
    if Enum.member?(visited, {ns, ew}) do
      {:halt, ["W", ns, ew, visited]}
    else
      count("R" <> to_string(value-1), ["S", ns, ew, [{ns,ew}] ++ visited])
    end
  end


  def count("R" <> distance, ["W", ns, ew, visited]) do
    {value, _} = Integer.parse(distance)
    ns = ns + 1
    IO.puts "Visiting #{ns}, #{ew}"
    if Enum.member?(visited, {ns, ew}) do
      {:halt, ["N", ns, ew, visited]}
    else
      count("R" <> to_string(value-1), ["W", ns, ew, [{ns,ew}] ++ visited])
    end
  end

  def count("L0", ["N", ns, ew, visited]) do
    IO.puts "Facing N, turn left to W"
    {:cont, ["W", ns, ew, visited] }
  end
  def count("L0", ["W", ns, ew, visited]) do
    IO.puts "Facing W, turn left to S"
    {:cont, ["S", ns, ew, visited] }
  end
  def count("L0", ["S", ns, ew, visited]) do
    IO.puts "Facing S, turn left to E"
    {:cont, ["E", ns, ew, visited] }
  end
  def count("L0", ["E", ns, ew, visited]) do
    IO.puts "Facing E, turn left to N"
    {:cont, ["N", ns, ew, visited] }
  end

  def count("L" <> distance, ["N", ns, ew, visited]) do
    {value, _} = Integer.parse(distance)
    ew = ew - 1
    IO.puts "Visiting #{ns}, #{ew}"
    if Enum.member?(visited, {ns, ew}) do
      {:halt, ["W", ns, ew, visited]}
    else
      count("L" <> to_string(value-1), ["N", ns, ew, [{ns,ew}] ++ visited])
    end
  end

  def count("L" <> distance, ["E", ns, ew, visited]) do
    {value, _} = Integer.parse(distance)
    ns = ns + 1
    IO.puts "Visiting #{ns}, #{ew}"
    if Enum.member?(visited, {ns, ew}) do
      {:halt, ["N", ns, ew, visited]}
    else
      count("L" <> to_string(value-1), ["E", ns, ew, [{ns,ew}] ++ visited])
    end
  end

  def count("L" <> distance, ["S", ns, ew, visited]) do
    {value, _} = Integer.parse(distance)
    ew = ew + 1
    IO.puts "Visiting #{ns}, #{ew}"
    if Enum.member?(visited, {ns, ew}) do
      {:halt, ["E", ns, ew, visited]}
    else
      count("L" <> to_string(value-1), ["S", ns, ew, [{ns,ew}] ++ visited])
    end
  end

  def count("L" <> distance, ["W", ns, ew, visited]) do
    {value, _} = Integer.parse(distance)
    ns = ns - 1
    IO.puts "Visiting #{ns}, #{ew}"
    if Enum.member?(visited, {ns, ew}) do
      {:halt, ["S", ns, ew, visited]}
    else
      count("L" <> to_string(value-1), ["W", ns, ew, [{ns,ew}] ++ visited])
    end
  end

end
