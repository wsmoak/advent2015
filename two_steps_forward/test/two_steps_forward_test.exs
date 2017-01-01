defmodule TwoStepsForwardTest do
  use ExUnit.Case
  doctest TwoStepsForward

  @tag :skip # part 1
  test "example 1" do
    assert TwoStepsForward.solve("ihgpwlah") == "DDRRRD"
  end

  @tag :skip # part 1
  test "example 2" do
    assert TwoStepsForward.solve("kglvqrro") == "DDUDRLRRUDRD"
  end

  @tag :skip # part 1
  test "example 3" do
    assert TwoStepsForward.solve("ulqzkmiv") == "DRURDRUDDLLDLUURRDULRLDUUDDDRR"
  end

  test "example 4" do
    assert TwoStepsForward.solve("ihgpwlah") == 370
  end

  test "example 5" do
    assert TwoStepsForward.solve("kglvqrro") == 492
  end

  test "example 6" do
    assert TwoStepsForward.solve("ulqzkmiv") == 830
  end

end
