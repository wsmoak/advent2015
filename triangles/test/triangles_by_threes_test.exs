defmodule TrianglesByThreesTest do
  use ExUnit.Case
  doctest TrianglesByThrees

  test "example 1" do
    input = "  810  679   10\n  783  255  616\n  545  626  626\n84  910  149\n  607  425  901\n  556  616  883"

    assert TrianglesByThrees.count_valid(input) == 5
  end
end
