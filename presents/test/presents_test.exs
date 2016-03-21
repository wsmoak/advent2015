defmodule PresentsTest do
  use ExUnit.Case
  doctest Presents

  test "paper amount for 2x3x4 present" do
    assert Presents.paper_amount(2,3,4) == 58
  end

  test "paper amount for 1x1x10 present" do
    assert Presents.paper_amount(1,1,10) == 43
  end

  test "paper amount for simple input" do
    assert Presents.paper_amount(%{filename: "test/fixtures/simple_input.txt"}) == 58+43
  end

  test "paper amount for advent of code input" do
    assert Presents.paper_amount(%{filename: "test/fixtures/advent_of_code_input.txt"}) == 1588178
  end

  test "ribbon amount for 2x3x4 present" do
    assert Presents.ribbon_amount(2,3,4) == 34
  end

  test "ribbon amount for 1x1x10 present" do
    assert Presents.ribbon_amount(1,1,10) == 14
  end

  test "ribbon amount for simple input" do
    assert Presents.ribbon_amount(%{filename: "test/fixtures/simple_input.txt"}) == 34 + 14
  end

 test "ribbon amount for advent of code input" do
    assert Presents.ribbon_amount(%{filename: "test/fixtures/advent_of_code_input.txt"}) == 3783758
  end

end
