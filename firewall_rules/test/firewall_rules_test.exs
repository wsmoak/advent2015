defmodule FirewallRulesTest do
  use ExUnit.Case
  doctest FirewallRules

  test "Example 1" do
    assert FirewallRules.solve("5-8\n0-2\n4-7") == 3
  end
end
