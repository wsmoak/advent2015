defmodule RogueTest do
  use ExUnit.Case
  doctest Rogue

  test "example 1" do
    assert Rogue.solve(".^^.^.^^^^",10) == 38
  end
end
