defmodule ElephantTest do
  use ExUnit.Case
  doctest Elephant

  test "example 1" do
    assert Elephant.solve(5) == 3
  end

  test "example 2" do
    assert Elephant.solve(10) == 5
  end

  test "example 3" do
    assert Elephant.solve(25) == 19
  end

  test "example 4" do
    assert Elephant.solve(50) == 37
  end

end
