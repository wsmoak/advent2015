defmodule LightsTest do
  use ExUnit.Case
  doctest Lights

#  test "turning on a light" do
#    assert :ok == GenServer.call(LightsWorker, {:turn_on, 1, 1} )
#  end

#  test "turning on 9 lights" do
#    input = "turn on 0,0 through 2,2"
#    Lights.Worker.process(input)
#   assert Lights.Worker.count == 9
#  end

#  test "turning on all the lights" do
#    input = "turn on 0,0 through 999,999"
#   Lights.Worker.process(input)
#    assert Lights.Worker.count == 1_000_000
# end

#  test "the Advent of Code input file" do
#    Lights.Worker.process( %{filename: "input.txt"} )
#    assert Lights.Worker.count == 569_999
#  end

  test "the Advent of Code input file for Part 2" do
    Lights.BrightnessWorker.process( %{filename: "input.txt"} )
    assert Lights.BrightnessWorker.count == 17_836_115
  end

end
