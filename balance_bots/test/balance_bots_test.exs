defmodule BalanceBotsTest do
  use ExUnit.Case
  doctest BalanceBots

  test "example1" do
    input = "value 2 goes to bot 156"
    BalanceBots.process(input)
  end

  test "example 2" do
    input = "bot 37 gives low to bot 114 and high to bot 150"
    BalanceBots.process(input)
  end

  test "example 3" do
    input = "bot 134 gives low to output 11 and high to bot 31"
    BalanceBots.process(input)
  end
end
