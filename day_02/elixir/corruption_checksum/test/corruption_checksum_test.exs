defmodule CorruptionChecksumTest do
  use ExUnit.Case
  doctest CorruptionChecksum

  test "the difference for 5 1 9 5 is 8" do
    assert CorruptionChecksum.difference("5 1 9 5") == 8
  end

  test "the difference for 7 5 3 is 4" do
    assert CorruptionChecksum.difference("7 5 3") == 4
  end

  test "the difference for 2 4 6 8 is 6" do
    assert CorruptionChecksum.difference("2 4 6 8") == 6
  end

  test "the solution is 18" do
    input = "5 1 9 5\n7 5 3\n2 4 6 8"

    assert CorruptionChecksum.solve(input) == 18
  end

  test "the quotient for 5 9 2 8 is 4" do
    assert CorruptionChecksum.quotient("5 9 2 8") == 4
  end

  test "the solution is 9" do
    input = "5 9 2 8\n9 4 7 3\n3 8 6 5"

    assert CorruptionChecksum.process(input) == 9
  end
end
