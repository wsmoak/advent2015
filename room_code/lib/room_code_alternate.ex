defmodule RoomCodeAlternate do
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

      iex> RoomCodeAlternate.process("ULL", [])
      [5]

      iex> RoomCodeAlternate.process("RRDDD", [5])
      ["D", 5]

      iex> RoomCodeAlternate.process("LURDL", ["D", 5])
      ["B", "D", 5]

      iex> RoomCodeAlternate.process("UUUUD", ["B", "D", 5])
      [3, "B", "D", 5]
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

#     1
#   2 3 4
# 5 6 7 8 9
#   A B C
#     D

  # define the possible moves
  def move(@down,  1), do: 3

  def move(@right, 2), do: 3
  def move(@down,  2), do: 6

  def move(@up,    3), do: 1
  def move(@right, 3), do: 4
  def move(@down,  3), do: 7
  def move(@left,  3), do: 2

  def move(@down,  4), do: 8
  def move(@left,  4), do: 3

  def move(@right, 5), do: 6

  def move(@up,    6), do: 2
  def move(@right, 6), do: 7
  def move(@down,  6), do: "A"
  def move(@left,  6), do: 5

  def move(@up,    7), do: 3
  def move(@right, 7), do: 8
  def move(@down,  7), do: "B"
  def move(@left,  7), do: 6

  def move(@up,    8), do: 4
  def move(@right, 8), do: 9
  def move(@down,  8), do: "C"
  def move(@left,  8), do: 7

  def move(@left,  9), do: 8

  def move(@up,    "A"), do: 6
  def move(@right, "A"), do: "B"

  def move(@up,    "B"), do: 7
  def move(@right, "B"), do: "C"
  def move(@down,  "B"), do: "D"
  def move(@left,  "B"), do: "A"

  def move(@up,   "C"), do: 8
  def move(@left, "C"), do: "B"

  def move(@up,   "D"), do: "B"

  # if a move isn't defined, stay on the same button
  def move(_, value), do: value

  def translate(@up), do: "up"
  def translate(@down), do: "down"
  def translate(@left), do: "left"
  def translate(@right), do: "right"
end
