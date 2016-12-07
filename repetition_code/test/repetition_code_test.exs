defmodule RepetitionCodeTest do
  use ExUnit.Case
  doctest RepetitionCode

  @input "eedadn\ndrvtee\neandsr\nraavrd\natevrs\ntsrnev\nsdttsa\nrasrtv\nnssdts\nntnada\nsvetve\ntesnvt\nvntsnd\nvrdear\ndvrsen\nenarar"


  test "example 1" do
    assert RepetitionCode.solve(@input) == "easter"
  end

  test "example 2" do
    input = "abi\ndqc\ndbf\nghi"

    assert RepetitionCode.solve(input) == "dbi"
  end

  test "part 2" do
    assert RepetitionCode.solve_part_2(@input) == "advent"
  end
end
