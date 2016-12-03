defmodule BlocksTest do
  use ExUnit.Case
  doctest Blocks

  test "example 1" do
    assert 1 + 1 == 2
    input = "R2, L3"
    assert Blocks.calculate_distance(input) == 5
  end

  test "example 2" do
    input = "R2, R2, R2"
    assert Blocks.calculate_distance(input) == 2
  end

  test "example 3" do
    input = "R5, L5, R5, R3"
    assert Blocks.calculate_distance(input) == 12
  end

  test "example 4" do
    input = "R5, R5, R5, R5"
    assert Blocks.calculate_distance(input) == 0
  end

  test "example 5" do
    input = "L3, L3, L3, L3"
    assert Blocks.calculate_distance(input) == 0
  end

end
