defmodule StringsTest do
  use ExUnit.Case
  doctest Strings

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "aaa has three vowels" do
    assert Strings.has_three_vowels?("aaa") == true
  end

  test "ugknbfddgicrmopn is nice" do
    assert Strings.is_nice?("ugknbfddgicrmopn") == true
  end

  test "aaa is nice" do
    assert Strings.is_nice?("aaa") == true
  end

  test "jchzalrnumimnmhp is naughty" do
    assert Strings.is_nice?("jchzalrnumimnmhp") == false
  end

  test "haegwjzuvuyypxyu is naughty" do
    assert Strings.is_naughty?("haegwjzuvuyypxyu") == true
    assert Strings.is_nice?("haegwjzuvuyypxyu") == false
  end

  test "dvszwmarrgswjxmb is naughty" do
    assert Strings.is_nice?("dvszwmarrgswjxmb") == false
  end

  test "nice for simple input" do
    assert Strings.nice_strings(%{filename: "test/fixtures/simple_input.txt"}) == 2
  end

  test "nice for advent of code input" do
    assert Strings.nice_strings(%{filename: "test/fixtures/advent_of_code_input.txt"}) == 236
  end

end
