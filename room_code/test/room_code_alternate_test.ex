defmodule RoomCodeAlternateTest do
  use ExUnit.Case
  doctest RoomCodeAlternate

  test "example 1" do
    input = "ULL\nRRDDD\nLURDL\nUUUUD"
    assert RoomCodeAlternate.solve(input) == "5DB3"
  end
end
