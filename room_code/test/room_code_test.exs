defmodule RoomCodeTest do
  use ExUnit.Case
  doctest RoomCode

  test "example 1" do
    input = "ULL\nRRDDD\nLURDL\nUUUUD"
    assert RoomCode.solve(input) == "1985"
  end
end
