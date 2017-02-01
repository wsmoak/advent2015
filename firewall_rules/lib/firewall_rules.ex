defmodule FirewallRules do
  @moduledoc """
  Documentation for FirewallRules.
  """

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.trim |> solve
  end

  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1,"-"))
    |> Enum.sort(fn([a,b],[x,y]) -> Integer.parse(a) < Integer.parse(x) end)
    |> Enum.each( &FirewallRules.Agent.put/1 )

    # integer stored in agent is the end of the last range, add 1
    FirewallRules.Agent.get + 1
  end
end
