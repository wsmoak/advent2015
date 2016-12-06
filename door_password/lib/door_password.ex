defmodule DoorPassword do
  @moduledoc """
  Documentation for DoorPassword.
  """
  @input "cxdnnyjw"

  def solve_part_2 do
    Stream.iterate(1,&(&1+1))
    |> Stream.map(&concat(&1))
    |> Stream.map(&hash/1)
    |> Stream.filter(&test(&1))
    |> Stream.filter(&test_for_position(&1))
    |> Stream.uniq_by(&String.at(&1,5))
    |> Enum.take(8)
    |> Enum.sort
    |> Enum.map(&String.at(&1,6))
    |> Enum.join
  end

  def solve do
    Stream.iterate(1,&(&1+1))
    |> Stream.map(&concat(&1))
    |> Stream.map(&hash/1)
    |> Stream.filter(&test(&1))
    |> Enum.take(8)
    |> Enum.map(&String.at(&1,5))
    |> Enum.join
  end

  def concat(number) do
    @input <> to_string(number)
  end

  def hash(input) do
    input |> :erlang.md5 |> Base.encode16
  end

  def test(input) do
    input |> String.starts_with?("00000")
  end

  def test_for_position(input) do
    Enum.member?( ["0","1","2","3","4","5","6","7","8"], String.at(input,5) )
  end
end
