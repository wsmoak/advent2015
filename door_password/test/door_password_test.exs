defmodule DoorPasswordTest do
  use ExUnit.Case
  doctest DoorPassword

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "first hash starting with 0000" do
    DoorPassword.hash
  end
end
