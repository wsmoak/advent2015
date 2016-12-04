defmodule RoomsTest do
  use ExUnit.Case
  doctest Rooms

  test "example 1" do
    input = "aaaaa-bbb-z-y-x-123[abxyz]\na-b-c-d-e-f-g-h-987[abcde]\nnot-a-real-room-404[oarel]\ntotally-real-room-200[decoy]"
    assert Rooms.process(input) == 1514
  end
end
