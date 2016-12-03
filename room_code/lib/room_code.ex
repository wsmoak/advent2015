defmodule RoomCode do
  @moduledoc """
  Advent of Code 2016 Day 2 Part 1
  """

  def solve(input) do
    input
    |> String.split
    |> Enum.reduce([], &process/2)
    |> Enum.reverse
    |> Enum.join
  end

  @doc """
  Starting from the most recent button, follow the instructions.
  If there is nothing in the list of buttons, start on 5

  Examples:

      iex> RoomCode.process("ULL", [])
      [1]

      iex> RoomCode.process("RRDDD", [1])
      [9, 1]

      iex> RoomCode.process("LURDL", [9, 1])
      [8, 9, 1]

      iex> RoomCode.process("UUUUD", [8, 9, 1])
      [5, 8, 9, 1]
  """
  def process(element, accum) do
    IO.puts "process called with #{element} and #{inspect accum}"
    element
    |> String.to_char_list
    |> Enum.reduce( start_from(accum) ,&move/2)
    |> update(accum)
  end

  def start_from([]),   do: 5
  def start_from(list), do: hd(list)

  # Build up the list of codes in reverse order, so that the most recent one is easy to access with hd/1
  def update(next, accum) do
    [next] ++ accum
  end

  # > Enum.each('UDLR', &IO.puts/1 )
  # define character codes as module attributes
  @up 85
  @down 68
  @left 76
  @right 82

  def move(@left,  1), do: 1
  def move(@right, 1), do: 2
  def move(@up,    1), do: 1
  def move(@down,  1), do: 4

  def move(@left,  2), do: 1
  def move(@right, 2), do: 3
  def move(@up,    2), do: 2
  def move(@down,  2), do: 5

  def move(@left,  3), do: 2
  def move(@right, 3), do: 3
  def move(@up,    3), do: 3
  def move(@down,  3), do: 6

  def move(@left,  4), do: 4
  def move(@right, 4), do: 5
  def move(@up,    4), do: 1
  def move(@down,  4), do: 7

  def move(@left,  5), do: 4
  def move(@right, 5), do: 6
  def move(@up,    5), do: 2
  def move(@down,  5), do: 8

  def move(@left,  6), do: 5
  def move(@right, 6), do: 6
  def move(@up,    6), do: 3
  def move(@down,  6), do: 9

  def move(@left,  7), do: 7
  def move(@right, 7), do: 8
  def move(@up,    7), do: 4
  def move(@down,  7), do: 7

  def move(@left,  8), do: 7
  def move(@right, 8), do: 9
  def move(@up,    8), do: 5
  def move(@down,  8), do: 8

  def move(@left,  9), do: 8
  def move(@right, 9), do: 9
  def move(@up,    9), do: 6
  def move(@down,  9), do: 9

end
