defmodule TwoFactorAuth do
  @moduledoc """
  Documentation for TwoFactorAuth.
  """

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve
  end

  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.each(&process(&1))

    TwoFactorAuthAgent.get_total
  end

  def process(input) when is_binary(input) do
    input
    |> String.split
    |> process
  end

  def process(["rect", pos]) do
    pos
    |> String.split("x")
    |> fill_rectangle
  end

#rotate row y=A by B
  def process(["rotate","row","y="<>row,"by",qty]) do
    rotate_row(row,qty)
  end

  #rotate column x=1 by 1
  def process(["rotate","column","x="<>col,"by",qty]) do
    rotate_col(col,qty)
  end

  def fill_rectangle([x,y]) do
    TwoFactorAuthAgent.fill_rectangle(x,y)
  end

  def rotate_row(row,qty) do
    TwoFactorAuthAgent.rotate_row(row,qty)
  end

  def rotate_col(col,qty) do
    TwoFactorAuthAgent.rotate_col(col,qty)
  end

end
