defmodule Timing do
  @moduledoc """
  Documentation for Timing.
  """

  defstruct starting_tick: nil, disc_number: nil, positions_count: nil, current_position: nil

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.trim |> solve
  end

  def solve(input) do
    IO.puts "Initial position: "
    initial = input
    |> String.split("\n")
    |> Enum.map(&initial/1)
    |> IO.inspect

    IO.puts "Solution: "
    Stream.iterate(1,&(&1+1))
    |> Stream.map( &transform(&1,initial) )
    |> Stream.filter(&all_zero?(&1))
    |> Enum.take(1)
  end

  def initial(input) when is_binary(input) do
    input |> String.split([" ","#","."]) |> initial
  end

  def initial(["Disc", "", disc_num, "has", num_positions, "positions;", "at", "time=0,", "it", "is", "at", "position", initial_pos, ""]) do

    %Timing{ disc_number: parse(disc_num), positions_count: parse(num_positions), current_position: parse(initial_pos), starting_tick: nil }
  end

  def parse(num) when is_binary(num) do
    {answer, _} = Integer.parse(num)
    answer
  end

  def transform(starting_tick, input) when is_list(input) do
    input
    |> Enum.map(fn item -> %{item | starting_tick: starting_tick, current_position: rem( (item.current_position + starting_tick + item.disc_number), item.positions_count  ) } end )
  end

  def all_zero?(input) when is_list(input) do
    total = input
    |> Enum.map( fn item -> item.current_position end )
    |> Enum.sum

    total == 0
  end
end
