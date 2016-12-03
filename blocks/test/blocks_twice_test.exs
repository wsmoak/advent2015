defmodule BlocksTwiceTest do
  use ExUnit.Case
  doctest BlocksTwice

  test "example 1" do
    input = "R8, R4, R4, R8"
    assert BlocksTwice.calculate_distance(input) == 4
  end

  test "example 2" do
    input = "R3, R1, R1, R2"
    assert BlocksTwice.calculate_distance(input) == 2
  end

  test "example 3" do
    input = "L3, L1, L1, L2"
    assert BlocksTwice.calculate_distance(input) == 2
  end

end
