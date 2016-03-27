defmodule OtherStringsTest do
  use ExUnit.Case
  doctest Strings

  test "nice for simple input part 2" do
    assert OtherStrings.nice_strings(%{filename: "test/fixtures/simple_input_2.txt"}) == 2
  end

  test "xyxy has repeating pair" do
    assert OtherStrings.has_repeating_pair?("xyxy") == true
  end

  test "aaa does not have repeating pair" do
    assert OtherStrings.has_repeating_pair?("aaa") == false
  end

  test "aba has pair with one between" do
    assert OtherStrings.has_pair_with_one_between?("aba") == true
  end

  test "xxyxx is nice" do
    assert OtherStrings.has_repeating_pair?("xxyxx") == true
    assert OtherStrings.has_pair_with_one_between?("xxyxx") == true
    assert OtherStrings.is_nice?("xxyxx") == true
  end

  test "nice for advent of code input part 2" do
    assert OtherStrings.nice_strings(%{filename: "test/fixtures/advent_of_code_input.txt"}) == 51
  end

end
