defmodule TwoStepsForwardTest do
  use ExUnit.Case
  doctest TwoStepsForward

  test "example 1" do
    assert TwoStepsForward.solve("ihgpwlah") == "DDRRRD"
  end

  test "example 2" do
    assert TwoStepsForward.solve("kglvqrro") == "DDUDRLRRUDRD"
  end

  test "example 3" do
    assert TwoStepsForward.solve("ulqzkmiv") == "DRURDRUDDLLDLUURRDULRLDUUDDDRR"
  end

end
